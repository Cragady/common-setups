local capabilities = require("lsp.capabilities").capabilities

vim.lsp.config("gdshader_lsp", {
  capabilities = capabilities,

  cmd = {
    "gdshader-lsp",
    "--stdio",
  },

  filetypes = {
    "gdshader",
    "gdshaderinc",
  },

  root_dir = vim.fs.root(0, {
    "project.godot",
  }),
})
