-- Dependencies
use 'nvim-tree/nvim-web-devicons'

use({
  'akinsho/bufferline.nvim',
  config = function()
    require("bufferline").setup {
      options = {
        separator_style = "slant",
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
  end
})
