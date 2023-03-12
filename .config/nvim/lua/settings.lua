local set = vim.opt

----------------------------
---   General Settings
----------------------------
--- Set encoding
set.encoding = 'UTF-8'

-- Enable filetype options (plugins, indentation, detection)
vim.cmd('filetype plugin indent on')

-- Syntax and Line Numbers
vim.cmd('syntax enable')
set.number = true

-- Terminal Window Title
set.title = true

-- Indentation
set.tabstop     = 4
set.softtabstop = 4
set.shiftwidth  = 4
set.expandtab   = true

-- Search options
set.ignorecase = true

-- Buffer Config
set.hidden = true
vim.keymap.set('n', '<C-N>', ':bnext<CR>')
vim.keymap.set('n', '<C-P>', ':bprev<CR>')

-- Set data security options
set.swapfile = false
set.backup = false
set.writebackup = false
set.viminfofile = 'NONE'
set.clipboard = ''


-------------------
---   UI / UX
-------------------

-- Line wrap with arrow keys
set.whichwrap = '<,>'

-- Vertically center the cursor
set.scrolloff = 999

-- Set 24-bit true color
set.termguicolors = true

-- Always show the sign column, otherwise it would shift the text
set.signcolumn = 'yes'

-- Set diagnostic (sign) icons
vim.fn.sign_define("DiagnosticSignWarn",  {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignInfo",  {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",  {text = "", texthl = "DiagnosticSignHint"})

-- Command Line Config
set.cmdheight  = 2
set.showmode = false
set.showcmd  = false
vim.o.shortmess  = vim.o.shortmess .. 'cF'
