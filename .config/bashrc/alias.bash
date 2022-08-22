alias :q='exit'
alias calc="python -q"
alias cd..='cd ..'
alias cdp='cd -P'
alias ctest='ctest --output-on-failure'
alias cpu='cat /proc/cpuinfo | grep "MHz"'
alias d='cd'
alias dc='cd'
alias email="vim -S $HOME/.config/writing.vim"
alias explorer='taskkill -f explorer.exe; cmd "start /B explorer"& exit'
alias free='free -h'
alias fvim='vim `fzf`'
alias get_screen='xclip -se c -o -target image/png'
alias grep='grep --color=auto'
alias i3config-status="nvim $HOME/.config/i3status/config"
alias ivm="nvim"
alias l='ls -CF'
alias la='ls -A'
alias league="startx $HOME/.config/leaguerc"
alias ll='ls -alF'
alias ls='ls --color=auto'
alias makec='make clean'
alias maket='make test'
alias pacman='pacman --color=auto'
alias realnano='/bin/nano'
alias screenoffx='screenoff;exit'
alias se='sudoedit'
alias shutr='shutdown -r'
alias shuts='shutdown -s'
alias sl='ls'
alias sr='screen -r'
alias steamX="startx $HOME/.config/steamrc"
alias vim='nvim'
alias 🤔="cat $HOME/apps/thinking"
for i in {1..64}; do
    alias "make$i"="make -j$i"
done; unset i;
alias makej="make -j$(nproc)"

alias add='git add'
alias adog='git adog'
alias branch='git branch'
alias c='git clone'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit'
alias fetch='git fetch'
alias log='git log'
alias pull='git pull'
alias push='git push'
alias rebase='git rebase'
alias reflog='git reflog'
alias restore='git restore'
alias show='git show'
alias stash='git stash'
alias status='git status'
alias switch='git switch'
