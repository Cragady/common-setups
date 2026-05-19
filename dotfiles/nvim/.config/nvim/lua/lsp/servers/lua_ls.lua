local capabilities = require("lsp.capabilities").capabilities

vim.lsp.config("lua_ls", {
  capabilities = capabilities,

  settings = {
    Lua = {
      format = {
        enable = true,

        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },

      diagnostics = {
        globals = { "vim" },
      },

      workspace = {
        checkThirdParty = false,
      },
    },
  },
})
