local capabilities = require("lsp.capabilities").capabilities

vim.lsp.config("clangd", {
  capabilities = capabilities,

  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
})
