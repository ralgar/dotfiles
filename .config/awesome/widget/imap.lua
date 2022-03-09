local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local naughty  = require("naughty")
local wibox    = require("wibox")

local function factory()

    local imap       = { widget = wibox.widget.textbox() }
    local server     = "127.0.0.1"
    local mail       = "user@example.com"
    local password   = "password"
    local port       = 993
    local is_plain   = false
    local followtag  = false
    local notify     = "on"

    local head_command = "curl --connect-timeout 3 -fsm 3"
    local request = "-X 'STATUS INBOX (MESSAGES RECENT UNSEEN)'"

    if not server or not mail or not password then return end

    mail_notification_preset = {
        icon     = "mail.png",
        position = "top_left"
    }

    imap.map_table = {}
    imap.map_table[mail] = 0

    if not is_plain then
        if type(password) == "string" or type(password) == "table" then
            awful.spawn.easy_async(password, function(f) password = f:gsub("\n", "") end)
        elseif type(password) == "function" then
            imap.pwdtimer = gears.timer({
                timeout   = 10,
                autostart = true,
                call_now  = false,
                callback  = function()
                    local retrieved_password, try_again = password()
                    if not try_again then
                        imap.pwdtimer:stop() -- stop trying to retrieve
                        password = retrieved_password or "" -- failsafe
                    end
                end
            })
        end
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

    function imap.update()
        -- do not update if the password has not been retrieved yet
        if type(password) ~= "string" then return end

        local curl = string.format("%s --url imaps://%s:%s/INBOX -u %s:'%s' %s -k",
                     head_command, server, port, mail, password, request)

        awful.spawn.easy_async(curl, function(f)
            imap_now = { ["MESSAGES"] = 0, ["RECENT"] = 0, ["UNSEEN"] = 0 }

            for s,d in f:gmatch("(%w+)%s+(%d+)") do imap_now[s] = tonumber(d) end
            mailcount = imap_now["UNSEEN"] -- backwards compatibility

            -- Appearance settings
            if mailcount > 0 then
                imap.widget:set_markup(markup(
                    beautiful.font,
                    beautiful.mail,  -- color
                    " " .. mailcount .. " "))
            else
                imap.widget:set_text("No mail")
            end

            if notify == "on" and mailcount and mailcount >= 1 and mailcount > imap.map_table[mail] then
                if followtag then mail_notification_preset.screen = awful.screen.focused() end
                naughty.notify {
                    preset = mail_notification_preset,
                    text   = string.format("%s has <b>%d</b> new message%s", mail, mailcount, mailcount == 1 and "" or "s")
                }
            end

            imap.map_table[mail] = imap_now["UNSEEN"]
        end)

    end

    -- Start a timer to update the widget
    gears.timer({
        timeout   = 60,
        autostart = true,
        call_now  = true,
        callback  = imap.update
    })

    return imap
end

return factory
