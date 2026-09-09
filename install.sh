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

#include <Wire.h>
#include <TroykaIMU.h>

// Создаем объект для фильтра Маджвика (Madgwick), который считает углы
Madgwick filter;

// Создаем объекты для акселерометра и гироскопа
Accelerometer accel;
Gyroscope gyro;

// Переменная для контроля времени
unsigned long checkTimer = 0;

void setup() {
  Serial.begin(9600);
  Serial.println("IMU Initialization...");

  // Запускаем датчики
  accel.begin();
  gyro.begin();
  
  // Устанавливаем частоту обновления фильтра (в Герцах)
  filter.begin(100); 
}

void loop() {
  // Считываем показания в реальном времени
  accel.readGXYZ();
  gyro.readRadXYZ();

  // Передаем данные в фильтр. 
  // ВАЖНО: гироскоп должен отдавать данные в радианах в секунду (readRadXYZ)
  filter.update(gyro.getGyroX_rads(), gyro.getGyroY_rads(), gyro.getGyroZ_rads(), 
                accel.getAccelX_g(), accel.getAccelY_g(), accel.getAccelZ_g());

  // Выводим результат в монитор порта каждые 100 миллисекунд
  if (millis() - checkTimer >= 100) {
    checkTimer = millis();

    // Получаем готовые углы в градусах
    float roll  = filter.getRollDeg();   // Крен (наклон влево/вправо)
    float pitch = filter.getPitchDeg();  // Тангаж (наклон вперед/назад)
    float yaw   = filter.getYawDeg();    // Рыскание (поворот по компасу)

    // Печатаем данные
    Serial.print("Roll: ");
    Serial.print(roll);
    Serial.print(" °\tPitch: ");
    Serial.print(pitch);
    Serial.print(" °\tYaw: ");
    Serial.print(yaw);
    Serial.println(" °");
  }
}
