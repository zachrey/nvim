-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssmodules_ls
local runtime_path = vim.split(package.path, ';')
local util = require "lspconfig".util
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local opts = {
  settings = {
    cmd = { "cssmodules-language-server" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  },
  flags = {
    debounce_text_changes = 300,
  },
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- 绑定快捷键
    require('keybindings').mapLSP(buf_set_keymap)
    -- 保存时自动格式化
    -- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
  end,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
