#!/bin/bash
if [ $# != 1 ]; then
    exit 1
fi
PARSED_JSON="$(jq '.messages | map(.timestamp_ms,.sender_name,.content)[]' $1)"
echo "parsed messages.json" >&2
FIXED_UNICODE="$(ftfy <<< "$PARSED_JSON")"
echo "unicode fixed" >&2

TIMESTAMPS="$(awk 'NR % 3 == 1' <<< $FIXED_UNICODE)"
echo "timestamps done" >&2
SENDERS="$(awk 'NR % 3 == 2' <<< $FIXED_UNICODE)"
echo "senders done" >&2
MESSAGES="$(awk 'NR % 3 == 0' <<< $FIXED_UNICODE)"
echo "messages done" >&2
#echo "$TIMESTAMPS"
#echo "$SENDERS"
#echo "$MESSAGES"
for stamp in $TIMESTAMPS; do
    parsed_date="$(date --date="@${stamp::-3}" '+%d.%m.%Y %H:%M')"
    echo "$parsed_date" >&2
    DATES+="$parsed_date"
    DATES+=$'\n'
done
DATES=$(sed -e s/^/\[/ -e 's/$/\]/' <<< "$DATES")
echo dates done. processing some more. >&2

SENDERS=$(sed -e 's/^"//' -e 's/"$//' <<< "$SENDERS")
SENDERS=$(sed 's/$/:/' <<< "$SENDERS")
MESSAGES=$(sed -e 's/^"//' -e 's/"$//' <<< "$MESSAGES")

echo final paste... >&2
RES=$(paste -d' ' <(echo "$DATES") <(echo "$SENDERS") <(echo "$MESSAGES"))
echo "$RES"
echo done. >&2
