-- Autostart Execution Logic

hl.on("hyprland.start", function()
    if not (_G.cfg and _G.cfg.autostart) then return end

    local is_author = _G.cfg.is_author_system or false

    for _, app in ipairs(_G.cfg.autostart) do
        local should_run = true
        if app.personal and not is_author then
            should_run = false
        end

        if should_run and app.cmd then
            local final_cmd = app.cmd

            if app.delay and app.delay > 0 then
                final_cmd = string.format("sleep %d && %s &", app.delay, app.cmd)
            else
                final_cmd = app.cmd .. " &"
            end

            hl.exec_cmd(final_cmd)
        end
    end
end)
