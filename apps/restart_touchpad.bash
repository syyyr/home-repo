#!/bin/bash
sudo rmmod psmouse
sudo modprobe psmouse
sleep 1
xinput set-prop "Synaptics TM2668-002" "libinput Natural Scrolling Enabled" 1
xinput set-prop "Synaptics TM2668-002" "libinput Tapping Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
