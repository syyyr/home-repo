#!/bin/bash
killall compton
compton --backend glx -b -C --blur-background --blur-method kawase --blur-strength 8

