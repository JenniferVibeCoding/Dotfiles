#!/bin/bash

# Start hypridle daemon (make sure config file exists)
hypridle -d &

# Start UI services
waybar &
dunst &

# Set wallpaper with a small delay
sleep 1
swww img ~/.wallpapers/wallpaper.png --transition-type simple &

# Wait a bit then switch to workspace 1
sleep 2
hyprctl dispatch workspace 1 &
