local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local shell    = require("awful.util").shell
local escape_f = require("awful.util").escape
local focused  = require("awful.screen").focused
local naughty  = require("naughty")
local wibox    = require("wibox")

local function factory()

    local mpd           = { widget = wibox.widget.textbox() }
    local password      = ""
    local host          = os.getenv("MPD_HOST") or "127.0.0.1"
    local port          = os.getenv("MPD_PORT") or "6600"
    local music_dir     = os.getenv("HOME") .. "/Music"
    local cover_pattern = "*\\.(jpg|jpeg|png|gif)$"
    local cover_size    = 100
    --local default_art   = args.default_art
    local notify        = "on"
    local followtag     = false

    local mpdh = string.format("telnet://%s:%s", host, port)
    local echo = string.format("printf \"%sstatus\\ncurrentsong\\nclose\\n\"", password)
    local cmd  = string.format("%s | curl --connect-timeout 1 -fsm 3 %s", echo, mpdh)

    mpd_notification_preset = { title = "Now playing", timeout = 6 }

    mpd.map_table = {}
    mpd.map_table["current mpd track"] = nil

    -- Set widget markup
    local function markup(font, fg, text)
        return string.format(
            "<span font='%s' foreground='%s'>%s</span>",
            font,
            fg,
            text
        )
    end

    function mpd.update()
        awful.spawn.easy_async({ shell, "-c", cmd }, function(f)
            mpd_now = {
                random_mode  = false,
                single_mode  = false,
                repeat_mode  = false,
                consume_mode = false,
                pls_pos      = "N/A",
                pls_len      = "N/A",
                state        = "N/A",
                file         = "N/A",
                name         = "N/A",
                artist       = "N/A",
                title        = "N/A",
                album        = "N/A",
                genre        = "N/A",
                track        = "N/A",
                date         = "N/A",
                time         = "N/A",
                elapsed      = "N/A"
            }

            for line in string.gmatch(f, "[^\n]+") do
                for k, v in string.gmatch(line, "([%w]+):[%s](.*)$") do
                    if     k == "state"          then mpd_now.state        = v
                    elseif k == "file"           then mpd_now.file         = v
                    elseif k == "Name"           then mpd_now.name         = escape_f(v)
                    elseif k == "Artist"         then mpd_now.artist       = escape_f(v)
                    elseif k == "Title"          then mpd_now.title        = escape_f(v)
                    elseif k == "Album"          then mpd_now.album        = escape_f(v)
                    elseif k == "Genre"          then mpd_now.genre        = escape_f(v)
                    elseif k == "Track"          then mpd_now.track        = escape_f(v)
                    elseif k == "Date"           then mpd_now.date         = escape_f(v)
                    elseif k == "Time"           then mpd_now.time         = v
                    elseif k == "elapsed"        then mpd_now.elapsed      = string.match(v, "%d+")
                    elseif k == "song"           then mpd_now.pls_pos      = v
                    elseif k == "playlistlength" then mpd_now.pls_len      = v
                    elseif k == "repeat"         then mpd_now.repeat_mode  = v ~= "0"
                    elseif k == "single"         then mpd_now.single_mode  = v ~= "0"
                    elseif k == "random"         then mpd_now.random_mode  = v ~= "0"
                    elseif k == "consume"        then mpd_now.consume_mode = v ~= "0"
                    end
                end
            end

            mpd_notification_preset.text = string.format("%s (%s) - %s\n%s", mpd_now.artist,
                                           mpd_now.album, mpd_now.date, mpd_now.title)
            -- Appearance Settings
            mpd_notification_preset = {
                text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                       mpd_now.album, mpd_now.date, mpd_now.title)
            }
            if mpd_now.state == "play" then
                artist = mpd_now.artist .. " > "
                title  = mpd_now.title .. " "
            elseif mpd_now.state == "pause" then
                artist = "mpd "
                title  = "paused "
            else
                artist = ""
                title  = ""
            end
            mpd.widget:set_markup(markup(
                beautiful.font,
                beautiful.mpd_artist,  -- color
                "  " .. artist) ..
            markup(
                beautiful.font,
                beautiful.mpd_title,  -- color
                title))

            if mpd_now.state == "play" then
                if notify == "on" and mpd_now.title ~= mpd.map_table["current mpd track"] then
                    mpd.map_table["current mpd track"] = mpd_now.title

                    if followtag then mpd_notification_preset.screen = focused() end

                    local common =  {
                        preset      = mpd_notification_preset,
                        icon        = default_art,
                        icon_size   = cover_size,
                        replaces_id = mpd.id
                    }

                    if not string.match(mpd_now.file, "http.*://") then -- local file instead of http stream
                        local path   = string.format("%s/%s", music_dir, string.match(mpd_now.file, ".*/"))
                        local cover  = string.format("find '%s' -maxdepth 1 -type f | egrep -i -m1 '%s'",
                                       path:gsub("'", "'\\''"), cover_pattern)
                        awful.spawn.easy_async({ shell, "-c", cover }, function(current_icon)
                            common.icon = current_icon:gsub("\n", "")
                            if #common.icon == 0 then common.icon = nil end
                            mpd.id = naughty.notify(common).id
                        end)
                    else
                        mpd.id = naughty.notify(common).id
                    end

                end
            elseif mpd_now.state ~= "pause" then
                mpd.map_table["current mpd track"] = nil
            end
        end)
    end

    -- Start a timer to update the widget
    gears.timer({
        timeout   = 2,
        autostart = true,
        call_now  = true,
        callback  = mpd.update
    })

    return mpd
end

return factory
