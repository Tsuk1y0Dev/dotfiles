-- Hyprland main configuration entry

local home = os.getenv("HOME")
package.path = package.path .. ";" .. home .. "/.config/hypr/?.lua"

local modules = {
    "conf_d._00-vars",
    "conf_d._10-monitors",
    "conf_d._20-autostart",
    "conf_d._25-env",
    "conf_d._30-look",
    "conf_d._40-input",
    "conf_d._50-keybinds",
    "conf_d._60-windowrules"
}

for _, module in ipairs(modules) do
    require(module)
end
