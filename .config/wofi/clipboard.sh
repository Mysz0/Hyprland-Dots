#!/bin/bash

# Set the path for the clipboard history storage
HISTORY_FILE="$HOME/.cache/cliphist.txt" # Change to desired path
STYLE_FILE="$HOME/.config/wofi/menu.css"

# Check if cliphist is running; if not, start it
if ! pgrep -x "cliphist" > /dev/null; then
    echo "Starting cliphist..."
    cliphist store &   # Start cliphist store to listen for clipboard changes
fi

# Function to display clipboard history using wofi
show_history() {
    # Get the list of clipboard items in reverse order, without the ID
    CLIPBOARD_HISTORY=$(cliphist list -n -1 | cut -f2-) # -n -1 gets all items, latest to oldest

    # Add "Clear All" at the top of the list
    CLIPBOARD_HISTORY="Clear All\n$CLIPBOARD_HISTORY"

    # Use wofi to display the clipboard history previews and capture the selected item
    SELECTED_PREVIEW=$(echo -e "$CLIPBOARD_HISTORY" | wofi --show dmenu --prompt "Select an item:" --style "$STYLE_FILE")

    # Check if "Clear All" was selected
    if [[ "$SELECTED_PREVIEW" == "Clear All" ]]; then
        cliphist wipe
        notify-send "Clipboard Cleared" "All clipboard history has been wiped." --app-name Settings --icon=settings
        return
    fi

    # Check if a selection was made
    if [[ -n "$SELECTED_PREVIEW" ]]; then
        # Find the original full text in cliphist using the selected preview
        SELECTED_ITEM_FULL=$(cliphist list | grep -F "$SELECTED_PREVIEW" | cliphist decode)

        # Copy the selected full text to the clipboard
        wl-copy <<< "$SELECTED_ITEM_FULL"
        
        # Prepare the notification text (up to 50 characters)
        NOTIFY_TEXT=$(echo "$SELECTED_ITEM_FULL" | cut -c1-50)
        [[ ${#SELECTED_ITEM_FULL} -gt 50 ]] && NOTIFY_TEXT+="..."

        # Display notification with shortened text
        notify-send "Ready to paste" "$SELECTED_PREVIEW" --app-name Settings --icon=settings
    else
        echo "No item selected."
    fi
}

# Function to delete an item from clipboard history using wofi
delete_item() {
    # Get the list of clipboard items in reverse order, without the ID
    CLIPBOARD_HISTORY=$(cliphist list -n -1 | cut -f2-) # -n -1 gets all items, latest to oldest

    # Add "Clear All" at the top of the list
    CLIPBOARD_HISTORY="Clear All\n$CLIPBOARD_HISTORY"

    # Use wofi to display the clipboard history previews and capture the selected item to delete
    SELECTED_PREVIEW=$(echo -e "$CLIPBOARD_HISTORY" | wofi --show dmenu --prompt "Select an item to delete:" --style "$STYLE_FILE")

    # Check if "Clear All" was selected
    if [[ "$SELECTED_PREVIEW" == "Clear All" ]]; then
        cliphist wipe
        notify-send "Clipboard Cleared" "All clipboard history has been wiped." --app-name Settings --icon=settings
        return
    fi

    # Check if a selection was made
    if [[ -n "$SELECTED_PREVIEW" ]]; then
        # Find and delete the item using cliphist
        cliphist list | grep -F "$SELECTED_PREVIEW" | cliphist delete
        notify-send "Item Deleted" "Deleted \"$SELECTED_PREVIEW\" from clipboard history." --app-name Settings --icon=settings
    else
        echo "No item selected."
    fi
}

# Main menu
case "$1" in
    "show")
        show_history
        ;;
    "delete")
        delete_item
        ;;
    *)
        echo "Usage: $0 {show|delete}"
        exit 1
        ;;
esac
