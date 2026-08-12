#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VARS_FILE="$HOME/.config/hypr/conf_d/_00-vars.lua"

echo "=== System Installation ==="

if [ "$EUID" -eq 0 ]; then
    echo "Error: Do not run as root."
    exit 1
fi

echo "-> Checking official packages..."
DEPENDENCIES=(hyprland stow git swaync rofi hyprlock brightnessctl wireplumber playerctl)
MISSING_PKGS=()

for pkg in "${DEPENDENCIES[@]}"; do
    if ! pacman -Qi "$pkg" &> /dev/null; then
        MISSING_PKGS+=("$pkg")
    fi
done

if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
    echo "Installing: ${MISSING_PKGS[*]}"
    sudo pacman -S --noconfirm "${MISSING_PKGS[@]}"
else
    echo "Official packages are up to date."
fi

echo "-> Checking AUR packages..."
if ! pacman -Qi grimblast &> /dev/null; then
    if command -v yay &> /dev/null; then
        yay -S --noconfirm grimblast
    elif command -v paru &> /dev/null; then
        paru -S --noconfirm grimblast
    else
        echo "Warning: grimblast not found. Install it manually via AUR."
    fi
else
    echo "grimblast is already installed."
fi

if [ -d "$HOME/.config/hypr" ] && [ ! -L "$HOME/.config/hypr" ]; then
    echo "-> Backing up existing config..."
    rm -rf "$HOME/.config/hypr.bak"
    mv "$HOME/.config/hypr" "$HOME/.config/hypr.bak"
elif [ -L "$HOME/.config/hypr" ]; then
    rm -f "$HOME/.config/hypr"
fi

echo "-> Deploying symlinks via stow..."
stow --dir="$SCRIPT_DIR" --target="$HOME" hypr

if [ -f "$VARS_FILE" ]; then
    if [ "$USER" != "tsuk1y0" ]; then
        echo "-> Configuring environment for external system..."
        sed -i 's/is_author_system = true/is_author_system = false/g' "$VARS_FILE"
    else
        echo "-> Configuring environment for author system..."
        sed -i 's/is_author_system = false/is_author_system = true/g' "$VARS_FILE"
    fi
fi

echo "=== Success ==="

if [ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
    read -p "Reload Hyprland configuration? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        hyprctl reload
    fi
fi
