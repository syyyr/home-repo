#!/bin/bash
export DISPLAY=:0.0


udevadm monitor -k  | while IFS= read -r line;
do

    if [ -z "$(grep "/devices/pci0000:00/0000:00:02\.0/drm/card0" <<< $line)" ]; then
        continue
    fi

    OUTPUT=$(xrandr | grep -o "^.* connected" | grep -v "eDP-1" | sed 's/ connected//')
    echo $OUTPUT
    if [ -z $OUTPUT ]; then
        xrandr --output DP-1 --off
        xrandr --output DP-2 --off
        xrandr --output eDP-1 --primary
    else
        xrandr --output $OUTPUT --right-of eDP-1 --auto --primary
        nitrogen --restore
    fi
done
