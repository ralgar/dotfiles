-- LOAD LIBRARIES

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local beautiful     = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")


-- LOAD CONFIGURATIONS
root.keys(require('config.keys.global'))
root.buttons(require('config.keys.mouse'))
require('config.client')


-- LOAD MODULES
require('module.autorun')
require('module.notifications')


-- {{{ Variable definitions

local themes = {
    "onedark"         -- 1
}

local chosen_theme = themes[1]
local vi_focus     = false -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev   = true  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274

awful.util.terminal = terminal
awful.util.tagnames = { " 1 ", " 2 ", " 3 ", " 4 ", " 5 " }
awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    --awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
}

-- LOAD THEME
local config_dir = gears.filesystem.get_configuration_dir()
beautiful.init(config_dir .. "themes/" .. chosen_theme .. "/theme.lua")

-- LOAD LAYOUT
require('layout')
