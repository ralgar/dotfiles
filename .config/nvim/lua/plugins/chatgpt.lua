return {
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      'plenary.nvim',
      'nui.nvim',
      'nvim-telescope/telescope.nvim'
    },
    commit = "b50fdaf",
    config = function()
      require("chatgpt").setup({
        -- Additional config goes here
      })
    end
  }
}
