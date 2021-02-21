refresh_video_url()
{
    echo -n Getting new video link...
    VIDEO_LINK="$(python3 "$LIBFILE" "$ORIGINAL_URL")"
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
    echo "Couldn't find the LIBFILE".
    echo "Default location is $(realpath "${BASH_SOURCE%/*}")/lib/get_ulozto_video_link.py".
    echo "This is the default location if you clone the whole repo."
    echo 'Alternatively, you can specify the location with the $DL_ULOZTO_LIB'
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
            break
            ;;
    esac
done
