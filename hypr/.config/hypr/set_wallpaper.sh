#!/bin/bash

# Wait until at least one monitor is active
until hyprctl monitors | grep -q "ID"; do
    sleep 0.2
done

# Start the daemon if not running
pgrep swww-daemon >/dev/null || /usr/bin/swww-daemon &

# Wait briefly to avoid buffer timing issues
sleep 1

# Set your wallpaper
swww img ~/Pictures/Wallpapers/BNWP.png
