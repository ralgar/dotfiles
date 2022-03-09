local awful = require('awful')
local modkey = require('config.keys.mod').mod_key

global_buttons = (awful.util.table.join(
    -- Scroll to cycle through tags
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

awful.util.taglist_buttons = awful.util.table.join(
    -- Left click to change tag
    awful.button({ }, 1, function(t) t:view_only() end),

    -- Mod + Left click to move focused client to tag
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),

    -- Right click another tag to toggle viewing it in the current tag
    awful.button({ }, 3, awful.tag.viewtoggle),

    -- Mod + Right click another tag to toggle viewing focused client on it
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),

    -- Scroll to cycle through tags
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = awful.util.table.join(
     awful.button({ }, 1, function(c)
         if c == client.focus then
             c.minimized = true
         else
             c:emit_signal("request::activate", "tasklist", { raise = true })
         end
     end),
     awful.button({ }, 3, function()
         awful.menu.client_list({ theme = { width = 250 } })
     end),
     awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
     awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)

return global_buttons
