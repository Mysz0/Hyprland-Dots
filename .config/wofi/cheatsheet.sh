#!/bin/bash

# Path to the keybindings config file
keybinds_conf="$HOME/.config/hypr/configs/keybinds.conf"
menu_css="$HOME/.config/wofi/menu.css"

# Ensure the keybinds config file exists
if [ ! -f "$keybinds_conf" ]; then
    echo "Keybindings file not found!"
    exit 1
fi

# Ensure the wofi menu.css exists
if [ ! -f "$menu_css" ]; then
    echo "wofi menu.css file not found! Make sure to place it at $menu_css."
    exit 1
fi

# Function to convert keybinding names to human-readable format
convert_keybinding() {
    # Replace key names with human-readable formats
    local key="$1"
    key="${key//Mod4/Super}"        # Replace Mod4 with Super
    key="${key//Shift/Shift + }"    # Add space after Shift
    key="${key//Ctrl/Control}"      # Replace Ctrl with Control
    key="${key//Alt/Alt}"           # Replace Alt with Alt
    key="${key//+ / +}"             # Fix spacing after +

    # Escape ampersand characters
    key="${key//&/&amp;}"           # Escape & to &amp;

    echo "$key"
}

# Read keybindings from the config file, filter and convert to readable format
keybindings=$(grep -E 'bind' "$keybinds_conf" | awk -F'=' '{print $2}' | sed 's/,/ /g')

# If no keybindings found
if [ -z "$keybindings" ]; then
    echo "No keybindings found in the config."
    exit 1
fi

# Convert keybindings to human-readable format
readable_keybindings=""
while read -r keybinding; do
    readable_keybindings+=$(convert_keybinding "$keybinding")$'\n'
done <<< "$keybindings"

# Display the list of keybindings using wofi and get the selected one
# Use wofi --dmenu to preserve order and display the keybinding list
selected=$(echo "$readable_keybindings" | wofi --dmenu --prompt "Select Keybinding" --style "$menu_css")

# Check if the user selected something
if [ -n "$selected" ]; then
    echo "You selected: $selected"
else
    echo "No selection made."
fi

