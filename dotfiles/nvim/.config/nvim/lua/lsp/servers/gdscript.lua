local capabilities = require("lsp.capabilities").capabilities

-- NOTE: older version of this config also matched filetypes "gd" and
-- "gdscript3" - dropped since Neovim already maps *.gd to filetype
-- "gdscript" on its own, but "gdscript3" is worth restoring here if a
-- Godot 3 project ever needs it (filetypes = { "gdscript", "gdscript3" })
vim.lsp.config("gdscript", {
  capabilities = capabilities,
})
