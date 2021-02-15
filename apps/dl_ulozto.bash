if [[ $# != 2 ]]; then
    echo "Usage: $0 <filename> <url>"
    exit 1
fi
FILENAME="$1"
URL="$2"
while true; do
    OUT="$(curl \
        -S \
        --silent \
        --max-time 2 \
        -C - \
        -o "$FILENAME" \
        "$URL" 2>&1)"
    RET="$?"
    case $RET in
        33 | 52)
            echo "Can't download from this link, it is possibly expired. Each link can download about 105 MB."
            break
            ;;
        28)
            RECV=$(grep -o "[0-9]* out of" <<< "$OUT" | sed 's/ out of//')
            REMAINING=$(grep -o "out of [0-9]*" <<< "$OUT" | sed 's/out of //')
            OUT=$((($REMAINING - $RECV) / 1024 / 1024))
            echo $OUT MB remaining. "(about $(($OUT / 105)) link refreshes)"
            continue
            ;;
        18)
            REMAINING=$(grep -o "[0-9]* bytes" <<< "$OUT" | sed 's/ bytes//')
            OUT=$(($REMAINING / 1024/1024))
            echo $OUT MB remaining. "(about $(($OUT / 105)) link refreshes)"
            echo Link expired, get a new link.

            break
            ;;
        0)
            echo File downloaded.
            break
            ;;
        *)
            echo curl: exit code $RET
            break
            ;;
    esac
done
