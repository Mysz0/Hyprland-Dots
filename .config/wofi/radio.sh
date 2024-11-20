#!/bin/sh

# Add more args here according to preference
ARGS="--no-video"

notification(){
    # Notify the user of the current stream being played
    # Change the icon to whatever you want. Make sure your notification server 
    # supports it and is already configured.
    notify-send "Playing now: " "$@" --icon=media-tape --app-name Radio
}

# Number of the stream as per the $choice variable
# Name of the stream
# Additional tag to filter similar types of streams

menu(){
    printf "1. Lofi Girl\n"
    printf "2. Chillhop\n"
    printf "3. The Bootleg Boy\n"
    printf "4. Radio Spinner\n"
}

get_choice() {
    # Auto-detect and use wofi for Wayland and rofi for X11
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        # Use wofi with the provided CSS file for styling
        choice=$(menu | wofi --show dmenu --style "$HOME/.config/wofi/menu.css")
    else
        echo "Unsupported session type: $XDG_SESSION_TYPE"
        exit 1
    fi
    echo "$choice"
}

main() {
    choice=$(get_choice)

    case "$choice" in
        "1. Lofi Girl")
            notification "Lofi Girl ☕️🎶"
            URL="https://youtu.be/jfKfPfyJRdk"
            ADDITIONAL_ARGS="--volume=60"
            ;;
        "2. Chillhop")
            notification "Chillhop ☕️🎶"
            URL="https://youtu.be/7NOSDKb0HlU"
            ADDITIONAL_ARGS="--volume=60"
            ;;
        "3. The Bootleg Boy")
            notification "The Bootleg Boy ☕️🎶"
            URL="https://youtu.be/ib5UdLEyURs"
            ADDITIONAL_ARGS="--volume=60"
            ;;
        "4. Radio Spinner")
            notification "Radio Spinner ☕️🎶"
            URL="https://live.radiospinner.com/lofi-hip-hop-64"
            ADDITIONAL_ARGS="--volume=60"
            ;;
        *)
            echo "Invalid choice"
            exit 1
            ;;
    esac

    # Run mpv with args and selected URL
    # Added title arg to make sure the pkill command kills only this instance of mpv
    mpv $ARGS --title="radio-mpv" $URL $ADDITIONAL_ARGS
}

# Kill any existing instance of the script before starting a new one
pkill -f radio-mpv || main

