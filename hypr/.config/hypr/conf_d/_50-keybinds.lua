-- Keybinds

local mod = _G.cfg.mainMod
local shotDir = _G.cfg.screenshotDir

local function shot(target)
    return string.format(
        "grimblast --notify copysave %s \"%s/$(date +'%%Y-%%m-%%d-%%H%%M%%S').png\"",
        target,
        shotDir
    )
end

-- Apps and session
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(_G.cfg.terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(_G.cfg.terminal .. " -e " .. _G.cfg.fileManager))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + L", hl.dsp.exec_cmd("hyprlock --config ~/.config/hyprlock/Hyprlock-Styles/Style-1/hyprlock.conf"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mod .. " + SUPER_L", hl.dsp.exec_cmd("rofi -show drun"), { release = true })

-- Screenshots
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd(shot("active")))
hl.bind("PRINT", hl.dsp.exec_cmd(shot("area")))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd(shot("screen")))

-- Brightness / volume
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"), { locked = true, repeating = true })

-- Media keys
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Focus
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Window modes
hl.bind("SUPER + ALT + SPACE", function() hl.dispatch(hl.dsp.window.float({ action = "toggle" })) end)
hl.bind(mod .. " + D", function() hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })) end)
hl.bind(mod .. " + F", function() hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) end)
hl.bind(mod .. " + SEMICOLON", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + APOSTROPHE", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + ALT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Special workspaces
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("main"))
hl.bind(mod .. " + M", hl.dsp.workspace.toggle_special("social"))
hl.bind(mod .. " + T", hl.dsp.workspace.toggle_special("tech"))

hl.bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special:main", follow = false }))
hl.bind("SUPER + ALT + M", hl.dsp.window.move({ workspace = "special:social", follow = false }))
hl.bind("SUPER + ALT + T", hl.dsp.window.move({ workspace = "special:tech", follow = false }))
