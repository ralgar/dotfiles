return {
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        style = 'darker',
        highlights = {
          GitSignsChange = {fg = '$yellow'},
        }
      }
      require('onedark').load()
    end
  }
}
