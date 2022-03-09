local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local naughty   = require("naughty")
local wibox     = require("wibox")

local function factory()

    local net        = { widget = wibox.widget.textbox(), devices = {} }
    netdowninfo = wibox.widget.textbox()

    local timeout    = 2
    local units      = 1024 -- KB
    local notify     = "on"
    local wifi_state = "off"
    local eth_state  = "off"
    local screen     = 1
    local settings   = function() end

    net.iface = {}

    function net.get_devices()
        net.iface = {} -- reset at every call
        awful.spawn.with_line_callback("ip link", {
            stdout = function (line)
                net.iface[#net.iface + 1] = not string.match(line, "LOOPBACK") and string.match(line, "(%w+): <") or nil
            end
        })
    end

    if #net.iface == 0 then net.get_devices() end

    -- Set widget markup
    local function markup(font, fg, text)
        return string.format(
            "<span font='%s' foreground='%s'>%s</span>",
            font,
            fg,
            text
        )
    end

    -- get first line of a file
    local function first_line(path)
        local file, first = io.open(path, "rb"), nil
        if file then
            first = file:read("*l")
            file:close()
        end
        return first
    end

    -- get a table with all lines from a file
    local function lines_from(path)
        local lines = {}
        for line in io.lines(path) do
            lines[#lines + 1] = line
        end
        return lines
    end

    net.map_table = {}

    function net.update()
        -- These are the totals over all specified interfaces
        net_now = {
            devices  = {},
            -- Bytes since last iteration
            sent     = 0,
            received = 0
        }

        for _, dev in ipairs(net.iface) do
            local dev_now    = {}
            local dev_before = net.devices[dev] or { last_t = 0, last_r = 0 }
            local now_t      = tonumber(first_line(string.format("/sys/class/net/%s/statistics/tx_bytes", dev)) or 0)
            local now_r      = tonumber(first_line(string.format("/sys/class/net/%s/statistics/rx_bytes", dev)) or 0)

            dev_now.carrier  = first_line(string.format("/sys/class/net/%s/carrier", dev)) or "0"
            dev_now.state    = first_line(string.format("/sys/class/net/%s/operstate", dev)) or "down"

            dev_now.sent     = (now_t - dev_before.last_t) / timeout / units
            dev_now.received = (now_r - dev_before.last_r) / timeout / units

            net_now.sent     = net_now.sent + dev_now.sent
            net_now.received = net_now.received + dev_now.received

            dev_now.sent     = string.format("%.1f", dev_now.sent)
            dev_now.received = string.format("%.1f", dev_now.received)

            dev_now.last_t   = now_t
            dev_now.last_r   = now_r

            if wifi_state == "on" and first_line(string.format("/sys/class/net/%s/uevent", dev)) == "DEVTYPE=wlan" then
                dev_now.wifi   = true
                if string.match(dev_now.carrier, "1") then
                        dev_now.signal = tonumber(string.match(lines_from("/proc/net/wireless")[3], "(%-%d+%.)")) or nil
                end
            else
                dev_now.wifi   = false
            end

            if eth_state == "on" and first_line(string.format("/sys/class/net/%s/uevent", dev)) ~= "DEVTYPE=wlan" then
                dev_now.ethernet = true
            else
                dev_now.ethernet = false
            end

            net.devices[dev] = dev_now

            -- Notify only once when connection is lost
            if string.match(dev_now.carrier, "0") and notify == "on" and net.map_table[dev] then
                naughty.notify {
                    title    = "Network Status",
                    text     = dev .. ": No connection",
                    icon     = "/usr/share/icons/" .. beautiful.icon_pack .. "/48x48/status/notification-network-wireless-disconnected.svg",
                    screen   = screen
                }
                net.map_table[dev] = false
            elseif string.match(dev_now.carrier, "1") then
                net.map_table[dev] = true
            end

            net_now.carrier = dev_now.carrier
            net_now.state = dev_now.state
            net_now.devices[dev] = dev_now
            -- net_now.sent and net_now.received will be
            -- the totals across all specified devices
        end

        net_now.sent = string.format("%.1f", net_now.sent)
        net_now.received = string.format("%.1f", net_now.received)

        --[[ uncomment if using the weather widget
        if iface ~= "network off" and
           string.match(weather.widget.text, "N/A")
        then
            weather.update()
        end
        --]]

        net.widget:set_markup(markup(
            beautiful.font,
            beautiful.net_up,  -- color
            "祝 " .. net_now.sent .. " ")
        )
        netdowninfo:set_markup(markup(
            beautiful.font,
            beautiful.net_down,  -- color
            " " .. net_now.received .. " ")
        )
    end

    -- Start a timer to update the widget
    gears.timer({
        timeout   = timeout,
        autostart = true,
        call_now  = true,
        callback  = net.update
    })

    return net
end

return factory
