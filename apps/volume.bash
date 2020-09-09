#!/bin/bash

for arg in $@;do
case "$arg" in
    up)
        if [ $DOWN ]; then
            echo "Doesn't make sense to use up and down together."
            exit 1
        fi
        if [ $UP ]; then
            UP=$((UP+1))
        else
            UP='1'
        fi

        #amixer -q -D pulse set Master 5%+
        ;;
    down)
        if [ $UP ]; then
            echo "Doesn't make sense to use up and down together."
            exit 1
        fi
        if [ $DOWN ]; then
            DOWN=$((DOWN+1))
        else
            DOWN='1'
        fi
        #amixer -q -D pulse set Master 5%-
        ;;
    toggle)
        if [ $TOGGLE ]; then
            echo "Won't toggle more than once."
        fi

        TOGGLE='1'
        ;;
    show)
        ;;
    quiet)
        QUIET='1';
        ;;
    silent)
        SILENT='1';
        ;;
    *)
        echo "Unknown argument: $arg"
        exit 1
        ;;
esac
done

if [ $DOWN ]; then
    for i in `seq $DOWN`;do
        pactl set-sink-volume 0 -5% 2> /dev/null
        pactl set-sink-volume 1 -5% 2> /dev/null
    done
    if [ ! $QUIET ]; then echo "Lowering volume by $((DOWN*5))%"; fi
fi
if [ $UP ]; then
    for i in `seq $UP`;do
        pactl set-sink-volume 0 +5% 2> /dev/null
        pactl set-sink-volume 1 +5% 2> /dev/null
    done
    if [ ! $QUIET ]; then echo "Raising volume by $((UP*5))%"; fi
fi
if [ $TOGGLE ]; then
    pactl set-sink-mute 0 toggle
    pactl set-sink-mute 1 toggle
fi


killall -USR1 py3status

if [ $QUIET ]; then
    exit 0
fi

VOLUME_HIGH="$HOME/.local/share/icons/blue/volume-high.png"
VOLUME_MEDIUM="$HOME/.local/share/icons/blue/volume-medium.png"
VOLUME_LOW="$HOME/.local/share/icons/blue/volume-low.png"
VOLUME_MUTE="$HOME/.local/share/icons/blue/volume-mute.png"

VOL=$(pacmd list-sinks | grep -Eom1 '[[:digit:]]*%' | tail -n1)

VOLUME_IMG="$VOLUME_LOW"
if [ ${VOL//%} -ge "66" ];then
    VOLUME_IMG="$VOLUME_HIGH"
elif [ ${VOL//%} -ge "33" ];then
    VOLUME_IMG="$VOLUME_MEDIUM"
fi

if [ "$(pacmd list-sinks | head -n20 |grep -c 'muted: yes')" = "1" ];then
    MUTED="(muted)"
    VOLUME_IMG="$VOLUME_MUTE"
fi

echo "Volume: $VOL $MUTED"

if [ $SILENT ]; then
    exit 0
fi

ARGS='-t 2000 -R /tmp/vol-not-id'
ARGS+=" -h string:image_path:$VOLUME_IMG"
notify-send $ARGS "Volume" "$VOL"
