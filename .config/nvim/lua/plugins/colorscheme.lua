return {
  {
    'navarasu/onedark.nvim',
    lazy = false,       -- Ensure we load the colorscheme during startup
    priority = 1000,    -- Ensure we load this before all other startup plugins
    config = function()
      require('onedark').setup {
        style = 'darker',
        highlights = {
          GitSignsChange = { fg = '$yellow' },
        }
      }
      require('onedark').load()
    end
  }
}
