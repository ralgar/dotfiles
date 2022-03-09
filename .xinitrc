#   __    __ ______ __    __ ______ ________ _______   ______
#  |  \  |  \      \  \  |  \      \        \       \ /      \
#  | ▓▓  | ▓▓\▓▓▓▓▓▓ ▓▓\ | ▓▓\▓▓▓▓▓▓\▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓\  ▓▓▓▓▓▓\
#   \▓▓\/  ▓▓ | ▓▓ | ▓▓▓\| ▓▓ | ▓▓    | ▓▓  | ▓▓__| ▓▓ ▓▓   \▓▓
#    >▓▓  ▓▓  | ▓▓ | ▓▓▓▓\ ▓▓ | ▓▓    | ▓▓  | ▓▓    ▓▓ ▓▓
#   /  ▓▓▓▓\  | ▓▓ | ▓▓\▓▓ ▓▓ | ▓▓    | ▓▓  | ▓▓▓▓▓▓▓\ ▓▓   __
#  |  ▓▓ \▓▓\_| ▓▓_| ▓▓ \▓▓▓▓_| ▓▓_   | ▓▓  | ▓▓  | ▓▓ ▓▓__/  \
#  | ▓▓  | ▓▓   ▓▓ \ ▓▓  \▓▓▓   ▓▓ \  | ▓▓  | ▓▓  | ▓▓\▓▓    ▓▓
#   \▓▓   \▓▓\▓▓▓▓▓▓\▓▓   \▓▓\▓▓▓▓▓▓   \▓▓   \▓▓   \▓▓ \▓▓▓▓▓▓


# Make sure to source xinit scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for script in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$script" ] && . "$script"
    done
    unset script
fi

# Fix refresh rate on main monitor
xrandr --output DP-0 --mode 1920x1080 --rate 144

# Execute the window manager
exec awesome


# vim: set ft=bash:
