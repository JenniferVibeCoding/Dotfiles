#!/usr/bin/env bash
set -euo pipefail
PKGS=(rofi waybar hypr gtk3 gtk4 firefox)

if ! command -v stow >/dev/null 2>&1; then
  if command -v apt >/dev/null 2>&1; then sudo apt update && sudo apt install -y stow
  elif command -v pacman >/dev/null 2>&1; then sudo pacman -S --noconfirm stow
  elif command -v dnf >/dev/null 2>&1; then sudo dnf install -y stow
  else echo "Install stow manually"; exit 1; fi
fi

# map firefox PROFILE_PLACEHOLDER -> actual
FF_DIR="$HOME/.mozilla/firefox"
if [ -f "$FF_DIR/profiles.ini" ]; then
  P=$(awk -F= '
    /^\[Profile/ {p=0}
    $1=="Name" && $2=="default-release" {p=1}
    p && $1=="Path" {print $2; exit}
  ' "$FF_DIR/profiles.ini"); [ -z "$P" ] && P=$(awk -F= '$1=="Path"{print $2; exit}' "$FF_DIR/profiles.ini")
  if [ -n "$P" ] && [ -d "firefox/.mozilla/firefox/PROFILE_PLACEHOLDER" ]; then
    mkdir -p "firefox/.mozilla/firefox/$P"
    mv firefox/.mozilla/firefox/PROFILE_PLACEHOLDER/* "firefox/.mozilla/firefox/$P"/ 2>/dev/null || true
    rmdir firefox/.mozilla/firefox/PROFILE_PLACEHOLDER 2>/dev/null || true
  fi
fi

for p in "${PKGS[@]}"; do [ -d "$p" ] && stow --no-folding -t "$HOME" "$p"; done
echo "stowed."
