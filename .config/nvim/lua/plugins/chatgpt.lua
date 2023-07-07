return {
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      'plenary.nvim',
      'nui.nvim',
      'nvim-telescope/telescope.nvim'
    },
    branch = "v0.1.1-alpha",
    config = function()
      require("chatgpt").setup({
        -- Additional config goes here
      })
    end
  }
}
