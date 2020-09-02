for streamer in avenitoo liquidwifi lonesome_dreams romii_ wa9no TheBiggestChibi; do
    (
    if streamlink --twitch-disable-hosting "http://twitch.tv/$streamer" &> /dev/null; then
        echo "$streamer"
    fi
    )&
done
for job in $(jobs -p); do
    wait $job
done
