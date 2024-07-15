# Workaround for GTK themes not applying
import_gsettings() {
    config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
    [[ -f "$config" ]] || {
        printf "WARN: Could not find GTK3 config to load!\n"
        return 1
    }

    gnome_schema="org.gnome.desktop.interface"
    gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
    icon_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
    cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
    font_name="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"
    gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
    gsettings set "$gnome_schema" icon-theme "$icon_theme"
    gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
    gsettings set "$gnome_schema" font-name "$font_name"
}

# Start graphical environment on TTY1 only, otherwise drop into console.
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] ; then
    import_gsettings
    exec Hyprland 2>&1 > /dev/null
fi
