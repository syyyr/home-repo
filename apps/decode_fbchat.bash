{
    for i in message_*.json; do
        jq . "$i"  | iconv -f utf-8 -t latin1 |
            jq -r '.messages |
            map(
                    (.timestamp_ms / 1000 | localtime | strftime("%d. %m. %Y %H:%M:%S\t")) +
                    .sender_name + ":\t" +
                    (if .content then
                    (.content | gsub("\n"; "NEW_LINE"))
                    elif .gifs then
                        "sent a GIF."
                    elif .photos then
                        "sent a photo."
                    else "<unsent message>" end) ) | .[] '
    done
} | tac > temp_decoded
awk '
BEGIN { FS="	"; OFS="  " }
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


