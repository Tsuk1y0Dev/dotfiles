-- Autostart

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("swaync")

    hl.exec_cmd("sleep 1 && carla /home/tsuk1y0/System/Configs/Carla/First.carxp")
    hl.exec_cmd("sleep 2 && v2rayN")
    hl.exec_cmd("sleep 3 && AyuGram")
    hl.exec_cmd("sleep 3 && vesktop")
    hl.exec_cmd("sleep 4 && spotify")
end)
