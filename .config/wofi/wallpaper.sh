#!/bin/bash

# Directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Wofi style file
STYLE_FILE="$HOME/.config/wofi/menu.css"

# Use find to select wallpapers and format the output to show a shortened path
SELECTED_WALLPAPER=$(find "$WALLPAPER_DIR" -type f -name '*.png' -o -name '*.jpg' | sed "s|^$WALLPAPER_DIR/||" | wofi --show dmenu --prompt "Select Wallpaper: " --style "$STYLE_FILE")

# Check if a wallpaper was selected
if [ -n "$SELECTED_WALLPAPER" ]; then
    # Full path to the selected wallpaper
    FULL_WALLPAPER_PATH="$WALLPAPER_DIR/$SELECTED_WALLPAPER"

    # Initialize swww if it’s not running
    if ! pgrep -x "swww-daemon" > /dev/null; then
        echo "Starting swww daemon..."
        swww init || { echo "Failed to initialize swww"; exit 1; }
    fi

    # Set wallpaper using swww with fade transition
    swww img "$FULL_WALLPAPER_PATH" --transition-type "any" --transition-fps 60 --transition-duration 2 || {
        echo "Failed to set wallpaper with swww"
        exit 1
    }

    # Run wal to apply the theme
    wal -i "$FULL_WALLPAPER_PATH"  # Set the new wallpaper with wal

    # Update kitty theme configuration
    KITTY_THEME_CONFIG="$HOME/.config/kitty/theme.conf"
    COLORS_KITTY_FILE="$HOME/.cache/wal/colors-kitty.conf"

    # Check if the wal colors file exists
    if [ -f "$COLORS_KITTY_FILE" ]; then
        cp "$COLORS_KITTY_FILE" "$KITTY_THEME_CONFIG"  # Copy wal colors to kitty theme
        echo "Kitty theme updated from wal colors."
    else
        echo "Warning: $COLORS_KITTY_FILE does not exist."
    fi

    # Update Cava configuration
    CAVA_CONFIG_SOURCE="$HOME/.cache/wal/cava"
    CAVA_CONFIG_DEST="$HOME/.config/cava/theme"

    if [ -f "$CAVA_CONFIG_SOURCE" ]; then
        cp "$CAVA_CONFIG_SOURCE" "$CAVA_CONFIG_DEST"  # Copy Cava config and rename it
        echo "Cava configuration updated."
        
        # Check if Cava is running and reload its configuration for all instances
        CAVA_PIDS=$(pgrep -x "cava")
        if [ -n "$CAVA_PIDS" ]; then
            for PID in $CAVA_PIDS; do
                kill -USR1 "$PID"  # Send SIGUSR1 to each Cava process
                echo "Cava configuration reloaded for PID: $PID."
            done
        else
            echo "Warning: Cava is not running."
        fi
    else
        echo "Warning: $CAVA_CONFIG_SOURCE does not exist."
    fi

    echo "Wallpaper changed to: $FULL_WALLPAPER_PATH"
else
    echo "No wallpaper selected."
fi

