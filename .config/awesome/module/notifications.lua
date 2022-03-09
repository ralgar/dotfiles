local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local gears     = require('gears')
local naughty   = require('naughty')

-- Notification defaults
naughty.config.defaults.title        = 'System Notification'
naughty.config.defaults.position     = 'top_right'
naughty.config.defaults.timeout      = 5
naughty.config.defaults.screen       = 1
naughty.config.defaults.icon_size    = dpi(48)
naughty.config.defaults.margin       = dpi(16)
naughty.config.defaults.border_width = dpi(2)
naughty.config.defaults.ontop        = true
naughty.config.defaults.shape        = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(9))
end

naughty.config.padding = dpi(5)    -- From edge of workspace
naughty.config.spacing = dpi(3)    -- Between notifications
naughty.config.icon_formats = { "png", "gif", "svg" }
naughty.config.icon_dirs = {
    "/usr/share/icons/" .. "Papirus-Dark" .. "/",
}

-- NOT WORKING ???!?!?!
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during st-t-t-artup!",
        text = awesome.startup_errors
    }
end

-- Handle runtime errors after startup
do
    local in_error = false

    awesome.connect_signal("debug::error", function (err)
        if in_error then return end

        in_error = true

        naughty.notify {
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        }

        in_error = false
    end)
end
