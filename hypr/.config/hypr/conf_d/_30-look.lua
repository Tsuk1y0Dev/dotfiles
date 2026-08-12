-- Look and feel

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,

        col = {
            active_border = {
                colors = { "rgba(ffffffff)", "rgba(111111ff)", "rgba(ffffffff)", "rgba(111111ff)" },
                angle = 45,
            },
            inactive_border = "rgba(1a1a1aaa)",
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 6,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 0.85,

        shadow = {
            enabled = true,
            range = 15,
            render_power = 4,
            color = "rgba(000000ee)",
        },

        blur = {
            enabled = true,
            size = 5,
            passes = 3,
            vibrancy = 0.0,
            xray = true,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
})

-- Curves
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("win_extreme_bounce", { type = "bezier", points = { {0.05, 1.4}, {0.15, 1.0} } })
hl.curve("move_kickstart", { type = "bezier", points = { {0.05, 1.1}, {0.1, 1.0} } })
hl.curve("ws_fast", { type = "bezier", points = { {0.1, 1.0}, {0.1, 1.0} } })

-- Animations
hl.animation({ leaf = "borderangle", enabled = true, speed = 60, bezier = "linear", style = "loop" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6.5, bezier = "win_extreme_bounce", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = false })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 8.5, bezier = "move_kickstart", style = "slide" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 7.5, bezier = "win_extreme_bounce" })
hl.animation({ leaf = "fadeOut", enabled = false })
hl.animation({ leaf = "workspaces", enabled = true, speed = 10, bezier = "ws_fast", style = "slide" })
