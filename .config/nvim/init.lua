------------------------------------------
---   INITIALIZE THE PACKAGE MANAGER
------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Docs: https://lazy.folke.io/
require("lazy").setup({
  spec = { import = "plugins" }  -- Import all files in "plugins" directory
})

----------------------------
---    INCLUDE MODULES
----------------------------
require('diagnostics')
require('keybinds')
require('settings')
require('lsp')
