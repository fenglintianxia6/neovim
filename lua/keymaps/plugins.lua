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
      { "<leader>ts", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "gr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>tg", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }, 
    })

    wk.add({
        { "cgd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to Definition (Float)" },
        { "cgi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to Implementation" },
        { "cgr", "<cmd>Telescope lsp_references<cr>", desc = "Show References" },
        { "cK", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Show Diagnostic" },
        { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature Help" },
        {";ej","<cmd>Telescope diagnostics<cr>", desc = "Show Diagnostics"},
        {";ek","<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Show Buffer Diagnostics"},
    })
    
    -- Flutter 快捷键
    wk.add({
      { "<leader>F", name = "Flutter" },
      { "<leader>Fr", "<cmd>FlutterRun<cr>", desc = "Run Flutter App" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Quit Flutter App" },
      { "<leader>Fh", "<cmd>FlutterReload<cr>", desc = "Hot Reload" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>", desc = "Hot Restart" },
      { "<leader>Fc", "<cmd>FlutterLogClear<cr>", desc = "Show Logs" },
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Show Devices" },
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Show Outline" },
      { "<leader>Fs", "<cmd>FlutterSuper<cr>", desc = "Super" },
      { "<leader>Fp", "<cmd>FlutterCopyProfilerUrl<cr>", desc = "Copy Profiler URL" },
      { "<leader>Ft", "<cmd>FlutterLogToggle<cr>", desc = "FlutterLogToggle" },
      { "<leader>FD", "<cmd>FlutterDevTools<cr>", desc = "Open DevTools" },
    })
    
          -- 文件操作快捷键
      wk.add({
        { "<leader>f", name = "File & Format" },
        { "<leader>ff", function()
            vim.lsp.buf.format()
            vim.cmd("write")
          end, desc = "Format & Save" },
        { "<leader>fs", "<cmd>write<cr>", desc = "Save File" },
        { "<leader>fS", "<cmd>wall<cr>", desc = "Save All Files" },
        { "<leader>fw", "<cmd>write<cr>", desc = "Write File" },
        { "<leader>fq", "<cmd>wq<cr>", desc = "Save & Quit" },
        { "<leader>fQ", "<cmd>wqall<cr>", desc = "Save All & Quit" },
      })
      
      -- LSP 快捷键
      wk.add({
        { "<leader>l", name = "LSP" },
        { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to Definition (Float)" },
        { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to Implementation" },
        { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "Show References" },
        { "K", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Show Diagnostic" },
        { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature Help" },
        { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
        { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
        { "<leader>cf", "<cmd>lua vim.lsp.buf.code_action({only = {'quickfix'}})<cr>", desc = "Quick Fix" },
        { "<leader>cr", "<cmd>lua vim.lsp.buf.code_action({only = {'refactor'}})<cr>", desc = "Refactor" },
        { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format Only" },
      })
      
  end,
}) 
