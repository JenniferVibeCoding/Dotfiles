#!/bin/bash

CLASS="$1"
WORKSPACE="special:$CLASS"
CMD="$2"

# Check if the window already exists (use class or title for better coverage)
if hyprctl clients -j | jq -e '.[] | select(.class=="'"$CLASS"'") or select(.title=="'"$CLASS"'")' > /dev/null; then
    echo "[*] Toggling $WORKSPACE"
    hyprctl dispatch togglespecialworkspace "$WORKSPACE"
    sleep 0.2
    hyprctl dispatch focuswindow "class:^(($CLASS))$"
    exit 0
fi

# Launch new instance
echo "[+] Launching: $CMD"
$CMD &

# Wait for window to appear
for i in {1..40}; do
    sleep 0.1
    if hyprctl clients -j | jq -e '.[] | select(.class=="'"$CLASS"'") or select(.title=="'"$CLASS"'")' > /dev/null; then
        break
    fi
done

# Toggle it into view
# echo "[+] Mapped, toggling $WORKSPACE"
hyprctl dispatch togglespecialworkspace "$WORKSPACE"
# sleep 0.2
# hyprctl dispatch focuswindow "class:^(($CLASS))$"

