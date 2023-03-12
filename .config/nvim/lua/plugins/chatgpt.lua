-- Dependencies
use "MunifTanjim/nui.nvim"
use "nvim-lua/plenary.nvim"
use "nvim-telescope/telescope.nvim"

use({
  "jackMort/ChatGPT.nvim",
  tag = "v0.1.1-alpha",
  config = function()
    require("chatgpt").setup({
      -- Additional config goes here
    })
  end
})
