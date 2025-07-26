#!/bin/bash

CLASS="Spotify"
CMD="spotify"
WORKSPACE="special:music"

# If already visible, just toggle
if hyprctl clients -j | jq -e '.[] | select(.class=="'"$CLASS"'")' > /dev/null; then
    hyprctl dispatch togglespecialworkspace "$CLASS"
    exit 0
fi

# Launch and let Hyprland move it
$CMD &

# Wait for window to map with non-zero size
for i in {1..80}; do
    sleep 0.1
    size=$(hyprctl clients -j | jq -r '.[] | select(.class=="'"$CLASS"'") | .size | @csv')
    if [[ "$size" != "0,0" ]]; then
        hyprctl dispatch togglespecialworkspace "$CLASS"
        exit 0
    fi
done

echo "❌ Spotify window never resized"
exit 1
