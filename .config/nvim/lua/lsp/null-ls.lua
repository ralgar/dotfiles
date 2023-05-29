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
    end
})
user.flush()
