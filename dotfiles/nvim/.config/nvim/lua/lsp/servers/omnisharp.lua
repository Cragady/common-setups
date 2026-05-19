local capabilities = require("lsp.capabilities").capabilities
local util = require("lsp.util")

local omnisharp_bin = util.is_windows()
    and util.mason_path("bin/OmniSharp.cmd")
    or util.mason_path("packages/omnisharp/OmniSharp")

vim.lsp.config("omnisharp", {
  capabilities = capabilities,

  cmd = {
    omnisharp_bin,
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  },

  flags = {
    debounce_text_changes = 150,
  },

  -- keys = {
  --   {
  --     "gd",
  --     M.has("telescope.nvim") and function()
  --       require("omnisharp_extended").telescope_lsp_definitions()
  --     end or function()
  --       require("omnisharp_extended").lsp_definitions()
  --     end,
  --     desc = "Goto Definition",
  --   },
  -- },
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,

  handlers = {
    ["textDocument/definition"] = function(...)
      return require("omnisharp_extended").handler(...)
    end,
  },
  root_dir = vim.fs.root(0, {
    "*.sln",
    "*.csproj",
    ".git",
  }),

  -- root_dir = function(bufnr)
  --   return vim.fs.root(bufnr, function(name)
  --     return name == "MySolution.sln"
  --   end)
  -- end,
  -- root_dir = function(bufnr)
  --   return vim.fs.root(bufnr, function(name, path)
  --     return name:match("%.sln$")
  --         or name:match("%.csproj$")
  --   end)
  -- end,
})
