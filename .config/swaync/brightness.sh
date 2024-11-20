#!/bin/bash
# Script for Monitor backlights using brightnessctl on NVIDIA device

iDIR="$HOME/.config/swaync/icons"
notification_timeout=1000
step=10  # INCREASE/DECREASE BY THIS VALUE

# Set brightness device to `nvidia_0`
device="nvidia_0"

# Get brightness
get_backlight() {
	brightnessctl -d "$device" -m | cut -d, -f4 | sed 's/%//'
}

# Get icons based on brightness level
get_icon() {
	current=$(get_backlight)
	if   [ "$current" -le "20" ]; then
		icon="$iDIR/brightness-20.png"
	elif [ "$current" -le "40" ]; then
		icon="$iDIR/brightness-40.png"
	elif [ "$current" -le "60" ]; then
		icon="$iDIR/brightness-60.png"
	elif [ "$current" -le "80" ]; then
		icon="$iDIR/brightness-80.png"
	else
		icon="$iDIR/brightness-100.png"
	fi
}

# Notify user of brightness change
notify_user() {
	notify-send -e -h string:x-canonical-private-synchronous:brightness_notif -h int:value:$current -u low -i "$icon" "Brightness : $current%"
}

# Change brightness level
change_backlight() {
	local current_brightness
	current_brightness=$(get_backlight)

	# Calculate new brightness
	if [[ "$1" == "+${step}%" ]]; then
		new_brightness=$((current_brightness + step))
	elif [[ "$1" == "${step}%-" ]]; then
		new_brightness=$((current_brightness - step))
	fi

	# Ensure new brightness is within valid range
	if (( new_brightness < 5 )); then
		new_brightness=5
	elif (( new_brightness > 100 )); then
		new_brightness=100
	fi

	brightnessctl -d "$device" set "${new_brightness}%"
	get_icon
	current=$new_brightness
	notify_user
}

# Handle script arguments
case "$1" in
	"--get")
		get_backlight
		;;
	"--inc")
		change_backlight "+${step}%"
		;;
	"--dec")
		change_backlight "${step}%-"
		;;
	*)
		get_backlight
		;;
esac

