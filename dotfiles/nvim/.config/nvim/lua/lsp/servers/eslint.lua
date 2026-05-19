local capabilities = require("lsp.capabilities").capabilities

vim.lsp.config("eslint", {
  capabilities = capabilities,
})
