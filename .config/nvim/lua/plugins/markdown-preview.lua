use({
  "iamcco/markdown-preview.nvim",
  config = function()
    vim.fn["mkdp#util#install"]()
    vim.g.mkdp_browser = 'firefox'
  end,
})
