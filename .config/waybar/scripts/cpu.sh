#!/usr/bin/env bash

# Get the CPU temperature (temp1) using sensors
temp=$(sensors | grep 'temp1' | awk '{print $2}' | sed 's/+//; s/°C//')

# Check if we got a valid temperature
if [[ -z "$temp" ]]; then
    temp="N/A"  # Set to N/A if temp1 is not found
else
    # Use printf to format the temperature as an integer
    temp=$(printf "%.0f" "$temp")
fi

# Output the temperature value only
echo "$temp"

