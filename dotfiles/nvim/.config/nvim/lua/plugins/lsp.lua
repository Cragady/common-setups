return {
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    lazy = true,
  },

  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",

      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      "j-hui/fidget.nvim",
    },

    config = function()
      require("lsp")
    end,
  },

  {
    "stevearc/conform.nvim",

    opts = {
      formatters_by_ft = {},
    },
  },

  {
    "nvimtools/none-ls.nvim",

    optional = true,

    opts = function(_, opts)
      local nls = require("null-ls")

      opts.sources = opts.sources or {}

      table.insert(
        opts.sources,
        nls.builtins.formatting.csharpier
      )
    end,
  },
}
