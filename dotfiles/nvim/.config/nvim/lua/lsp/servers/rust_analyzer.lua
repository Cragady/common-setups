local capabilities = require("lsp.capabilities").capabilities

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },

      checkOnSave = true,

      procMacro = {
        enable = true,
      },
    },
  },
})
