#!/bin/bash

# Path to the Wofi style file
STYLE_FILE="$HOME/.config/wofi/menu.css"

# Define fixed menu options with numbers to ensure consistent order
options="Normal Mode
Turn Screen Off
Wireless Mode
Wireless Mode (Turn Screen Off)
Kill scrcpy Server
Exit"

# Display the menu and get the user's choice
choice=$(echo -e "$options" | wofi --dmenu --prompt="Select scrcpy mode:" --style "$STYLE_FILE")

# Define actions based on the selected mode
case "$choice" in
    "Normal Mode")
        scrcpy
        ;;
    "Turn Screen Off")
        scrcpy --turn-screen-off
        ;;
    "Wireless Mode")
        # Prompt for device IP
        DEVICE_IP=$(wofi --dmenu --prompt="Enter device IP:" --style "$STYLE_FILE")
        if [[ -n "$DEVICE_IP" ]]; then
            adb tcpip 5555
            adb connect "$DEVICE_IP"
            scrcpy
        else
            notify-send "scrcpy Wireless Mode" "No IP entered. Aborting." --app-name Settings --icon=settings
        fi
        ;;
    "Wireless Mode (Turn Screen Off)")
        # Prompt for device IP
        DEVICE_IP=$(wofi --dmenu --prompt="Enter device IP:" --style "$STYLE_FILE")
        if [[ -n "$DEVICE_IP" ]]; then
            adb tcpip 5555
            adb connect "$DEVICE_IP"
            scrcpy --turn-screen-off
        else
            notify-send "scrcpy Wireless Mode" "No IP entered. Aborting." --app-name Settings --icon=settings
        fi
        ;;
    "Kill scrcpy Server")
        # Kill any running scrcpy server
        if pgrep -x "scrcpy" > /dev/null; then
            pkill -x "scrcpy"
            notify-send "scrcpy Server" "scrcpy server has been killed." --app-name Settings --icon=settings
        else
            notify-send "scrcpy Server" "No scrcpy server running." --app-name Settings --icon=settings
        fi
        ;;
    "Exit")
        exit 0
        ;;
    *)
        notify-send "Invalid option" "No valid scrcpy mode selected." --app-name Settings --icon=settings
        ;;
esac

