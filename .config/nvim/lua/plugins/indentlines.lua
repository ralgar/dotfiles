use({
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    vim.g.indentLine_char = '¦'
    vim.g.indentLine_color_term = 178
    vim.g.indent_blankline_show_first_indent_level = false
    require("indent_blankline").setup {}
  end
})
