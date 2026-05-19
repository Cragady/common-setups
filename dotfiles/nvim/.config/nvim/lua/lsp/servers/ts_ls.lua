local capabilities = require("lsp.capabilities").capabilities
local util = require("lsp.util")

local vue_plugin_path = vim.fs.normalize(
  util.mason_path(
    "packages/vue-language-server/node_modules/@vue/language-server"
  )
)

-- sanity check (VERY important)
if vim.fn.isdirectory(vue_plugin_path) == 0 then
  vim.notify("Vue TS plugin path missing: " .. vue_plugin_path, vim.log.levels.ERROR)
end

local vue_plugin = {
  name = "@vue/typescript-plugin",

  location = vue_plugin_path,

  languages = { "vue" },
}

vim.lsp.config("ts_ls", {
  capabilities = capabilities,

  init_options = {
    plugins = { vue_plugin },
  },

  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },

  root_markers = {
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
    ".git",
  },
})
