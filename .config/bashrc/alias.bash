#!/bin/bash

source /usr/share/bash-complete-alias/complete_alias
alias agit="git"
alias arch-clone="cd \$HOME/git/arch-packages && pkgctl repo clone --protocol https"
alias aur-srcinfo='makepkg --printsrcinfo > .SRCINFO'
alias calc="python -q"
# shellcheck disable=SC2139
alias {cago,catgo}='cargo'
# shellcheck disable=SC2139
alias {d,dc,scd}='cd'
# shellcheck disable=SC2139
alias {cd..,dc..,d..}='cd ..'
alias cd,,='cd ..'
alias cdp='cd -P'
alias cpu='cat /proc/cpuinfo | grep "MHz"'
alias ctest='ctest --output-on-failure'
alias cuw='cargo update --workspace'
alias dicker='docker'
alias explorer='taskkill -f explorer.exe; cmd "start /B explorer"& exit'
alias ffplay='ffplay -autoexit'
alias free='free -h'
alias get_screen='xclip -se c -o -target image/png'
alias grep='grep --color=auto'
alias i3config-status="nvim \$HOME/.config/i3status/config"
alias i3config="nvim \$HOME/.config/i3/config"
alias icat="kitty +kitten icat"
alias ivm="nvim"
alias svim="nvim"
alias krc="nvim \$HOME/.config/kitty/custom.conf"
alias l='ls -CF'
alias la='ls -A'
alias lah='ls -lah'
alias ll='ls -alF'
alias ls='ls --color=auto --hyperlink=auto'
alias makec='make clean'
alias no-lid='systemd-inhibit --what=handle-lid-switch --who="Command line lid switch blocker" --why='\''User typed "no-lid" in a terminal'\'' --mode=block sleep infinity'
alias rsync='rsync --progress'
alias se='sudoedit'
alias shvspy='shvspy -v RpcMsg'
alias sl='ls'
alias sr='screen -r'
alias super-clippy='cargo clippy -- -D clippy::pedantic -D clippy::nursery'
alias vim='nvim'
alias w='watch'
alias watch='watch -n1'
alias x86_64-w64-mingw32-wine='LC_ALL=C x86_64-w64-mingw32-wine'
alias 🤔="cat \$HOME/apps/thinking"
eval 'i='{1..64}'; alias make$i="make -j$i";'
alias makejn="nice --adjustment 19 make -j\$(nproc)"
alias makej="make -j\$(nproc)"
alias maekj="makej"
alias makje="makej"
alias mkaje="makej"

alias adog='git adog'
br() {
    git switch -C "$(git branch --contains HEAD | sed -r 's@[^/]*/(.*)\)$@\1@')"
}
alias c='git clone --recurse-submodules'
alias fetch='git fetch'
alias pull='git pull'
alias push='git push'
alias reflog='git reflog'
alias show='git show'
complete -F _complete_alias "${!BASH_ALIASES[@]}"
