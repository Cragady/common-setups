return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local nvim_tree = require("nvim-treesitter")

      nvim_tree.setup({
        -- indent = {
        --   enable = true
        -- },
        -- highlight = {
        --   -- `false` will disable the whole extension
        --   enable = true,
        --   additional_vim_regex_highlighting = false,
        -- },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
        auto_install = true,
      })

      nvim_tree.install({
        "vimdoc", "javascript", "typescript", "cpp", "c", "c_sharp", "lua",
        "rust", "jsdoc", "bash", "go", "python", "vim", "query", "vue", "css",
      });


    -- -- Enable Treesitter highlighting for all supported buffers
    -- vim.api.nvim_create_autocmd("FileType", {
    --   callback = function(args)
    --     -- Check if a treesitter parser exists for the current filetype
    --     local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    --     if lang then
    --       vim.treesitter.start(args.buf, lang)
    --       vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    --     end
    --   end,
    -- })




    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",

      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype

        -- Enable highlighting if parser exists
        pcall(vim.treesitter.start, buf, ft)

        -- Enable treesitter indentation if parser exists
        local ok = pcall(vim.treesitter.language.add, ft)

        if ok then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
      end,
    })

    end
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    config = function()
      require'treesitter-context'.setup{
        enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false, -- Enable multiwindow support.
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }

      vim.keymap.set({'n'}, '<leader>tsc', '<cmd>TSContext toggle<CR>')

    end
  },

  -- {
  --   'nvim-treesitter/playground',
  -- },
  -- {
  --   'nvim-treesitter/nvim-treesitter-context',
  -- },
}
