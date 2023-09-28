-----------------------
---   Keybindings
-----------------------
-- Switch Buffer / Window
-- NOTE: This breaks Ctrl-i (Jumplist)
vim.keymap.set('n', '<Tab>',     '<C-w><C-w>',          { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>',  ':bprev<CR>',          { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':bnext<CR>',          { noremap = true, silent = true })

-- Toggle NeoTree and SymbolsOutline
vim.keymap.set('n', '<S-Tab>',   ':NeoTreeShow<CR>',    { noremap = true, silent = true })
vim.keymap.set('n', '|',         ':SymbolsOutline<CR>', { noremap = true, silent = true })
