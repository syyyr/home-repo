#!/bin/bash
export DISPLAY=:0.0


udevadm monitor -k | while IFS= read -r line;
do

    if [ -z "$(grep -F "/devices/pci0000:00/0000:00:02.0/drm/card0 (drm)" <<< $line)" ]; then
        continue
    fi

    OUTPUT=$(xrandr | grep -o "^.* connected" | grep -v "eDP1" | sed 's/ connected//')
    echo $OUTPUT
    if [ -z $OUTPUT ]; then
        xrandr --output DP1 --off
        xrandr --output DP2 --off
        xrandr --output eDP1 --primary
    else
        xrandr --output $OUTPUT --right-of eDP1 --auto --primary
        i3 "workspace 2; move workspace to output $OUTPUT"
        i3 "workspace 3; move workspace to output $OUTPUT"
        i3 "workspace 4; move workspace to output $OUTPUT"
        i3 "workspace 6; move workspace to output eDP1"
        i3 "workspace 5; move workspace to output eDP1"
        i3 "workspace 1; move workspace to output $OUTPUT"
        nitrogen --restore
    fi
done
