#!/bin/bash

apps=("ncspot" "btopterm" "yazi" "waifu")

for app in "${apps[@]}"; do
    script="$HOME/.config/launchers/launch_only_${app}.sh"
    if [[ -x "$script" ]]; then
        if [[ "$app" == "yazi" ]]; then
            (sleep 1.5 && bash "$script") &
        else
            bash "$script" &
        fi
    else
        echo "❌ Missing or not executable: $script"
    fi
done
