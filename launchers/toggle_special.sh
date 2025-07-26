#!/bin/bash

CLASS="$1"
CMD="$2"
WORKSPACE="$3"

echo "[INFO] Toggling $CLASS to $WORKSPACE"

# 1. If it's already open, toggle visibility
if hyprctl clients -j | jq -e '.[] | select(.class=="'"$CLASS"'")' > /dev/null; then
    hyprctl dispatch togglespecialworkspace "$CLASS"
    exit 0
fi

# 2. Launch app — Hyprland rule will auto-move it
setsid bash -c "$CMD" >/dev/null 2>&1 &

# 3. Wait for window to be seen, then toggle it visible
for i in {1..60}; do
    sleep 0.1
    if hyprctl clients -j | jq -e '.[] | select(.class=="'"$CLASS"'")' > /dev/null; then
        hyprctl dispatch togglespecialworkspace "$CLASS"
        exit 0
    fi
done

echo "❌ [ERROR] Window for $CLASS never appeared"
exit 1
