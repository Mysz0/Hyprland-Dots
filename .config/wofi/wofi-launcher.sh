#!/bin/zsh

# Check if wofi is already running
if pgrep -x wofi > /dev/null; then
    pkill wofi
    exit 0
fi

# Launch the appropriate script based on the argument
case "$1" in
    wallpaper)
        $HOME/.config/wofi/wallpaper.sh &
        ;;
    emoji)
        $HOME/.config/wofi/emoji.sh &
        ;;
    clipboard-show)
        $HOME/.config/wofi/clipboard.sh show &
        ;;
    clipboard-delete)
        $HOME/.config/wofi/clipboard.sh delete &
        ;;
    wifi)
        $HOME/.config/wofi/wifi.sh &
        ;;
    cheatsheet)
        $HOME/.config/wofi/cheatsheet.sh &
        ;;
    scrcpy)
        $HOME/.config/wofi/scrcpy.sh &
        ;;
    radio)
        $HOME/.config/wofi/radio.sh &
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
esac

