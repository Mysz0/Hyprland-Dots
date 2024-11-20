#!/bin/bash

# Check if Waybar is running
if pgrep -x waybar > /dev/null; then
    # Kill Waybar if it is running
    pkill waybar
else
    # Start Waybar if it is not running
    waybar
fi

