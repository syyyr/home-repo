#!/bin/bash
export DISPLAY=:0.0


udevadm monitor -k  | while IFS= read -r line;
do

    if [ -z "$(grep "/devices/pci0000:00/0000:00:02\.0/drm/card0" <<< $line)" ]; then
        continue
    fi

    OUTPUT=$(xrandr | grep -o "^.* connected" | grep -v "eDP1" | sed 's/ connected//')
    echo $OUTPUT
    if [ -z $OUTPUT ]; then
        xrandr --output DP1 --off
        xrandr --output DP2 --off
    else
        xrandr --output $OUTPUT --left-of eDP1 --auto
        nitrogen --restore
    fi
done
