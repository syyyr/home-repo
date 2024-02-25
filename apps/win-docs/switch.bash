#!/bin/bash

SVCL="$HOME/Documents/opt/soundvolumeview-x64/svcl.exe"

"$SVCL" /GetColumnValue 'NVIDIA High Definition Audio\Device\2460G4\Render' 'Item ID' |
	tr -s '\n' |
	tr -d '\r' |
	parallel --quote --verbose "$SVCL" /SwitchDefault {} 'Realtek(R) Audio\Device\Reproduktory\Render' all
