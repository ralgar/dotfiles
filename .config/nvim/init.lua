------------------------------------------
---   INITIALIZE THE PACKAGE MANAGER
------------------------------------------
local user_packadd_path = "faerryn_user.nvim/default/default/default/default"
local user_install_path = vim.fn.stdpath "data" .. "/site/pack/user/opt/" .. user_packadd_path

if vim.fn.isdirectory(user_install_path) == 0 then
  os.execute(
    "git clone --quiet --depth 1 https://github.com/faerryn/user.nvim.git " ..
    vim.fn.shellescape(user_install_path)
  )
end
vim.api.nvim_command("packadd " .. vim.fn.fnameescape(user_packadd_path))

user = require "user"
user.setup { parallel = true }
use = user.use

-- Have user.nvim manage itself
use "faerryn/user.nvim"

----------------------------
---    INCLUDE MODULES
----------------------------
require('keybinds')
require('settings')
require('plugins')
require('lsp')
require('lang')

-- Flush any missed plugins, and clean up old packages
user.flush()
user.clean()
