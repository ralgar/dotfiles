return {
  {
    'neovim/nvim-lspconfig',
  },
  {
    -- Autocompletion plugin
    'hrsh7th/nvim-cmp'
  },
  {
    -- LSP source for nvim-cmp
    'hrsh7th/cmp-nvim-lsp'
  },
  {
    -- Path source for nvim-cmp
    'hrsh7th/cmp-path'
  },
  {
    -- Snippets source for nvim-cmp
    'saadparwaiz1/cmp_luasnip'
  },
  {
    -- Snippets plugin
    'L3MON4D3/LuaSnip'
  },
  {
    'williamboman/mason.nvim',
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
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        automatic_enable = true,
      })
    end
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
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
    "simrat39/symbols-outline.nvim",
    dependencies = {},
    config = function()
      require("symbols-outline").setup({
        symbols = {
          Function = { icon = "󰊕", hl = "@function" },
          Method   = { icon = "󰊕", hl = "@method" },
        },
      })
    end,
  }
}
