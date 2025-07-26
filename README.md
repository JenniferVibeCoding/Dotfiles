# 🍬 Jennifer's Dotfiles – Pastel Edition

Welcome to my custom dotfiles setup, built for a fully keyboard-driven, aesthetic, pastel-rice Arch system using Hyprland. These configs are deeply themed, script-automated, and ready for both daily use and future scaling.

![Hyprland Desktop](https://github.com/JenniferVibeCoding/Dotfiles/blob/main/screenshot_1753498043.png)
---

## 📦 What’s Inside

- 🪟 **Hyprland Config**: Custom tiling WM setup with themed blur, rounded corners, and scratchpad rules
- 🌸 **Kitty Terminal**: Pastel pink terminal with JetBrainsMono Nerd Font
- 🔀 **Scratchpad Toggle Scripts**: Custom scripts to launch and toggle apps into special workspaces
- 🐚 **Zsh Shell Theme**: Custom prompt with conda env, git status, and more
- 🖼️ **GTK/LightDM Themes**: Pastel-glass login and UI configs
- 🛠️ **Launcher Scripts**: Easy app launchers (e.g., `launch_waifu.sh`, `toggle_yazi.sh`)

---

## 🪄 Scratchpad Toggle System

You can toggle apps into floating, dedicated special workspaces using scripts in `~/.config/launchers/`.

### 🛠️ To Add a New App Toggle:

1. **Create a launcher script** (e.g. `toggle_spotify.sh`)
    ```bash
    #!/bin/bash
    ~/.config/launchers/toggle_special.sh "spotifyterm" "kitty --class spotifyterm -e ncspot" "special:spotify"
    ```

2. **Make it executable**:
    ```bash
    chmod +x ~/.config/launchers/toggle_spotify.sh
    ```

3. **Add a keybind in Hyprland** (`~/.config/hypr/hyprland.conf`):
    ```ini
    bind = $mod, S, exec, ~/.config/launchers/toggle_spotify.sh
    ```

4. **Create a window rule** (also in `hyprland.conf`):
    ```ini
    windowrulev2 = workspace special:spotify silent, class:^(spotifyterm)$
    windowrulev2 = float, class:^(spotifyterm)$
    windowrulev2 = size 80% 80%, class:^(spotifyterm)$
    windowrulev2 = center, class:^(spotifyterm)$
    ```

That’s it! Launch with your keybind, and it'll toggle on/off smoothly.

---

## 🚀 Setup Instructions

If you're cloning these dotfiles onto a new system:

```bash
git clone https://github.com/JenniferVibeCoding/Dotfiles.git ~/dotfiles
cd ~/dotfiles

# Create symlinks or copy files as needed
# Example:
ln -s ~/dotfiles/hyprland/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
