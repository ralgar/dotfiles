local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local json     = require("util").dkjson
local focused  = require("awful.screen").focused
local naughty  = require("naughty")
local wibox    = require("wibox")

-- OpenWeatherMap | Current and X days forecast

local function factory()

    local weather               = { widget = wibox.widget.textbox() }
    local APPID                 = "" -- mandatory
    local timeout               = 60 * 15 -- 15 min
    local current_call          = "curl -s 'https://api.openweathermap.org/data/2.5/weather?id=%s&units=%s&lang=%s&APPID=%s'"
    local forecast_call         = "curl -s 'https://api.openweathermap.org/data/2.5/forecast?id=%s&units=%s&lang=%s&APPID=%s'"
    local city_id               = 2643743 -- placeholder (London)
    local units                 = "metric"
    local lang                  = "en"
    local cnt                   = 5
    local icons_path            = "openweathermap/"
    local notification_text_fun = function (wn)
        local day = os.date("%a %d", wn["dt"])
        local temp = math.floor(wn["main"]["temp"])
        local desc = wn["weather"][1]["description"]
        return string.format("<b>%s</b>: %s, %d ", day, desc, temp)
    end
    local weather_na_markup     = markup(
        beautiful.font,
        beautiful.weather,
        " N/A "
    )
    local followtag             = false
    local showpopup             = "on"

    weather.widget:set_markup(weather_na_markup)
    weather.icon_path = icons_path .. "na.png"
    weather.icon = wibox.widget.imagebox(weather.icon_path)

    function weather.show(seconds)
        weather.hide()

        if followtag then
            notification_preset.screen = focused()
        end

        if not weather.notification_text then
            weather.update()
            weather.forecast_update()
        end

        weather.notification = naughty.notify {
            preset  = {
                font = beautiful.font,
                fg   = beautiful.fg_normal
            },
            text    = weather.notification_text,
            icon    = weather.icon_path,
            timeout = type(seconds) == "number" and seconds or notification_preset.timeout
        }
    end

    function weather.hide()
        if weather.notification then
            naughty.destroy(weather.notification)
            weather.notification = nil
        end
    end

    function weather.attach(obj)
        obj:connect_signal("mouse::enter", function()
            weather.show(0)
        end)
        obj:connect_signal("mouse::leave", function()
            weather.hide()
        end)
    end

    function weather.forecast_update()
        local cmd = string.format(forecast_call, city_id, units, lang, APPID)
        awful.spawn.easy_async(cmd, function(f)
            local err
            weather_now, _, err = json.decode(f, 1, nil)

            if not err and type(weather_now) == "table" and tonumber(weather_now["cod"]) == 200 then
                weather.notification_text = ""
                for i = 1, weather_now["cnt"], weather_now["cnt"]//cnt do
                    weather.notification_text = weather.notification_text ..
                                                notification_text_fun(weather_now["list"][i])
                    if i < weather_now["cnt"] then
                        weather.notification_text = weather.notification_text .. "\n"
                    end
                end
            end
        end)
    end

    -- Set widget markup
    local function markup(font, fg, text)
        return string.format(
            "<span font='%s' foreground='%s'>%s</span>",
            font,
            fg,
            text
        )
    end

    function weather.update()
        local cmd = string.format(current_call, city_id, units, lang, APPID)
        awful.spawn.easy_async(cmd, function(f)
            local err
            weather_now, _, err = json.decode(f, 1, nil)

            if not err and type(weather_now) == "table" and tonumber(weather_now["cod"]) == 200 then
                local sunrise = tonumber(weather_now["sys"]["sunrise"])
                local sunset  = tonumber(weather_now["sys"]["sunset"])
                local icon    = weather_now["weather"][1]["icon"]
                local loc_now = os.time()

                if sunrise <= loc_now and loc_now <= sunset then
                    icon = string.gsub(icon, "n", "d")
                else
                    icon = string.gsub(icon, "d", "n")
                end

                weather.icon_path = icons_path .. icon .. ".png"

                -- Appearance settings
                descr = weather_now["weather"][1]["description"]:lower()
                units = math.floor(weather_now["main"]["temp"])
                weather.widget:set_markup(markup(
                    beautiful.font,
                    beautiful.weather,  -- color
                    " " .. descr .. " @ " .. units .. "°C "))
            else
                weather.icon_path = icons_path .. "na.png"
                weather.widget:set_markup(weather_na_markup)
            end

            weather.icon:set_image(weather.icon_path)
        end)
    end

    if showpopup == "on" then weather.attach(weather.widget) end

    -- Start timers to update the widget
    gears.timer({
        timeout   = 60 * 15,  -- 15 min
        autostart = true,
        call_now  = true,
        callback  = weather.update
    })
    gears.timer({
        timeout   = 60 * 15,  -- 15 min
        autostart = true,
        call_now  = true,
        callback  = weather.forecast_update
    })

    return weather
end

return factory
