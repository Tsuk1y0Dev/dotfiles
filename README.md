# Tsuk1y0Dev's Dotfiles

Minimalist Hyprland environment managed with GNU Stow. Configuration is driven by the Lua-based Hyprland ecosystem.


## Structure

```text
dotfiles/
└── hypr/            # Hyprland package
    └── .config/
        └── hypr/
            ├── hyprland.lua  # Main entry point
            └── conf_d/       # Modular Lua configurations
```

## System Dependencies

Ensure the following packages are installed on your system for the configurations and keybinds to function correctly:

* `hyprland` (with Lua support)
* `stow` (GNU Stow)
* `git`

### Required Core Utilities
* `swaync` (Notification daemon & client)
* `rofi` (Application launcher)
* `awww` (Wallpaper daemon)
* `grimblast` (Screenshots)
* `hyprlock` (Screen locker)
* `brightnessctl` (Backlight control)
* `wireplumber` (`wpctl` for audio management)
* `playerctl` (Media keys control)

## Installation

1. Clone the repository into your preferred system directory:
   ```bash
   mkdir -p ~/System
   git clone https://github.com ~/System/dotfiles
   cd ~/System/dotfiles
   ```

2. Remove any existing configuration directory to avoid symlink conflicts:
   ```bash
   rm -rf ~/.config/hypr
   ```

3. Deploy the configuration using GNU Stow:
   ```bash
   stow --target=\$HOME hypr
   ```

## ⚠️ Disclaimer & Customization

This configuration is tailored for personal use. Before launching, review and modify the following files to match your system setup:

* **Autostart (`hypr/.config/hypr/conf_d/_20-autostart.lua`)**: Contains user-specific applications (Carla paths, Spotify, chat clients). Update or comment them out.
* **Keybinds (`hypr/.config/hypr/conf_d/_50-keybinds.lua`)**: Verify your preferred terminal, file manager, and check the target path for `hyprlock --config` (default points to `~/.config/hyprlock/Hyprlock-Styles/...`).

## License

This project is licensed under the MIT License - see the LICENSE file for details.
