#!/bin/bash
# TODO: fix this
touch /tmp/supress-lid-suspend
i3-nagbar -t warning -m 'Lid close suspending is suppresed for 10 seconds.' &
sleep 10
rm /tmp/supress-lid-suspend
