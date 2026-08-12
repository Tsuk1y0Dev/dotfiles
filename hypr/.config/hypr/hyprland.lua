-- Hyprland main configuration entry

package.path = package.path .. ";/home/tsuk1y0/.config/hypr/?.lua"

require("conf_d._00-vars")
require("conf_d._10-monitors")
require("conf_d._20-autostart")
require("conf_d._25-env")
require("conf_d._30-look")
require("conf_d._40-input")
require("conf_d._50-keybinds")
require("conf_d._60-windowrules")
