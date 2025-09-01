#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

{
    readarray -t FILES < <(find . -name "message_?.json")
    if [[ "$(find message_*.json | wc -l)" -gt 9 ]]; then
        readarray -t -O "${#FILES[@]}" FILES < <(find . -name "message_??.json")
    fi
    for i in "${FILES[@]}"; do
        jq . "$i"  | iconv -f utf-8 -t latin1 |
            jq -r '.messages |
            map(
                    (.timestamp_ms / 1000 | localtime | strftime("%d. %m. %Y %H:%M:%S\t")) +
                    .sender_name + ":\t" + (
                        if .type == "Share" then
                            .content + " " + .share.link
                        elif .call_duration then
                            .content + " Call duration: " + (.call_duration | tostring)
                        elif .gifs then
                            if .content then .content else "sent a GIF." end
                        elif .audio_files then
                            if .content then .content else "sent an audio file." end
                        elif .photos then
                            if .content then .content else "sent a photo." end
                        elif .sticker then
                            "sent a sticker."
                        elif .videos then
                            if .content then .content else "sent a video." end
                        elif .file then
                            if .content then .content else "sent a file." end
                        elif .content then
                            (.content | gsub("\n"; "NEW_LINE"))
                        else "<unsent message>" end
                    ) + (
                        if .reactions then
                            "     (" + (.reactions | map(.actor + " reacted with " + .reaction) | join( "  ")) + ")"
                        else
                            ""
                        end
                    )
                    ) | .[] '
    done
} | tac > temp_decoded
awk '
BEGIN { FS="    "; OFS="  " }
NR==FNR {
    w = (length($2) > w ? length($2) : w)
    prefix_message = ""
    # 21 is the length of the date
    for (i=0; i < (24 + w); i++) {
        prefix_message = prefix_message " "
    }
    next
}
{
    printf "%s  %"w"s ", $1, $2, $3
    gsub("NEW_LINE", "\n" prefix_message, $3)
    printf "%s\n", $3
}
' temp_decoded temp_decoded > decoded
rm temp_decoded


