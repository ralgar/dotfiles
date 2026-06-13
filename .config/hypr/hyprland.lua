-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---   ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗██████╗    ---
---   ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔══██╗   ---
---   ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ███████║██╔██╗ ██║██║  ██║   ---
---   ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██╔══██║██║╚██╗██║██║  ██║   ---
---   ██║  ██║   ██║   ██║     ██║  ██║███████╗██║  ██║██║ ╚████║██████╔╝   ---
---   ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝    ---
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- Refer to https://wiki.hyprland.org for more information.

--------------------
---   MONITORS   ---
--------------------

-- Keep the primary monitor at its highest refresh rate.
hl.monitor({ output = "DP-1",  mode = "highres", position = "0x0", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "highres", position = "0x0", scale = 1 })

-- Keep a large buffer zone for the auxilliary, so that the mouse doesn't traverse displays.
-- Mouse can be switched to the aux display using workspace keybinds.
hl.monitor({ output = "DP-2",  mode = "highres", position = "3840x0", scale = 1 })

-- Force 1080p60 for VMs
hl.monitor({ output = "Virtual-1", mode = "1920x1080", position = "0x0", scale = 1 })

------------------------------
---   MAIN CONFIGURATION   ---
------------------------------

hl.config({
    cursor = {
        hide_on_key_press = true,
        no_hardware_cursors = true
    },
    decoration = {
        rounding = 9,
        blur = {
            enabled = false,
            size = 3,           -- Minimum 1, high values (5+) may cause artifacts.
            passes = 1          -- Minimum 1, more passes = more resource intensive.
        },
        shadow = {
            enabled = true,
            range = 5,
            render_power = 1,
            color = "rgba(1a1a1aee)"
        }
    },
    dwindle = {
        force_split = 2,
        preserve_split = true,
    },
    ecosystem = {
        no_donation_nag = true,
        no_update_news = true
    },
    general = {
        allow_tearing = true,
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = "rgba(5c6370ff)",
            inactive_border = "rgba(3e4452ff)"
        }
    },
    input = {
        -- Keyboard Options
        numlock_by_default = true,

        -- Mouse/Touchpad Options
        sensitivity = 0.0,          -- Mouse sensitivity (range -1.0 to 1.0)
        accel_profile = "flat",     -- Mouse acceleration (adaptive, flat, or custom)
        follow_mouse = 1            -- Window focus follows mouse
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true
    },
    render = {
        direct_scanout = 2
    }
})

------------------------
---   WINDOW RULES   ---
------------------------

-- Set content type for games
hl.window_rule({ match = { class = "^(steam_app_.*)" }, content = "game" })

hl.window_rule({ match = { class = "firefox" }, workspace = 2 })
hl.window_rule({ match = { class = "gamescope" }, fullscreen = true })

-- Set floating windows
hl.window_rule({ match = { class = "feh" }, size = {"(monitor_w*0.8)", "(monitor_h*0.8)"} })
hl.window_rule({ match = { class = "feh" }, float = true })
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true })

-- Fullscreen Discord on the auxilliary display
hl.window_rule({ match = { class = "discord" }, monitor = 2 })
hl.window_rule({ match = { class = "discord" }, fullscreen = true })

-- Immediate present mode (enable tearing) for games
--hl.window_rule({ match = { content = "game" }, immediate = true })

--------------------
---   KEYBINDS   ---
--------------------

-- General
hl.bind("SUPER + Return", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + Q", hl.dsp.window.kill())
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("uwsm stop"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("wofi"))
hl.bind("SUPER + V", hl.dsp.window.float())
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())

-- Window Focus
hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))

-- Window Move and Resize
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

-- Switch Workspace
for i = 1, 10 do
    hl.bind("SUPER + " .. (i % 10), hl.dsp.focus({ workspace = tostring(i) }))
end

-- Move Window to Workspace
for i = 1, 10 do
    hl.bind("SUPER + SHIFT + " .. (i % 10), hl.dsp.window.move({ workspace = tostring(i) }))
end

-- Monitors
hl.bind("SUPER + Tab", hl.dsp.focus({ monitor = "+1" }))

-- Media Keys
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("mpc toggle"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("amixer -q set Master toggle"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("amixer -q set Master 5%-"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("amixer -q set Master 5%+"), { repeating = true })

-- Microphone Controls (persistent toggle and Push-to-Talk)
hl.bind("SHIFT + XF86Calculator", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ 0"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ 1"), { release = true })

-- Screenshots and Recordings
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\""))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim -o $(hyprctl -j activeworkspace | jq -r .monitor) && notify-send -u low 'Screenshot taken!'"))
hl.bind("SUPER + SHIFT + Print", hl.dsp.exec_cmd("toggle_record.sh"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("save-replay.sh"))

---------------------------
---   Workspace Rules   ---
---------------------------

hl.workspace_rule({ workspace = "1",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "2",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "3",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "4",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "5",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "6",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "7",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "8",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "9",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "10", monitor = "DP-2" })

---------------------
---   Autostart   ---
---------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mpd")
    hl.exec_cmd("gammastep")
    hl.exec_cmd("mako")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("yubikey-touch-detector --libnotify")
    --hl.exec_cmd("sh -c \"ssh-agent -D -a $XDG_RUNTIME_DIR/ssh-agent.socket\"")
end)
