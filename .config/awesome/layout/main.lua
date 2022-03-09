local awful     = require("awful")
local beautiful = require('beautiful')
local dpi       = require("beautiful.xresources").apply_dpi
local gears     = require("gears")
local wibox     = require("wibox")

function at_screen_connect(s)
    -- Quake application
    --s.quake = quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = beautiful.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = dpi(28),
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal
    })

    -- Load Widgets
    local bat       = require('widget.bat')()
    local calendar  = require('widget.cal')()
    local clock     = require('widget.clock')()
    local cpu       = require('widget.cpu')()
    --local fs        = require('widget.fs')()    -- Requires Lgi/Gio
    --local mail      = require('widget.imap')()
    local memory    = require('widget.mem')()
    local mpd       = require('widget.mpd')()
    local netupinfo = require('widget.net')()
    local temp      = require('widget.temp')()
    --local weather   = require('widget.weather')()
    volume          = require('widget.alsa')()

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = 'none',
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(15),
            mpd.widget,
        },
        clock,
        --nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(15),
            wibox.widget.systray(),
            --mail.widget,
            netdowninfo,
            netupinfo.widget,
            volume.widget,
            memory.widget,
            cpu.widget,
            --fs.widget,
            --weather.widget,
            temp.widget,
            bat.widget,
        },
    }


    -- Create the bottom wibox
    s.mybottomwibox = awful.wibar({
        position = "bottom",
        screen = s,
        border_width = 0,
        height = dpi(28),
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal
    })

    local taglist   = require('widget.taglist')()
    local tasklist  = require('widget.tasklist')()
    local layoutbox = require('widget.layoutbox')

    -- Add widgets to the bottom wibox
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = 'none',
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(15),
            taglist,
        },
        tasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(15),
            layoutbox,
        },
    }
end
