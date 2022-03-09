local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require("wibox")

local function factory()

    local alsa = { widget = wibox.widget.textbox() }

    local prev = {}

    -- Set widget markup
    function markup(text)
        return string.format(
            "<span font='%s' foreground='%s'>%s</span>",
            beautiful.font,
            beautiful.volume,
            text
        )
    end

    -- Update the widget
    function alsa.update()
        awful.spawn.easy_async("amixer get Master", function(stdout)
            local l,s = string.match(stdout, "([%d]+)%%.*%[([%l]*)")
            if prev.level ~= l or prev.status ~= s then
                local curr = { level = tonumber(l), status = s }
                if curr.status == "off" then
                    alsa.widget:set_markup(markup(
                        "墳 Mute "
                    ))
                else
                    alsa.widget:set_markup(markup(
                        "墳 " .. curr.level .. "% "
                    ))
                end
                prev = curr
            end
        end)
    end

    -- Start a timer to update the widget
    gears.timer({
        timeout   = 5,
        autostart = true,
        call_now  = true,
        callback  = alsa.update()
    })

    return alsa
end

return factory
