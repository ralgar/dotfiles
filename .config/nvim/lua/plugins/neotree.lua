-- Dependencies
use "nvim-lua/plenary.nvim"
use "nvim-tree/nvim-web-devicons"
use "MunifTanjim/nui.nvim"

use({
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  config = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
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
  end
})
