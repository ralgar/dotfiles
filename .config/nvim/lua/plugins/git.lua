return {
  {
    'tpope/vim-fugitive'
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'purarue/gitsigns-yadm.nvim',
    },
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '' },
          change       = { text = '' },
          delete       = { text = '' },
          topdelete    = { text = '' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        _on_attach_pre = function(bufnr, callback)
          if vim.fn.executable('yadm') == 1 then
            require('gitsigns-yadm').yadm_signs(callback, { bufnr = bufnr })
          else
            callback()
          end
        end,
      })
    end
  }
}
