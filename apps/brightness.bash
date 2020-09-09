#!/bin/bash
# TODO: python gives me some errors, I don't know why

toWeighted()
{
    python -c "import math;print(math.sqrt(math.pow(${1},3))*0.099+1)"
}

toUnweighted()
{
    python -c "import math;print(math.pow(math.pow(((${1}-1)/0.099),1/3),2))"
}

round()
{
    echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
}

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
        ;;
    max)
        if [[ $UP || $DOWN ]]; then
            echo "Doesn't make sense to use up or down with max together."
            exit 1
        else
            MAX='1'
        fi
        ;;
    min)
        if [[ $UP || $DOWN ]]; then
            echo "Doesn't make sense to use up or down with min together."
            exit 1
        else
            MIN='1'
        fi
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

if [[ $(round $(light) 0) -le '2'  && -n  $DOWN ]]; then
    light -S 1
    unset DOWN
fi

if [ $DOWN ]; then
    for i in `seq $DOWN`;do
        CURRENT=$(toUnweighted $(light))
        NEW=$(toWeighted $(python -c  "print($CURRENT-5)"))
        light -S $NEW
    done
    if [ ! $QUIET ]; then echo "Lowering brightness by $((DOWN*5))%"; fi
fi
if [ $UP ]; then
    for i in `seq $UP`;do
        CURRENT=$(toUnweighted $(light))
        NEW=$(toWeighted $(python -c  "print($CURRENT+5)"))
        light -S $NEW
    done
    if [ ! $QUIET ]; then echo "Raising brightness by $((UP*5))%"; fi
fi

if [ $MAX ]; then
    light -S 100
fi

if [ $MIN ]; then
    light -S 1
fi
if [ $QUIET ]; then
    exit 0
fi

BRIGHT=$(light)
BRIGHT=$(toUnweighted $BRIGHT)
BRIGHT=$(bc -l <<< $BRIGHT/5)
BRIGHT=$(round $BRIGHT 0)
BRIGHT=$(bc -l <<< $BRIGHT*5)

echo "Brightness: $BRIGHT"%

if [ $SILENT ]; then
    exit 0
fi

BRIGHTNESS_IMG="$HOME/.local/share/icons/blue/brightness.png"
ARGS='-t 2000 -R /tmp/brightness-not-id'
ARGS+=" -h string:image_path:$BRIGHTNESS_IMG"
notify-send $ARGS 'Brightness' "$BRIGHT"%
