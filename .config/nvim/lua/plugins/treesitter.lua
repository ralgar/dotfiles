return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    'bash',
                    'c',
                    'cpp',
                    'comment',
                    'diff',
                    'dockerfile',
                    'git_config',
                    'git_rebase',
                    'gitattributes',
                    'gitcommit',
                    'gitignore',
                    'glsl',
                    'hcl',
                    'json',
                    'json5',
                    'lua',
                    'make',
                    'markdown',
                    'meson',
                    'python',
                    'regex',
                    'sql',
                    'terraform',
                    'vim',
                    'vimdoc',
                    'yaml'
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
