alias :q="exit"
alias bashrc="nvim ~/.bashrc"
alias cd..="cd .."
alias c="git clone"
alias crypto="run-parts ~/apps/crypto"
alias email="vim -S ~/.config/writing.vim"
alias explorer="taskkill -f explorer.exe; cmd explorer& exit"
alias fvim='vim `fzf`'
alias get_screen="xclip -se c -o -target image/png"
alias geth="screen -d -m geth --rpc"
alias grep='grep --color=auto'
alias i3config="nvim ~/.config/i3/config"
alias l='ls -CF'
alias la='ls -A'
alias league="startx $HOME/.config/leaguerc"
alias ll='ls -alF'
alias ls='ls --color=auto'
alias makec="make clean"
alias maket="make test"
alias man="vman"
alias pacman="pacman --color=auto"
alias realnano="/bin/nano"
alias rm="rm -I"
alias screenoffx="screenoff;exit"
alias se="sudoedit"
alias shutr="shutdown -r"
alias shuts="shutdown -s"
alias sl="ls"
alias sr="screen -r"
alias steamX="startx $HOME/.config/steamrc"
alias vim="nvim -p $VIMOPTIONS"
alias 🤔="cat ~/apps/thinking"
for i in {1..64}; do
    alias make$i="make -j$i"
done; unset i;
