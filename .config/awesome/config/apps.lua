local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local theme_dir = config_dir .. '/themes/onedark'

return {
    autorun = {
        'alacritty',
        'sh -c "ssh-agent -D -a $XDG_RUNTIME_DIR/ssh-agent.socket"'
    },
    appmenu   = 'rofi -show drun -theme ' .. config_dir .. '/config/rofi.rasi',
    browser   = 'firefox',
    editor    = 'vim',
    scrlocker = 'i3lock -i ' .. theme_dir .. '/wallpapers/lockscreen.png',
    terminal  = 'alacritty'
}
