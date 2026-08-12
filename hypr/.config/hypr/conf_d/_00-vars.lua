-- Variables
local home = os.getenv("HOME")

_G.cfg = {
    mainMod = "SUPER",
    terminal = "kitty",
    fileManager = "yazi",
    screenshotDir = home .. "/Media/Screenshots",
    
    is_author_system = true,

    autostart = {
        -- System utilities
        { cmd = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" },
        { cmd = "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" },
        { cmd = "awww-daemon" },
        { cmd = "swaync" },
        
        -- Personal Software
        { cmd = "carla " .. home .. "/System/Configs/Carla/First.carxp", delay = 1, personal = true },
        { cmd = "v2rayN",  delay = 2, personal = true },
        { cmd = "AyuGram", delay = 3, personal = true },
        { cmd = "vesktop", delay = 3, personal = true },
        { cmd = "spotify", delay = 4, personal = true },
    }
}
