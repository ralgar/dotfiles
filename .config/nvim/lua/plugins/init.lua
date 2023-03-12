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

local user = require "user"
user.setup { parallel = true }
use = user.use

-- Include packages here
require('plugins/theme')
require('plugins/main')
require('plugins/lualine')
require('plugins/bufferline')
require('plugins/git')
require('plugins/neotree')
require('plugins/indentlines')
require('plugins/chatgpt')

-- Since we are using parallel, we MUST call user.flush()
user.flush()
