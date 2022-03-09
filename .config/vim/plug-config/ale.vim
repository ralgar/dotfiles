""""""""""""""""""""""
"""   ALE Config
""""""""""""""""""""""

" Disable LSP because we use CoC.nvim
let g:ale_disable_lsp = 1

" Enable vim-airline extension for ALE
let g:airline#extensions#ale#enabled = 1

" Visual
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
"hi ALEErrorSign ctermfg=160 ctermbg=NONE
hi ALEErrorSign ctermfg=red ctermbg=NONE
hi ALEWarningSign ctermfg=yellow ctermbg=NONE

" Linting settings
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'never'

" Fixers
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
