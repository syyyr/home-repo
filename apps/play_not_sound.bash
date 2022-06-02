"$HOME/apps/check_available.bash" ffplay || exit 1
ffplay "$HOME/.local/share/notification.mp3" -nodisp -autoexit
