#!/bin/bash

# Set the source and destination directories
SOURCE_DIR=~/Hyprland-Dots/.config/
DEST_DIR=~/.config/

# List of directories to handle
DIRS=("btop" "hypr" "neofetch" "tmux" "wlogout" "cava" "kitty" "nvim" "waybar" "wofi")

# Loop through each directory
for dir in "${DIRS[@]}"; do
    # If the destination directory exists
    if [ -d "$DEST_DIR$dir" ]; then
        # Rename the old directory to <dir>.old
        echo "Renaming $DEST_DIR$dir to $DEST_DIR$dir.old"
        mv "$DEST_DIR$dir" "$DEST_DIR$dir.old"
    else
        echo "$DEST_DIR$dir does not exist. Creating a new folder."
    fi

    # Create a new directory and copy the config files from the source
    mkdir -p "$DEST_DIR$dir"
    echo "Copying files from $SOURCE_DIR$dir to $DEST_DIR$dir"
    cp -r "$SOURCE_DIR$dir"/* "$DEST_DIR$dir/"

    echo "$dir setup completed."
    echo "---------------------"
done

echo "All directories have been processed."

