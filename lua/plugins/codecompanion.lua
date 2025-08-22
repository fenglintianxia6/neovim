
return {
  {
    'olimorris/codecompanion.nvim',
    config = function()
      require('codecompanion').setup({
        opts = {
          log_level = "DEBUG",
            inline = {
                enabled = true,
                accept_key = "<C-l>"
            }
        }
      })
    end
  } 


}
