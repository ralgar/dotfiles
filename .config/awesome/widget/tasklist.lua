local awful = require('awful')

local function factory()

    local tasklist = awful.widget.tasklist(
        1, --screen
        awful.widget.tasklist.filter.currenttags,
        awful.util.tasklist_buttons
    )

    return tasklist
end

return factory
