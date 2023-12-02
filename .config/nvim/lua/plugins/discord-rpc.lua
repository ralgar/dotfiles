return {
  {
    'IogaMaster/neocord',
    event = 'VeryLazy',
    config = function()
      require('neocord').setup({
        log_level = nil,
      })
    end
  }
}
