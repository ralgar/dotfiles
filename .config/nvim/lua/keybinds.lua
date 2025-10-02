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

-- Yank selection or current line to clipboard
vim.keymap.set("v", "<leader>y", '"+y',  { desc = "Yank selection to clipboard" })
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Yank line to clipboard" })
