local colorscheme = 'monokai_pro'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end

-- Custom visual selection highlight (dark theme friendly)
local function set_visual_highlight()
    -- Adjust the color below if you prefer a different selection shade
    vim.api.nvim_set_hl(0, "Visual", { bg = "#2C7A77", fg = "#D5FFFF" })
end

-- Apply once on startup
set_visual_highlight()

-- Reapply after any colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("CustomVisualHighlight", { clear = true }),
    callback = set_visual_highlight,
})
