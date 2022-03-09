-- AUTORUN MODULE | Runs only once, when Awesome first runs
-- Runs the 'autostart' list in config/apps.lua

local apps  = require('config.apps')
local awful = require('awful')

local function autorun(cmd)
    awful.spawn.with_shell(
        string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd)
    )
end

for _, cmd in ipairs(apps.autorun) do
    autorun(cmd)
end

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]
