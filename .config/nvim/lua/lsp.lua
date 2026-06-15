-- Disable semantic tokens globally (use Treesitter for highlighting instead)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- Disable LSP logging to file
vim.lsp.log.set_level("OFF")

-- Completion setup
require('blink.cmp').setup({
  keymap = {
    preset = 'enter',  -- CR to accept, Tab/S-Tab to navigate
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
})
