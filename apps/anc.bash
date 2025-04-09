#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

echo -n "Switching ANC mode... "
while pbpctrl set anc cycle-next |& grep 'Error: Bluetooth operation not permitted: UUID already registered' &> /dev/null; do
	echo "failed." 1>&2
	echo -n "Trying again... " 1>&2
	sleep 1
done

py3-cmd refresh 'external_script pixel-buds'
echo "done."
