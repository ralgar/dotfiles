use({
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        require('null-ls').setup()
    end
})
user.flush()

use({
    'jay-babu/mason-null-ls.nvim',
    config = function()
        require('mason-null-ls').setup({
            -- Automatically configure packages on install
            automatic_setup = true,
        })

        require 'mason-null-ls'.setup_handlers {
            function(source_name, methods)
                -- all sources with no handler get passed here

                -- To keep the original functionality of `automatic_setup = true`,
                -- please add the below.
                require("mason-null-ls.automatic_setup")(source_name, methods)
            end,
            stylua = function(source_name, methods)
                null_ls.register(null_ls.builtins.formatting.stylua)
            end,
        }
    end
})
user.flush()
