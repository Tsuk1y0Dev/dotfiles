-- Keybinds Data

local mod = _G.cfg.mainMod
local shotDir = _G.cfg.screenshotDir

-- Utility
local function shot(target)
    local fmt = "grimblast --notify copysave %s \"%s/$(date +'%%Y-%%m-%%d-%%H%%M%%S').png\""
    return string.format(fmt, target, shotDir)
end

-- Core layout table
local bindings = {
    -- Apps & session
    { combo = mod .. " + Return",  run = hl.dsp.exec_cmd(_G.cfg.terminal) },
    { combo = mod .. " + E",       run = hl.dsp.exec_cmd(_G.cfg.terminal .. " -e " .. _G.cfg.fileManager) },
    { combo = mod .. " + Q",       run = hl.dsp.window.close() },
    { combo = mod .. " + N",       run = hl.dsp.exec_cmd("swaync-client -t -sw") },
    { combo = mod .. " + SUPER_L", run = hl.dsp.exec_cmd("rofi -show drun"), opts = { release = true } },
    
    -- Lock screen wrapped to prevent long lines rule trigger
    { combo = mod .. " + L", run = hl.dsp.exec_cmd(
        "hyprlock --config ~/.config/hyprlock/Hyprlock-Styles/Style-1/hyprlock.conf"
    ) },

    -- Screenshots
    { combo = mod .. " + SHIFT + S", run = hl.dsp.exec_cmd(shot("active")) },
    { combo = "PRINT",               run = hl.dsp.exec_cmd(shot("area")) },
    { combo = "SHIFT + PRINT",       run = hl.dsp.exec_cmd(shot("screen")) },

    -- Brightness & volume
    { combo = "XF86MonBrightnessUp",   run = hl.dsp.exec_cmd("brightnessctl s 5%+") },
    { combo = "XF86MonBrightnessDown", run = hl.dsp.exec_cmd("brightnessctl s 5%-") },
    { combo = "XF86AudioRaiseVolume",  run = hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.5") },
    { combo = "XF86AudioLowerVolume",  run = hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-") },

    -- Media keys
    { combo = "XF86AudioMute",    run = hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") },
    { combo = "XF86AudioMicMute", run = hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") },
    { combo = "XF86AudioPlay",    run = hl.dsp.exec_cmd("playerctl play-pause") },
    { combo = "XF86AudioPause",   run = hl.dsp.exec_cmd("playerctl play-pause") },
    { combo = "XF86AudioNext",    run = hl.dsp.exec_cmd("playerctl next") },
    { combo = "XF86AudioPrev",    run = hl.dsp.exec_cmd("playerctl previous") },

    -- Focus management
    { combo = mod .. " + left",  run = hl.dsp.focus({ direction = "left" }) },
    { combo = mod .. " + right", run = hl.dsp.focus({ direction = "right" }) },
    { combo = mod .. " + up",    run = hl.dsp.focus({ direction = "up" }) },
    { combo = mod .. " + down",  run = hl.dsp.focus({ direction = "down" }) },

    -- Move windows
    { combo = mod .. " + SHIFT + left",  run = hl.dsp.window.move({ direction = "l" }) },
    { combo = mod .. " + SHIFT + right", run = hl.dsp.window.move({ direction = "r" }) },
    { combo = mod .. " + SHIFT + up",    run = hl.dsp.window.move({ direction = "u" }) },
    { combo = mod .. " + SHIFT + down",  run = hl.dsp.window.move({ direction = "d" }) },

    -- Window control modes
    { combo = mod .. " + D",         run = function() hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })) end },
    { combo = mod .. " + F",         run = function() hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) end },
    { combo = "SUPER + ALT + SPACE", run = function() hl.dispatch(hl.dsp.window.float({ action = "toggle" })) end },
    { combo = mod .. " + SEMICOLON", run = hl.dsp.window.resize({ x = -20, y = 0, relative = true }) },
    { combo = mod .. " + APOSTROPHE", run = hl.dsp.window.resize({ x = 20, y = 0, relative = true }) },

    -- Mouse window interactions
    { combo = mod .. " + mouse:272", run = hl.dsp.window.drag(), opts = { mouse = true } },
    { combo = mod .. " + mouse:273", run = hl.dsp.window.resize(), opts = { mouse = true } },

    -- Mouse workspace navigation
    { combo = mod .. " + mouse_down", run = hl.dsp.focus({ workspace = "e+1" }) },
    { combo = mod .. " + mouse_up",   run = hl.dsp.focus({ workspace = "e-1" }) },

    -- Special workspace triggers
    { combo = mod .. " + S", run = hl.dsp.workspace.toggle_special("main") },
    { combo = mod .. " + M", run = hl.dsp.workspace.toggle_special("social") },
    { combo = mod .. " + T", run = hl.dsp.workspace.toggle_special("tech") },

    -- Relocate windows to special workspaces
    { combo = "SUPER + ALT + S", run = hl.dsp.window.move({ workspace = "special:main", follow = false }) },
    { combo = "SUPER + ALT + M", run = hl.dsp.window.move({ workspace = "special:social", follow = false }) },
    { combo = "SUPER + ALT + T", run = hl.dsp.window.move({ workspace = "special:tech", follow = false }) },
}

-- Execution loop & options parsing
for _, b in ipairs(bindings) do
    local opts = b.opts or {}
    
    if string.find(b.combo, "XF86") then
        opts.locked = true
        if string.find(b.combo, "Volume") or string.find(b.combo, "Brightness") then
            opts.repeating = true
        end
    elseif string.find(b.combo, "SEMICOLON") or string.find(b.combo, "APOSTROPHE") then
        opts.repeating = true
    end

    hl.bind(b.combo, b.run, opts)
end

-- Workspaces loop (1-10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + ALT + " .. key, hl.dsp.window.move({ workspace = i }))
end
