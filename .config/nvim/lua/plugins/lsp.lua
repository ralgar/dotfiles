return {
  {
    'neovim/nvim-lspconfig',
  },
  {
    -- Autocompletion plugin
    'saghen/blink.cmp',
    version = '1.*',
    opts_extend = { "sources.default" },
  },
  {
    'mason-org/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {
          border = 'rounded',
          height = 0.8,
          icons = {
            package_installed = '',
            package_pending = '',
            package_uninstalled = ''
          }
        }
      })
    end
  },
  {
    'mason-org/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        automatic_enable = true,
      })
    end
  },
  {
    'nvimtools/none-ls.nvim',
     config = function()
       require('null-ls').setup()
     end
  },
  {
    'jay-babu/mason-null-ls.nvim',
    config = function()
      require('mason-null-ls').setup({
        -- Automatically configure packages on install
        automatic_setup = true,
        handlers = {},
      })
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "hedyhli/outline.nvim",
    dependencies = {},
    config = function()
      require("outline").setup({
        symbols = {
          icons = {
            Function = { icon = "󰊕", hl = "@function" },
            Method   = { icon = "󰊕", hl = "@method" },
          },
        },
      })
    end,
  }
}
