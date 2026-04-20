# Start graphical environment on TTY1 only, otherwise drop into console.
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] ; then
    if uwsm check may-start ; then
        exec uwsm start hyprland.desktop
    fi
fi
