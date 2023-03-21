use('neovim/nvim-lspconfig')
require('lsp/mason')
require('lsp/null-ls')
require('lsp/completion')

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap = true, silent = true })
