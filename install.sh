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



temp:
#include <TroykaIMU.h>

// Создаем фильтр для расчета углов
Madgwick filter;

// Создаем объекты акселерометра и гироскопа
Accelerometer accel;
Gyroscope gyro;

unsigned long timer = 0;

void setup() {
  Serial.begin(9600);

  // Запускаем датчики. Библиотека сама внутри включит I2C (Wire)
  accel.begin();
  gyro.begin();
  
  // Запускаем фильтр на частоту 100 Герц
  filter.begin(100); 
}

void loop() {
  // Очень быстро считываем сырые данные
  accel.readGXYZ();
  gyro.readRadXYZ();

  // Обновляем математический фильтр
  filter.update(gyro.getGyroX_rads(), gyro.getGyroY_rads(), gyro.getGyroZ_rads(), 
                accel.getAccelX_g(), accel.getAccelY_g(), accel.getAccelZ_g());

  // Выводим градусы в монитор порта каждые 100 миллисекунд
  if (millis() - timer >= 100) {
    timer = millis();

    // Переводим данные в понятные углы (градусы)
    float roll  = filter.getRollDeg();   // Наклон влево / вправо
    float pitch = filter.getPitchDeg();  // Наклон вперед / назад

    Serial.print("Наклон влево/вправо: ");
    Serial.print(roll);
    Serial.print(" °\tНаклон вперед/назад: ");
    Serial.print(pitch);
    Serial.println(" °");
  }
}
