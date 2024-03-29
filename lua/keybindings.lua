-- map('模式', '按键', '映射lsp_finder为', 'options')
local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

-- -- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- -- 关闭当前
-- map("n", "sc", "<C-w>c", opt)
-- -- 关闭其他
-- map("n", "so", "<C-w>o", opt)
--
-- Resize with arrows
map("n", "<C-S-Up>", ":resize -2<CR>", opt)
map("n", "<C-S-Down>", ":resize +2<CR>", opt)
map("n", "<C-S-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-S-Right>", ":vertical resize +2<CR>", opt)
-- 等比例
-- map("n", "s=", "<C-w>=", opt)
-- Terminal相关
-- map("n", "<leader>tt", ":sp | terminal<CR>", opt)
-- map("n", "<leader>tv", ":vsp | terminal<CR>", opt)
-- Esc 回 Normal 模式
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<C-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<C-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<C-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<C-l>", [[ <C-\><C-N><C-w>l ]], opt)
map("t", "<C-t>", "<cmd>exe v:count1 . \"ToggleTerm\"<CR>", opt)

-- tmux
map("n", "<C-h>", ":TmuxNavigateLeft<cr>", opt)
map("n", "<C-j>", ":TmuxNavigateDown<cr>", opt)
map("n", "<C-k>", ":TmuxNavigateUp<cr>", opt)
map("n", "<C-l>", ":TmuxNavigateRight<cr>", opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

--
-- 上下滚动浏览
map("n", "<C-u>", "10k", opt)
map("n", "<C-d>", "10j", opt)

-- 退出
map("n", "<leader>q", ":q<CR>", opt)
map("n", "<leader>qq", ":q!<CR>", opt)
map("n", "<leader>Q", ":qa!<CR>", opt)
-- mention
-- map("n", "H", "^", opt);
-- map("n", "L", "$", opt);
-- bufferline switch
map("n", "<S-h>",  "<cmd>BufferLineCyclePrev<CR>", opt);
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", opt);

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)
-- insert 模式下，jk 表示 esj
map("i", "jk", "<ESC>", opt)
-- 重新加载配置文件
-- map("n", "<leader>vr", ":source ~/.config/nvim/init.lua<CR>", opt)
-- 取消搜索高亮
map("n", "<c-n>", ":nohls<CR>", opt)
-- 折叠块
map('n', 'zc', ':foldclose<CR>', opt)
map('n', 'zo', ':foldopen<CR>', opt)

-- ===========
-- 插件快捷键
-- ===========
local pluginKeys = {}
-- ===========
-- =========== nvim-tree
-- ===========
-- alt + m 键打开关闭tree
map("n", "tt", ":NvimTreeToggle<CR>", opt)
-- 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- 显示隐藏文件
  { key = "i", action = "toggle_ignored" }, -- Ignore (node_modules)
  { key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
  -- 文件操作
  { key = "<F5>", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "s", action = "system_open" },
}

-- ============
-- ============ -- bufferline
-- ============
-- 关闭
map("n", "<leader>q", ":Bdelete!<CR>", opt)

pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-n>"] = "move_selection_next",
    ["<C-p>"] = "move_selection_previous",
    -- 历史记录
    ["<C-j>"] = "cycle_history_next",
    ["<C-k>"] = "cycle_history_prev",
    -- 关闭窗口
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
  n = {
    ["<C-o>"] = 'delete_buffer',
  }
}

--===========
--=========== lsp 回调函数快捷键设置
--===========
-- [[
-- 大部分迁移到 which-key
-- ]]
pluginKeys.mapLSP = function(mapbuf)
  mapbuf("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
  mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  mapbuf("n", "gD", "<cmd>Lspsaga peek_definition<CR>", opt)
  -- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  mapbuf("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opt)
  mapbuf("n", "gr", "<cmd>Telescope lsp_references<CR>", opt)
  -- mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  mapbuf("n", "K", "<cmd>Lspsaga hover_doc<CR>", opt)
  -- mapbuf("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opt)
  -- mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
  mapbuf("n", "gP", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opt)
end

-- ======
-- ====== 函数参数提示
-- ======
pluginKeys.lsp_signature_key = '<C-j>'

-- ====
-- ==== hop
-- ====
map("n", "<leader><leader>w", ":HopWord<CR>", opt)
map("n", "<leader><leader>b", ":HopWordBC<CR>", opt)
map("n", "<leader><leader>j", ":HopLineAC<CR>", opt)
map("n", "<leader><leader>k", ":HopLineBC<CR>", opt)
map("n", "<leader><leader>/", ":HopPattern ", opt)
map("n", "<leader><leader>l", ":HopWordCurrentLineAC<CR>", opt)
map("n", "<leader><leader>h", ":HopWordCurrentLineBC<CR>", opt)

pluginKeys.whichKeyMapForNormal = {
  ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
  ["f"] = { "<cmd>Telescope git_files<CR>", "Find Git Files" },
  -- lsp 基本操作
  -- ["gh"] = { vim.lsp.buf.hover, "Show hover" },
  -- ["gI"] = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
  -- ["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
  -- ["gp"] = { vim.diagnostic.open_float, "Peek definition" },
  -- git 相关
  g = {
    name = "git",
    j = { "<cmd>Gitsigns next_hunk<CR>", "Next Hunk"},
    k = { "<cmd>Gitsigns prev_hunk<CR>", "Previous Hunk"},
    s = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk"},
    R = { "<cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },
    p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk"},
    b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle Current Line Blame"},
    d = { "<cmd>Gitsigns diffthis HEAD<CR>", "Git Diff"},
    f = { "<cmd>Telescope git_status<CR>" , "Open Changed File" },
    o = { "<cmd>Telescope git_branches<CR>", "Checkout Branch" },
    c = { "<cmd>Telescope git_bcommits<CR>", "Checkout Commit(for current file)" },
  },
  b = {
    name = "Buffers",
    j = { "<cmd>BufferLinePick<CR>", "Jump" },
    f = { "<cmd>Telescope buffers<CR>", "Find" },
    e = {
      "<cmd>BufferLinePickClose<CR>",
      "Pick which buffer to close",
    },
  -- 左右Tab切换
    h = { "<cmd>BufferLineCloseLeft<CR>", "Close all to the left" },
    l = { "<cmd>BufferLineCloseRight<CR>", "Close all to the right" },
    s = {
      "<cmd>BufferLineSortByDirectory<CR>",
      "Sort by directory",
    },
    S = {
      "<cmd>BufferLineSortByExtension<CR>",
      "Sort by language",
    },
  },
  d = {
    name = "dap",
    -- d = { ":call vimspector#Launch()<CR>", "Launch"},
    -- e = { ":call vimspector#Reset()<CR>", "Reset"},
    -- c = { ":call vimspector#Continue()<CR>", "Continue"},
    -- t = { ":call vimspector#ToggleBreakpoint()<CR>", "Toggle Breakpoint"},
    -- T = { ":call vimspector#ClearBreakpoints()<CR>", "Clear Breakpoints"},
    -- j = { "<Plug>VimspectorStepOver", "Step Over"},
    -- k = { "<Plug>VimspectorStepOut", "Step Out"},
    -- l = { "<Plug>VimspectorStepInto", "Step Into"},
  },
  l = {
    name = "lsp",
    -- a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>", "Buffer Diagnostics" },
    w = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
    i = { "<cmd>LspInfo<CR>", "Info" },
    c = { ":lua require('neogen').generate()", "Generator Doc Comment"},
    l = {
      function()
        local config = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
          format = function(d)
            local t = vim.deepcopy(d)
            local code = d.code or (d.user_data and d.user_data.lsp.code)
            if code then
              t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
            end
            return t.message
          end,
        }
        config.scope = "line"
        vim.diagnostic.open_float(0, config)
      end,
      "Show line diagnostics",
    },
    I = { "<cmd>LspInfo<CR>", "Lsp Info" },
    -- j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    -- k = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },
    j = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
    k = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev Diagnostic" },
    J = {
      function()
        require("Lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
      end ,
      "Next Error",
    },
    K = {
      function()
        require("Lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end ,
      "Prev Error",
    },
    A = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    n = { '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', "Next Variable" },
    p = { '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', "Previous Variable" }
    -- r = { "<cmd>Lspsaga rename<CR>", "Rename" },
  },
  s = {
    name = "Search",
    a = {"<cmd>Telescope file_browser<CR>", "File Browser"},
    b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    f = { "<cmd>Telescope find_files<CR>", "File" },
    h = { "<cmd>Telescope help_tags<CR>", "Help" },
    r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    R = { "<cmd>Telescope registers<CR>", "Registers" },
    t = { "<cmd>Telescope live_grep<CR>", "Live Grep Case Smart" },
    s = { require("plugin-config.telescope.custom-finder").live_grep_strict, "Live Grep Strict" },
    w = { require("plugin-config.telescope.custom-finder").live_grep_word, "Live Grep Word" },
    c = { require("plugin-config.telescope.custom-finder").live_grep_case_sensitive, "Live Search Case Sensitively" },
    k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
    C = { "<cmd>Telescope commands<CR>", "Commands" },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
  },
  w = {
    name = "windows",
    h = {
      "<C-W>_",
      "Max Height"
    },
    w = {
      "<C-W>|",
      "Max Width"
    },
    r = {
      "<C-W>=",
      "Resize All"
    },
    c = {
      "<C-w>c",
      "Close current window"
    },
    o = {
      "<C-w>o",
      "Close other window"
    },
  },
  z = {
    name = "work smarter",
    -- 以下快捷键由其他文件拓展注册
    -- 在 lua/custom-func 中可以找到
  },
  t = {
    name = "terminal",
    f = {
      "<cmd>lua require'plugin-config.toggleterm'.toggleA()<CR>",
      "Open the float terminal"
    },
    r = {
      "<cmd>lua require'plugin-config.toggleterm'.toggleB()<CR>",
      "Open the right terminal"
    },
    b = {
      "<cmd>lua require'plugin-config.toggleterm'.toggleC()<CR>",
      "Open the bottom terminal"
    },
    g = {
      "<cmd>lua require'plugin-config.toggleterm'.lazygit_toggle()<CR>",
      "Open the float lazygit window"
    },
    a = {
      "<cmd>ToggleTermToggleAll<CR>",
      "Toggle terminal all"
    },
  },
}

pluginKeys.whichKeyMapForVisual = {
  g = {
    name = "git",
    s = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Chunk"},
  },
  l = {
    name = "lsp",
    f = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Formatting" },
  }
}

return pluginKeys
