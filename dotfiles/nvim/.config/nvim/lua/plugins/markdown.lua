return {
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function() vim.fn["mkdp#util#install"]() end,
  -- },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    -- WARN: requires deno
    build = "deno task --quiet build:fast",
    opts = {
      auto_load = true,         -- whether to automatically load preview when
                                -- entering another markdown buffer
      close_on_bdelete = true,  -- close preview window on buffer delete

      syntax = true,            -- enable syntax highlighting, affects performance

      theme = 'dark',           -- 'dark' or 'light'

      update_on_change = true,

      -- app = 'webview',
      -- app = 'browser',
      -- app = 'browser',
      -- app = { 'chromium', '--new-window' },
      app = 'webview',          -- 'webview', 'browser', string or a table of strings
                                -- explained below

      -- filetype = { 'markdown', 'conf' },
      filetype = { 'markdown' },-- list of filetypes to recognize as markdown

      -- relevant if update_on_change is true
      throttle_at = 200000,     -- start throttling when file exceeds this
                                -- amount of bytes in size
      throttle_time = 'auto',   -- minimum amount of time in milliseconds
                                -- that has to pass before starting new render
    },
    config = function(_, opts)
      require('peek').setup(opts)
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  -- see if wanted
  -- {
  --   'epwalsh/obsidian.nvim',
  -- },
}
