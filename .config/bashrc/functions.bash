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
    nvim -d "$(git rev-parse --show-toplevel)/$1" <(git show HEAD:"$1") -c "let g:git_cmp_ft = &ft | windo let &ft = g:git_cmp_ft"
}

if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
    _js_commands="node npm npx nvm"
    _lazy_nvm()
    {
        echo
        echo -n "Loading nvm..." >&1
        unalias $_js_commands
        source /usr/share/nvm/nvm.sh
        source /usr/share/nvm/install-nvm-exec
        source /usr/share/nvm/bash_completion
        echo " done." >&1
        if [[ $# -ge 1 ]]; then
            local command=$1
            shift
            $command $@
        fi
        source /usr/share/bash-completion/completions/npm
        complete -o default -F _npm_completion npm
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
    complete -o default -F __nvm npm
fi

obedy()
{
    local restaurace
    for restaurace in "$HOME/bin/blox" "$HOME/bin/country" "$HOME/bin/husa"; do
        if [[ -x "$restaurace" ]]; then
            $restaurace $1
            echo
        fi
    done
}

gso()
{
    while true; do
        case $1 in
            -a)
                local OPEN_ALL="1"
                shift
                ;;
            -i)
                local CASE="-i"
                shift
                ;;
            -ai)
                local CASE="-i"
                local OPEN_ALL="1"
                shift
                ;;
            -ia)
                local CASE="-i"
                local OPEN_ALL="1"
                shift
                ;;
            *)
                break
                ;;
        esac
    done

    if [[ $# -gt 1 ]] && [[ -d "${@: -1}" || -r "${@: -1}" ]]; then
        local ARGS="${*:1:$#-1}"
        local DIRECTORY=${@: -1}
    else
        local ARGS="$*"
    fi

    # local is a command by itself, so first define local FILE and then assign,
    # so that the return code belongs to fzf
    local FILE
    local RESULTS="$(grep $CASE -Hrn --color=always "$ARGS" $DIRECTORY)"
    if [[ "$RESULTS" = "" ]]; then
        echo "No match." >&1
        return 0
    fi
    if (("$OPEN_ALL")); then
        nvim -q <(strip-ansi <<< "$RESULTS")
        return 0
    fi
    FILE="$(fzf -0 --height=50% --border --ansi <<< "$RESULTS")"
    case "$?" in
        0)
            local VIM_ARG="$(sed -E 's/([^:]+):([^:]+):.*/\1 +\2/' <<< "$FILE")"
            vim $VIM_ARG
            ;;
        1)
            echo "fzf: No match. This shouldn't happen." >&1
            ;;
        2)
            echo "fzf: Error." >&1
            ;;
        130)
            ;;
        *)
            echo "error." >&1
    esac
}

string_diff()
{
    dwdiff -c <(echo "$1") <(echo "$2")
}
