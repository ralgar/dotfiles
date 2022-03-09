local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local theme                    = {}
theme.confdir                  = os.getenv("HOME") .. "/.config/awesome/themes/onedark"

-- Settings
theme.wallpaper                = theme.confdir .. "/wallpapers/desktop.jpg"
theme.font                     = "MesloLGS NF 12"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon    = false
theme.useless_gap              = 5
theme.corner_radius            = 9
theme.border_width             = dpi(2)
theme.icon_pack                = "Papirus-Dark"

-- Colorscheme
theme.color = {
    -- Base
    foreground = "#5c6370",
    background = "#121417",
    dark_grey  = "#1e2127",
    light_grey = "#3e4452",

    -- 8 color scheme
    black   = "#5c6370",
    red     = "#e06c75",
    green   = "#98c379",
    yellow  = "#e5c07b",
    blue    = "#61afef",
    magenta = "#c678dd",
    cyan    = "#56b6c2",
    white   = "#abb2bf"
}

-- Bars, Windows, and Decorations
theme.bg_normal     = theme.color.background
theme.bg_focus      = theme.color.dark_grey
theme.bg_urgent     = theme.color.background

theme.fg_normal     = theme.color.foreground
theme.fg_focus      = theme.color.white
theme.fg_urgent     = theme.color.red
theme.fg_minimize   = theme.color.light_grey

theme.border_normal = theme.color.light_grey
theme.border_focus  = theme.color.black
theme.border_marked = theme.color.red

-- Widgets
theme.mpd_artist = theme.color.red
theme.mpd_title  = theme.color.black
theme.clock      = theme.color.white
theme.net_down   = theme.color.green
theme.net_up     = theme.color.red
theme.volume     = theme.color.blue
theme.memory     = theme.color.yellow
theme.cpu_load   = theme.color.red
theme.cpu_temp   = theme.color.magenta
theme.battery    = theme.color.cyan
theme.weather    = theme.color.white
theme.fs         = theme.color.white
theme.mail       = theme.color.white

-- Layout Icons
theme.taglist_squares_sel      = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel    = theme.confdir .. "/icons/square_b.png"
theme.layout_tile              = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps          = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft          = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom        = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop           = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv             = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh             = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral            = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle           = theme.confdir .. "/icons/dwindle.png"
theme.layout_max               = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen        = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier         = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating          = theme.confdir .. "/icons/floating.png"

return theme
