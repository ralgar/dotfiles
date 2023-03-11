-----------------------
---   Keybindings
-----------------------
-- Switch Window | Note - This breaks Ctrl-i (Jumplist)
vim.keymap.set('n', '<Tab>',     '<C-w><C-w>',  { silent = true })
vim.keymap.set('n', '<C-Left>',  ':bprev<CR>',  { silent = true })
vim.keymap.set('n', '<C-Right>', ':bnext<CR>', { silent = true })
