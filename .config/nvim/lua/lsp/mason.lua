-- Installs mason.nvim for easy, UI-based package management of LSP servers,
--  DAP servers, linters, and formatters.
-- https://github.com/williamboman/mason.nvim

use({
  'williamboman/mason.nvim',
  config = function()
    require('mason').setup()
  end
})
user.flush()

use({
  'williamboman/mason-lspconfig.nvim',
  config = function()
    require('mason-lspconfig').setup()

    -- Automatic setup of LSP servers
    require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        --["rust_analyzer"] = function ()
        --    require("rust-tools").setup {}
        --end
    }
  end
})
user.flush()
