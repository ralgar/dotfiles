local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')

local client_buttons = require('config.client.buttons')
local client_keys    = require('config.client.keys')

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
          border_width     = beautiful.border_width,
          border_color     = beautiful.border_normal,
          focus            = awful.client.focus.filter,
          raise            = true,
          keys             = client_keys,
          buttons          = client_buttons,
          screen           = awful.screen.preferred,
          placement        = awful.placement.no_overlap + awful.placement.no_offscreen,
          size_hints_honor = false
      }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      },
    properties = { floating = true }},

    -- Set Firefox to always map on the tag named "2" on screen 1.
    { rule = { class = "firefox" },
      properties = { screen = 1, tag = "2" }
    },
}

return rules
