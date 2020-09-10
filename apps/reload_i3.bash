set -eu
I3_CONFIG_DIR="$HOME/.config/i3"
I3STATUS_CONFIG_DIR="$HOME/.config/i3status"
DEVICE_NAME="$("$HOME/apps/device_name.bash")"
if [[ "$DEVICE_NAME" =~ T14s ]]; then
    DEVICE_SPECIFIC="$I3_CONFIG_DIR/t14s"
    ETHERNET='enp2s0f0'
    SECOND_BATTERY=
    DEVICE_NAME_SHORT="T14s"
elif [[ "$DEVICE_NAME" =~ T440s ]]; then
    DEVICE_SPECIFIC="$I3_CONFIG_DIR/t440s"
    ETHERNET='enp0s25'
    SECOND_BATTERY='order += "battery 1"'
    DEVICE_NAME_SHORT="T440s"
else
    echo "reload_i3: Unknown device: $DEVICE_NAME" >&2
fi

cat "$DEVICE_SPECIFIC" "$I3_CONFIG_DIR/common" > "$I3_CONFIG_DIR/config"


cat > "$I3STATUS_CONFIG_DIR/config" <<EOF
order += "keyboard_locks"
order += "volume master"
order += "wireless _first_"
order += "ethernet $ETHERNET"
order += "diskdata"
order += "lm_sensors $DEVICE_NAME_SHORT"
order += "battery 0"
$SECOND_BATTERY
order += "tztime local"
EOF

cat >> "$I3STATUS_CONFIG_DIR/config" < "$I3STATUS_CONFIG_DIR/common"

[[ $# -ne 1 ]] || [[ "$1" != "norestart" ]] && i3-msg restart
