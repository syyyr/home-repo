#/bin/bash
set -euo pipefail

"$HOME/apps/check-available.bash" streamlink google-chrome-stable || return 1
if [[ $# != 1 ]]; then
    "$HOME/apps/twitch-online.bash"
    exit 0
fi
google-chrome-stable --new-window "https://www.twitch.tv/popout/$1/chat"
streamlink -v "http://twitch.tv/$1" best
