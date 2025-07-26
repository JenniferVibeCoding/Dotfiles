#!/bin/bash
temp=$(cat /sys/class/hwmon/hwmon1/temp1_input 2>/dev/null)
if [[ -n "$temp" ]]; then
    celsius=$((temp / 1000))
    echo " ${celsius}°C"
else
    echo " N/A"
fi
