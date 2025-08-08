return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      triggers = { "<auto>", mode = "nxso" },
    },
    config = function()
      require("which-key").setup({
        triggers = { "<auto>", mode = "nxso" },
      })
    end,
  }
}