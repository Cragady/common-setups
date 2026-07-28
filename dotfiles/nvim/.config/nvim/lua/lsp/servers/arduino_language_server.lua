local capabilities = require("lsp.capabilities").capabilities

-- NOTE: mason installs the language server binary itself, but it also needs
-- `arduino-cli` on PATH (not mason-managed) - see nvim-lspconfig's bundled
-- docs (`:h lspconfig-server-configurations` -> arduino_language_server) for
-- the arduino-cli + sketch.yaml setup steps

-- UNCONFIRMED, commented out for now: arduino-language-server only accepts
-- the board FQBN as a -fqbn CLI flag on startup, it does NOT read
-- sketch.yaml itself - this attempted to pull default_fqbn out of the
-- sketch's sketch.yaml and pass it along via a dynamic cmd function, but
-- errors are still happening past this point that aren't worked out yet.
-- Revisit later. https://github.com/arduino/arduino-language-server#usage
-- local function read_fqbn(root_dir)
--   local sketch_yaml = root_dir and (root_dir .. "/sketch.yaml")
--   if not sketch_yaml or vim.fn.filereadable(sketch_yaml) == 0 then
--     return nil
--   end
--   for _, line in ipairs(vim.fn.readfile(sketch_yaml)) do
--     local fqbn = line:match("^default_fqbn:%s*(.+)$")
--     if fqbn then
--       return vim.trim(fqbn)
--     end
--   end
--   return nil
-- end

vim.lsp.config("arduino_language_server", {
  capabilities = capabilities,
  -- cmd = function(dispatchers, config)
  --   local cmd = { "arduino-language-server" }
  --   local fqbn = read_fqbn(config.root_dir)
  --   if fqbn then
  --     vim.list_extend(cmd, { "-fqbn", fqbn })
  --   end
  --   return vim.lsp.rpc.start(cmd, dispatchers, {
  --     cwd = config.cmd_cwd,
  --     env = config.cmd_env,
  --   })
  -- end,
})
