-- 等待插件加载完成后注册快捷键
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    local wk = require("which-key")
    
    -- 文件浏览器快捷键
    wk.add({
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
    })
    
    -- Telescope 快捷键 (移到 leader t)
    wk.add({
      { "<leader>t", name = "Telescope" },
      { "gf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "gr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>ts", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
    })
    
    -- Flutter 快捷键
    wk.add({
      { "<leader>F", name = "Flutter" },
      { "<leader>Fr", "<cmd>FlutterRun<cr>", desc = "Run Flutter App" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Quit Flutter App" },
      { "<leader>Fh", "<cmd>FlutterReload<cr>", desc = "Hot Reload" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>", desc = "Hot Restart" },
      { "<leader>Fl", "<cmd>FlutterLogClear<cr>", desc = "Show Logs" },
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Show Devices" },
      { "<leader>Fo", "<cmd>FlutterOutline<cr>", desc = "Show Outline" },
      { "<leader>Fs", "<cmd>FlutterSuper<cr>", desc = "Super" },
      { "<leader>Fc", "<cmd>FlutterCopyProfilerUrl<cr>", desc = "Copy Profiler URL" },
      { "<leader>Ft", "<cmd>FlutterTest<cr>", desc = "Run Tests" },
      { "<leader>FD", "<cmd>FlutterDevTools<cr>", desc = "Open DevTools" },
    })
    
          -- LSP 快捷键
      wk.add({
        { "<leader>l", name = "LSP" },
        { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to Definition" },
        { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Go to Implementation" },
        { "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "Show References" },
        { "K", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Show Diagnostic" },
        { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature Help" },
        { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
        { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
        { "<leader>cf", "<cmd>lua vim.lsp.buf.code_action({only = {'quickfix'}})<cr>", desc = "Quick Fix" },
        { "<leader>cr", "<cmd>lua vim.lsp.buf.code_action({only = {'refactor'}})<cr>", desc = "Refactor" },
        { "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format" },
        { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Previous Diagnostic" },
        { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
      })
      
      -- Git 快捷键
      wk.add({
        { "<leader>g", name = "Git" },
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
        { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
        { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
        { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
        { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Line Blame" },
        { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff This" },
        { "<leader>gD", "<cmd>Gitsigns diffthis ~<cr>", desc = "Diff This ~" },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      })
  end,
}) 