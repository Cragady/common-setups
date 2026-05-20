local capabilities = require("lsp.capabilities").capabilities

vim.lsp.config("vue_ls", {
  capabilities = capabilities,

  filetypes = {
    "vue",
  },

  -- init_options = {
  --   vue = {
  --     hybridMode = false,
  --   },
  -- },
})
