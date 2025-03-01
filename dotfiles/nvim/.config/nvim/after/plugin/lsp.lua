local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')
local mason_registry = require('mason-registry')
local uname = vim.loop.sysname

require("mason-lspconfig").setup {
    ensure_installed = {
	    "ts_ls",
	    "eslint",
        "volar",
	    "clangd",
	    "lua_ls",
	    "rust_analyzer"
    },
}

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings {
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
}

-- ??
-- lsp.set_preferences({
--  	sign_icons = { }
-- })

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

-- NOTE: OS os get uname linux windows osx
-- (Optional) Omnisharp-Roslyn/C#/Unity
if uname == "Linux" then
  local pid = vim.fn.getpid()
  local omnisharp_bin = "/opt/omnisharp-roslyn/run"
  lspconfig.omnisharp.setup{
    -- on_attach = lsp.on_attach, -- Likely not needed
    flags = {
      debounce_text_changes = 150,
    },
    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) };
  }
end

local vue_lsp_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

lspconfig.ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_lsp_path,
        languages = { 'vue' },
      },
    },
  },
  -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

lspconfig.volar.setup {
  -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
}

local port = os.getenv 'GDScript_Port' or '6005'
local cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port))

lspconfig.gdscript.setup {
  cmd = cmd,
  filetypes = { 'gd', 'gdscript', 'gdscript3' },
  root_dir = lspconfig.util.root_pattern('project.godot', '.git'),
}

-- TODO: implement gdshader-lsp https://github.com/godofavacyn/gdshader-lsp
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/gdshader_lsp.lua#L4
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#gdshader_lsp
-- lspconfig.gdshader_lsp.setup {
--   cmd = { 'gdshader-lsp', '--stdio' },
--   filetypes = { 'gdshader', 'gdshaderinc' },
--   root_dir = lspconfig.util.root_pattern 'project.godot',
-- }

-- NOTE: May need to switch to Lazy.nvim as a package manager. Packer is no longer maintained

lsp.setup()

