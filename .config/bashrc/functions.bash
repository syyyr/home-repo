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

git_cmp()
{
    nvim -d "$1" <(git show HEAD:"$1") -c "let g:git_cmp_ft = &ft | windo let &ft = g:git_cmp_ft"
}

if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
    _js_commands="node npm npx nvm"
    _lazy_nvm()
    {
        echo
        echo -n "Loading nvm..."
        unalias $_js_commands
        source /usr/share/nvm/nvm.sh
        source /usr/share/nvm/install-nvm-exec
        source /usr/share/nvm/bash_completion
        echo " done."
        if [[ $# -ge 1 ]]; then
            local command=$1
            shift
            $command $@
        fi
    }

    for cmd in $_js_commands; do
        alias $cmd="_lazy_nvm $cmd"
    done

    __nvm()
    {
        _lazy_nvm
        echo "You may press TAB again for completion."
    }

    complete -o default -F __nvm nvm
fi
