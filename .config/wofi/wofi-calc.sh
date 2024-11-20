#!/bin/bash

# Temporary file to hold the calculator output
TEMP_FILE="/tmp/wofi_calculator_output.txt"
STYLE_FILE="$HOME/.config/wofi/menu.css"
# Function to update the Wofi output
update_output() {
    # Calculate the result using bc, check for errors
    RESULT=$(echo "$INPUT" | bc -l 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "$RESULT" > "$TEMP_FILE"
    else
        echo "Error" > "$TEMP_FILE"
    fi
}

# Start with an empty input
INPUT=""

# Use Wofi to display the calculator
while true; do
    # Update output before showing Wofi
    update_output
    
    # Get the input from Wofi
    INPUT=$(wofi --show dmenu --style="$STYLE_FILE" --prompt 'Calc: ' < "$TEMP_FILE")
    
    # Check if the input is empty, then exit
    if [ -z "$INPUT" ]; then
        break
    fi
done

# Cleanup
rm -f "$TEMP_FILE"

