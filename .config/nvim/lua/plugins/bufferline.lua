require("bufferline").setup {
  options = {
    separator_style = "slant",
    highlights = {
      indicator_selected = {
        fg = '#f0f0f0',
        bg = '#f0f0f0'
      }
    },
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        separator = '█'  -- use a "true" to enable the default, or set your own character
      }
    }
  }
}

-- Indent Lines
vim.g.indentLine_char = '¦'
vim.g.indentLine_color_term = 178
vim.g.indent_blankline_show_first_indent_level = false
require("indent_blankline").setup {}

-- NeoTree
require("neo-tree").setup({
  auto_close = true,
  window = {
    width = 31  -- Match NerdTREE default
  }
})

vim.cmd[[
  augroup NEOTREE_AUGROUP
    autocmd!
    au VimEnter * lua vim.defer_fn(function() vim.cmd("Neotree show left") end, 10)
  augroup END
]]
