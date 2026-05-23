local capabilities = require("lsp.capabilities").capabilities

-- TODO: play around with snippets.json to see if you can achieve what you want here.
vim.lsp.config("emmet_language_server", {
  capabilities = capabilities,

  init_options = {
    extensionsPath = {
      vim.fn.stdpath("config") .. "/lua/lsp/servers/extra_config_files",
    },

    includeLanguages = {
      vue = "html",
    },
    --  [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {
      ["profile.allowCompactBoolean"] = true,
      ["format.inlineBreak"] = true,
    },
    -- [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    -- syntaxProfiles = {},
    -- [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    -- variables = {},
    -- -- NOTE: Options set here onlny affects the LSP auto-fill portion, mattn/emmet-vim won't respect settings here.
    -- -- May need to find a way to share settings (probs just mash them up with lua).
    -- -- NOTE: Below works, it puts in lang="doop derp" lmao
    -- -- variables = {
    -- --   lang = "doop derp"
    -- -- },
  }

})
