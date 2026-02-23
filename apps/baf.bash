nohup bash -c 'sleep "$((RANDOM % 60))"; while true; do notify-send BAF; sleep 600; done' &> /dev/null &
