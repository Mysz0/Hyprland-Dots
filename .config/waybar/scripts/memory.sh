#!/bin/bash

# Get memory usage percentage and format to 2 decimal places
memory_usage=$(free | grep Mem | awk '{printf "%d", $3/$2 * 100.0}')

# Output the formatted percentage
echo "$memory_usage"

