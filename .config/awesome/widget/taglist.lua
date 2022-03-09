local awful = require('awful')
local modkey = require('config.keys.mod').mod_key

local function factory()

    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a taglist widget
    local taglist = awful.widget.taglist(
        1,  -- screen
        awful.widget.taglist.filter.all,
        awful.util.taglist_buttons
    )

    return taglist
end

return factory
