require('lsp/completion')
require('lsp/mason')

use({
  'neovim/nvim-lspconfig',
  config = function()
    require('lspconfig').pyright.setup{}
  end
})

