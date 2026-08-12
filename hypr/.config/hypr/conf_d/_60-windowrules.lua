-- Window rules

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name = "librewolf-opacity",
    match = { class = "^librewolf$" },
    opacity = "1.0 override 1.0 override",
    opaque = true,
})

hl.window_rule({
    name = "rofi-opacity",
    match = { class = "^rofi$" },
    opacity = "1.0 override 1.0 override",
    opaque = true,
})

hl.window_rule({
    name = "lsp-plugins-center",
    match = { title = "^LSP .* \\(GUI\\)$" },
    float = true,
    center = true,
})

hl.window_rule({
    name = "waydroid-fullscreen",
    match = { class = "^(waydroid)$", fullscreen = true },
    border_size = 0,
    no_shadow = true,
})

-- Special workspace assignment
hl.window_rule({ match = { class = "^(Spotify)$" }, workspace = "special:tech silent" })
hl.window_rule({ match = { class = "^([Vv]esktop)$" }, workspace = "special:social silent" })
hl.window_rule({ match = { class = "^(carla)$" }, workspace = "special:tech silent" })
hl.window_rule({ match = { class = "^(v2rayN)$" }, workspace = "special:tech silent" })
hl.window_rule({ match = { class = "^(com.ayugram.desktop)$" }, workspace = "special:social silent" })

-- Layer rules
hl.layer_rule({
    name = "rofi-blur",
    match = { namespace = "^rofi$" },
    blur = true,
})
