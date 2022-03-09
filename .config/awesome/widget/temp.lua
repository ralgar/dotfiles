local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require("wibox")

local function factory()

    local temp     = { widget = wibox.widget.textbox() }
    local tempfile = "/sys/devices/virtual/thermal/thermal_zone0/temp"

    function first_line(path)
        local file, first = io.open(path, "rb"), nil
        if file then
            first = file:read("*l")
            file:close()
        end
        return first
    end

    function temp.update()
        awful.spawn.easy_async({
        "find", "/sys/devices", "-type", "f", "-name", "*temp*"},
        function(stdout)
            temp_now = {}
            local temp_fl, temp_value
            for t in stdout:gmatch("[^\n]+") do
                temp_fl = first_line(t)
                if temp_fl then
                    temp_value = tonumber(temp_fl)
                    temp_now[t] = temp_value and temp_value/1e3 or temp_fl
                end
            end
            coretemp_now = temp_now[tempfile] or "N/A"

            temp.widget:set_markup(string.format(
                "<span font='%s' foreground='%s'>%s</span>",
                beautiful.font,
                beautiful.cpu_temp,
                " " .. coretemp_now .. "°C "
            ))
        end)
    end

    -- Start a timer to update the widget
    gears.timer({
        timeout   = 30,
        callback  = temp.update,
        autostart = true,
        call_now  = true
    })

    return temp
end

return factory
