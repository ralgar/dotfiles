local awful     = require('awful')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local gears     = require('gears')

local function client_shape_rounded(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, dpi(beautiful.corner_radius))
end

-- Update the client's shape based on the current layout (float, max, fullscreen, etc.)
local function update_shape(c)
    local layout = awful.tag.getproperty(c.first_tag, 'layout')
    if (layout == awful.layout.suit.max and not c.floating)
        or (c.maximized or c.fullscreen) then
            c.shape = gears.shape.rectangle
    else
        c.shape = client_shape_rounded
    end
end

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then
        awful.client.setslave(c)
    end

    -- Focus the client
    c:emit_signal('request::activate')

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    update_shape(c)
end)

-- Update client shape on toggle fullscreen
client.connect_signal('property::fullscreen', function(c)
    if c.fullscreen then
        c.shape = gears.shape.rectangle
    else
        update_shape(c)
    end
end)

-- Update client shape on floating
client.connect_signal('property::floating', function(c)
    local layout = awful.tag.getproperty(c.first_tag, 'layout')
    if c.floating and not c.maximized then
        c.shape = client_shape_rounded
    else
        update_shape(c)
    end
end)

-- Update client shape on maximize
client.connect_signal('property::maximized', function(c)
    local layout = awful.tag.getproperty(c.first_tag, 'layout')
    if c.maximized then
        c.shape = gears.shape.rectangle
    else
        update_shape(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = vi_focus})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
