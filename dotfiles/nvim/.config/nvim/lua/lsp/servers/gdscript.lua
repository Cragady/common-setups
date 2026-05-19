local capabilities = require("lsp.capabilities").capabilities

local port = os.getenv("GDScript_Port") or "6005"

vim.lsp.config("gdscript", {
  capabilities = capabilities,

  name = "godot",

  cmd = vim.lsp.rpc.connect("127.0.0.1", tonumber(port)),

  filetypes = {
    "gd",
    "gdscript",
    "gdscript3",
  },

  root_dir = vim.fs.root(0, {
    "project.godot",
    ".git",
  }),
})
