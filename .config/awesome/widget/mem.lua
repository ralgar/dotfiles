local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require("wibox")

local function factory()

    local mem      = { widget = wibox.widget.textbox() }

    function mem.update()
        mem_now = {}
        for line in io.lines("/proc/meminfo") do
            for k, v in string.gmatch(line, "([%a]+):[%s]+([%d]+).+") do
                if     k == "MemTotal"     then mem_now.total = math.floor(v / 1024 + 0.5)
                elseif k == "MemFree"      then mem_now.free  = math.floor(v / 1024 + 0.5)
                elseif k == "Buffers"      then mem_now.buf   = math.floor(v / 1024 + 0.5)
                elseif k == "Cached"       then mem_now.cache = math.floor(v / 1024 + 0.5)
                elseif k == "SwapTotal"    then mem_now.swap  = math.floor(v / 1024 + 0.5)
                elseif k == "SwapFree"     then mem_now.swapf = math.floor(v / 1024 + 0.5)
                elseif k == "SReclaimable" then mem_now.srec  = math.floor(v / 1024 + 0.5)
                end
            end
        end

        mem_now.used = mem_now.total - mem_now.free - mem_now.buf - mem_now.cache - mem_now.srec
        mem_now.swapused = mem_now.swap - mem_now.swapf
        mem_now.perc = math.floor(mem_now.used / mem_now.total * 100)

        mem.widget:set_markup(string.format(
            "<span font='%s' foreground='%s'>%s</span>",
            beautiful.font,
            beautiful.memory,
            "﬙ " .. mem_now.used .. "M "
        ))
    end

    -- Start a timer to update the widget
    gears.timer({
        timeout   = 2,
        callback  = mem.update,
        autostart = true,
        call_now  = true
    })

    return mem
end

return factory
