return {
  'stevearc/conform.nvim',
  -- NOTE: when config is not defined, setup is called with `opts`
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofmt" }
    },
  },
}
