local servers = {
  "lua_ls",
  -- "ts_ls",
  "vtsls",
  "omnisharp",
  -- "gdscript",
  -- "gdshader_lsp",
  "clangd",
  "rust_analyzer",
  "eslint",
  "vue_ls",
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

require("lsp.completion")
require("lsp.diagnostics")
