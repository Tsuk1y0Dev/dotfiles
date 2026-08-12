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

## Prerequisites

Ensure the following packages are installed on your system:

* `hyprland` (with Lua integration support)
* `stow` (GNU Stow)
* `git`

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

## Configuration Notes

The Hyprland setup is completely modularized inside `hypr/.config/hypr/conf_d/`. 
Modify variables, keybinds, and window rules in their respective Lua modules. Stow handles the symlinks dynamically, so any changes made locally inside `~/.config/hypr` are automatically tracked within this repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
