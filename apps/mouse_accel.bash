#!/bin/bash
case $1 in
off)
echo 'Section "InputClass"
	Identifier "My Mouse"
	MatchIsPointer "yes"
	Option "AccelerationProfile" "-1"
	Option "AccelerationScheme" "none"
	Option "AccelSpeed" "-1"
EndSection' | sudo tee /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
;;
on)
    sudo rm /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
    ;;
    esac
