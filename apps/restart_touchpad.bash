#!/bin/bash
sudo rmmod i2c_i801
sudo modprobe i2c_i801
sleep 1
xinput set-prop "Synaptics TM2668-002" "libinput Natural Scrolling Enabled" 1
xinput set-prop "Synaptics TM2668-002" "libinput Tapping Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
