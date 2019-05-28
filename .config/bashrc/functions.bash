wishlist()
{
    if [ -z "$@" ]; then
        cat ~/.wishlist
    else
        echo "$@" >> ~/.wishlist
        echo "$@" '>> ~/.wishlist'
    fi
}

wttr()
{
    local request="wttr.in/${1-Prague}"
    [ "$COLUMNS" -lt 125 ] && request+='?n'
    request+='?q?F'
    curl -H "Accept-Language: cs" --compressed "$request"
}

res()
{
    if [[ $# -ne 4 ]]; then
        echo usage: res "<xrandr output> <x> <y> <hz>"
        return
    fi
    echo "cvt12 $2 $3 $4 -b | tail -1 | cut -d' ' -f2- | xargs xrandr --newmode"
    cvt12 $2 $3 $4 -b | tail -1 | cut -d' ' -f2- | xargs xrandr --newmode
    echo "cvt12 $2 $3 $4 -b | tail -1 | cut -d' ' -f2 | xargs xrandr --addmode $1"
    cvt12 $2 $3 $4 -b | tail -1 | cut -d' ' -f2 | xargs xrandr --addmode $1
    echo "xrandr --output $1 --mode $(cvt12 $2 $3 $4 -b | tail -1 | cut -d' ' -f2)"
    xrandr --output $1 --mode $(tr -d '"' <<< $(cvt12 $2 $3 $4 -b | tail -1 | cut -d' ' -f2))
}
