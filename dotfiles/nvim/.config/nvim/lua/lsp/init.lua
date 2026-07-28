local servers = {
  "lua_ls",
  -- "ts_ls",
  "vtsls",
  "omnisharp",
  "emmet_language_server",
  "clangd",
  "rust_analyzer",
  "eslint",
  "vue_ls",
  "arduino_language_server",
}

-- No mason package exists for these two - gdscript connects to a running
-- Godot editor over TCP instead of spawning a binary, and gdshader_lsp has
-- to be installed manually (see lua/lsp/servers/gdshader_lsp.lua)
local manually_installed_servers = {
  "gdscript",
  "gdshader_lsp",
}

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = servers,
})

require("fidget").setup({})

for _, server in ipairs(servers) do
  require("lsp.servers." .. server)
  vim.lsp.enable(server)
end

for _, server in ipairs(manually_installed_servers) do
  require("lsp.servers." .. server)
  vim.lsp.enable(server)
end

require("lsp.completion")
require("lsp.diagnostics")
