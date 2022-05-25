if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    echo
    PS3="Choose a session: "
    select choice in Xorg Wayland Console ; do
        case $choice in
            "Xorg")
                exec startx ;;
            "Wayland")
                export XDG_CURRENT_DESKTOP="Unity"
                exec dwl > "${XDG_RUNTIME_DIR:/run/user/$(id -u)}/dwltags" ;;
            "Console")
                break ;;
            *)
                printf "\nInvalid choice. Try again.\n" ;;
        esac
    done
fi
