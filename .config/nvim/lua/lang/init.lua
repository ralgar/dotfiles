use({
    'sheerun/vim-polyglot',
    config = function()
        -- vim-terraform config
        vim.cmd([[ let g:terraform_align = 0 ]])
        vim.cmd([[ let g:terraform_fold_sections = 0 ]])
        vim.cmd([[ let g:terraform_fmt_on_save = 0 ]])
    end
})
