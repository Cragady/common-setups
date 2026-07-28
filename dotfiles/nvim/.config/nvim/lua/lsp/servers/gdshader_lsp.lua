local capabilities = require("lsp.capabilities").capabilities

-- NOTE: not a mason package, install manually: https://github.com/godofavacyn/gdshader-lsp
vim.lsp.config("gdshader_lsp", {
  capabilities = capabilities,
})
