#!/bin/bash
# Script to toggle Bluetooth power state

status=$(bluetoothctl show | grep "Powered: yes")

if [ -n "$status" ]; then
  bluetoothctl power off
else
  bluetoothctl power on
fi

