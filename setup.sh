#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/.config"
CONFIG_DIR="$HOME/.config"


dotfolders=(
    "Vencord"
    "btop"
    "cava"
    "hypr"
    "kitty"
    "neofetch"
    "nvim"
    "spicetify"
    "swaync"
    "wal"
    "waybar"
    "waypaper"
    "wlogout"
    "wofi"
)

echo "Starting dotfile deployment (copy mode)..."
echo "Source: $DOTFILES_DIR"
echo "Target: $CONFIG_DIR"

for folder in "${dotfolders[@]}"; do
    SOURCE_PATH="$DOTFILES_DIR/$folder"
    TARGET_PATH="$CONFIG_DIR/$folder"

    if [ -d "$SOURCE_PATH" ]; then

        # Backup existing directory
        if [ -d "$TARGET_PATH" ]; then
            echo "Backing up existing $folder → $folder.bak"
            mv "$TARGET_PATH" "$TARGET_PATH.bak"
        fi

        # Ensure clean destination
        rm -rf "$TARGET_PATH"

        # Copy from repo into ~/.config
        echo "Copying $folder..."
        cp -r "$SOURCE_PATH" "$TARGET_PATH"

    else
        echo "Skipping $folder: Not found in repo"
    fi
done

echo "Done! All configs have been backed up (if needed) and copied."
