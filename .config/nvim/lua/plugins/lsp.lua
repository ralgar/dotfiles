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
      require('mason-lspconfig').setup()

      -- Automatic setup of LSP servers
      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            on_attach = function(client, bufnr)
              -- Disable LSP syntax highlight (we use TreeSitter)
              client.server_capabilities.semanticTokensProvider = nil
            end
          }
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        --["rust_analyzer"] = function ()
        --    require("rust-tools").setup {}
        --end
      }
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
  }
}
