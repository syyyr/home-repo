source /usr/share/bash-complete-alias/complete_alias
alias calc="python -q"
alias cd..='cd ..'
alias cdp='cd -P'
alias cpu='cat /proc/cpuinfo | grep "MHz"'
alias ctest='ctest --output-on-failure'
alias d='cd'
alias dc='cd'
alias explorer='taskkill -f explorer.exe; cmd "start /B explorer"& exit'
alias free='free -h'
alias get_screen='xclip -se c -o -target image/png'
alias grep='grep --color=auto'
alias i3config-status="nvim $HOME/.config/i3status/config"
alias ivm="nvim"
alias l='ls -CF'
alias la='ls -A'
alias lah='ls -lah'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias makec='make clean'
alias pacman='pacman --color=auto'
alias se='sudoedit'
alias sl='ls'
alias sr='screen -r'
alias vim='nvim'
alias 🤔="cat $HOME/apps/thinking"
for i in {1..64}; do
    alias "make$i"="make -j$i"
done; unset i;
alias makej="make -j$(nproc)"

alias adog='git adog'
alias c='git clone'
alias pull='git pull'
alias push='git push'
alias reflog='git reflog'
alias show='git show'
complete -F _complete_alias "${!BASH_ALIASES[@]}"
