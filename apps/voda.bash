#!/bin/bash
if ! grep -F "$(date +%F)" $HOME/.local/share/voda/db > /dev/null; then
    echo $(date +%F) 1 > $HOME/.local/share/voda/db
else
    LOL="$(grep -Eo "[0-9]+$" $HOME/.local/share/voda/db)"
    if [[ $# = 0 ]]; then
        echo $(date +%F) $((LOL+1)) > $HOME/.local/share/voda/db
    else
        echo $(date +%F) $((LOL-1)) > $HOME/.local/share/voda/db
    fi
fi
LOL="$(grep -Eo "[0-9]+$" $HOME/.local/share/voda/db)"
echo Máš $((LOL)). vodu. To je $((LOL))*200 ml = $(((LOL)*200)) ml.
echo Takže ještě $((10-LOL)) vod do 2 l.
