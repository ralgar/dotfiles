local beautiful = require('beautiful')
local wibox     = require('wibox')

local function factory()

    -- Set widget markup
    function markup(font, fg, text)
        return string.format(
            "<span font='%s' foreground='%s'>%s</span>",
            font,
            fg,
            text
        )
    end

    os.setlocale(os.getenv("LANG")) -- to localize the clock
    local clock = wibox.widget.textclock(markup(
        beautiful.font,
        beautiful.clock,  -- color
        " %H:%M "
    ))

    return clock
end

return factory
