return {
  {
    'nvim-tree/nvim-web-devicons'
  },
  {
    'nvim-lua/plenary.nvim',
  },
  {
    'MunifTanjim/nui.nvim'
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require("bufferline").setup {
        highlights = {
          offset_separator = {
            bg = '#282c34',
            fg = '#282c34',
          }
        },
        options = {
          separator_style = "slant",
          --offsets = {
          --  {
          --    filetype = "neo-tree",
          --    text = "File Explorer",
          --    highlight = "Directory",
          --    separator = '█'  -- use a "true" to enable the default, or set your own character
          --  }
          --}
        }
      }
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'onedark',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    version = "^3.0.0",
    config = function()
      vim.g.indent_blankline_show_first_indent_level = false
      require("ibl").setup({
        indent = { char = '¦' },
        scope = { show_start = false, show_end = false }
      })
      local hooks = require("ibl.hooks")
      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_space_indent_level
      )
    end
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-web-devicons',
      'plenary.nvim',
      'nui.nvim'
    },
    branch = "v2.x",
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          --width = 31  -- Match NerdTREE default
        }
      })
      vim.cmd[[
        augroup NEOTREE_AUGROUP
          autocmd!
          au VimEnter * lua vim.defer_fn(function() vim.cmd("Neotree show left") end, 10)
        augroup END
      ]]
    end
  }
}
