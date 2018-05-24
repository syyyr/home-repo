#!/bin/bash
if [ $# != 1 ]; then 
    exit 1
fi
PARSED_JSON="$(jq '.messages | map(.timestamp,.sender_name,.content)[]' $1)"
FIXED_UNICODE="$(ftfy <<< "$PARSED_JSON")"

TIMESTAMPS="$(awk 'NR % 3 == 1' <<< $FIXED_UNICODE)"
SENDERS="$(awk 'NR % 3 == 2' <<< $FIXED_UNICODE)"
MESSAGES="$(awk 'NR % 3 == 0' <<< $FIXED_UNICODE)"
#echo "$TIMESTAMPS"
#echo "$SENDERS"
#echo "$MESSAGES"

for stamp in $TIMESTAMPS; do
    DATES+="$(date --date="@$stamp" '+%d.%m.%Y %H:%M')"
    DATES+=$'\n'

done
DATES=$(sed -e s/^/\[/ -e 's/$/\]/' <<< "$DATES")

SENDERS=$(sed -e 's/^"//' -e 's/"$//' <<< "$SENDERS")
SENDERS=$(sed 's/$/:/' <<< "$SENDERS")
MESSAGES=$(sed -e 's/^"//' -e 's/"$//' <<< "$MESSAGES")

RES=$(paste -d' ' <(echo "$DATES") <(echo "$SENDERS") <(echo "$MESSAGES"))
echo "$RES"
