return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- 这里配置 none-ls
            local null_ls = require("null-ls") -- 注意：虽然插件名是 none-ls，但 require 仍然用 "null-ls"
            null_ls.setup({
                debug = true,
                sources = {
                }
            })
        end,
    }
}