refresh_video_url()
{
    echo -n Getting new video link...
    VIDEO_LINK="$(python3 "$LIBFILE" "$ORIGINAL_URL" 2> /dev/null)"
    if [[ "$?" -ne 0 ]]; then
        echo
        echo "Unable to get a download link. Possible reasons:" >&2
        echo "    1) You didn't specify a valid ulozto link." >&2
        echo "    2) ulozto could be blocked in your country." >&2
        echo "    3) Your computer is so slow, that it took more than 10 seconds to load the ulozto webpage. In that case, open
       $LIBFILE and try to increase the timeout inside the waitForElem function." >&2
        exit 1
    fi
    echo " done."
}

get_outfile_size()
{
    stat --printf="%s" "$FILENAME"
}

get_remaining()
{
    echo "$(("$TARGET_FILESIZE" - $(get_outfile_size)))"
}

B_to_MB()
{
    echo "$(($1 / 1024 / 1024)) MB"
}

if [[ $# != 2 ]]; then
    echo "Usage: $0 <filename> <ulozto-url>"
    exit 1
fi
FILENAME="$1"
ORIGINAL_URL="$2"

if [[ -n "$DL_ULOZTO_LIB" ]]; then
    LIBFILE="$DL_ULOZTO_LIB"
elif pushd "${BASH_SOURCE%/*}/" > /dev/null && [[ -f lib/get_ulozto_video_link.py ]]; then
    LIBFILE="$(realpath "lib/get_ulozto_video_link.py")"
    popd > /dev/null
else
    echo "Couldn't find the LIBFILE". >&2
    echo "Default location is $(realpath "${BASH_SOURCE%/*}")/lib/get_ulozto_video_link.py". >&2
    echo "This is the default location if you clone the whole repo." >&2
    echo 'Alternatively, you can specify the location with the $DL_ULOZTO_LIB.' >&2
    exit 1
fi

echo Downloading "$ORIGINAL_URL"

refresh_video_url
TARGET_FILESIZE="$(curl -sI "$VIDEO_LINK" | awk '/Content-Length/{print $2}' | tr -d '\r')"
echo "File size: $(B_to_MB "$TARGET_FILESIZE")"

echo Download started.

while true; do
    OUT="$(curl \
        -S \
        --silent \
        --max-time 2 \
        -C - \
        -o "$FILENAME" \
        "$VIDEO_LINK" 2>&1)"
    RET="$?"
    case $RET in
        28)
            echo "$(B_to_MB "$(get_remaining)")" remaining.
            ;;
        18 | 33)
            echo $(B_to_MB "$(get_remaining)") remaining.
            echo Link expired.
            refresh_video_url
            echo Download resumed.
            ;;
        0)
            echo File downloaded.
            break
            ;;
        *)
            echo curl: exit code $RET
            echo "$OUT"
            echo "$RET" >> ~/dl_ulozto.log
            echo "$OUT" >> ~/dl_ulozto.log
            ;;
    esac
done
