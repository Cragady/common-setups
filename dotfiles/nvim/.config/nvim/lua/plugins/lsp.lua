-- TODO: clean up mess in this file and other files for omnisharp setup

local M = {}

local data_dir = vim.fn.stdpath('data')

function M.has()
end

local vim_info = vim.version()
-- vim_info.major
-- vim_info.minor
-- vim_info.patch

local mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  -- commit = "1a31f824b9cd5bc6f342fc29e9a53b60d74af245",
  -- tag = "v1.32.0",
  -- branch = "v1.x",
}

-- print(vim.inspect(vim_info))
if ((vim_info.major == 0) and (vim_info.minor < 11)) then
  mason_lspconfig = {
    "williamboman/mason-lspconfig.nvim",
    -- commit = "1a31f824b9cd5bc6f342fc29e9a53b60d74af245",
    -- tag = "v1.32.0",
    branch = "v1.x",
  }
end

return {
  {
    'Hoffs/omnisharp-extended-lsp.nvim',
    lazy = true,
  },
  {
    -- NOTE: replaces -- 'VonHeikemen/lsp-zero.nvim'
    'neovim/nvim-lspconfig',
    dependencies = {
      "stevearc/conform.nvim",
      "williamboman/mason.nvim",
      mason_lspconfig,
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      -- {"hrsh7th/cmp-nvim-lua"}, -- check
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- {"rafamadriz/friendly-snippets"}, -- check
      "j-hui/fidget.nvim",
    },
    opts = {},
    config = function(_, opts)
      require('conform').setup({
        formatters_by_ft = {
        },
      })
      local cmp = require('cmp')
      local cmp_lsp = require('cmp_nvim_lsp')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
      )
      local uname = vim.loop.sysname
      -- local mason_registry = require('mason-registry')

      require('fidget').setup({})
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          -- "volar",
          "vue_ls",
          "clangd",
          "lua_ls",
          "rust_analyzer",
          "csharpier",
          "omnisharp",
          "netcoredbg",
        },
        handlers = {
          function(server_name) -- default handler (optional)
            require('lspconfig')[server_name].setup {
              capabilities = capabilities
            }
          end,

          --  TODO: see if wanted
          -- zls = function()
          --   local lspconfig = require("lspconfig")
          --   lspconfig.zls.setup({
          --     root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
          --     settings = {
          --       zls = {
          --         enable_inlay_hints = true,
          --         enable_snippets = true,
          --         warn_style = true,
          --       },
          --     },
          --   })
          --   vim.g.zig_fmt_parse_errors = 0
          --   vim.g.zig_fmt_autosave = 0

          -- end,

          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  format = {
                    enable = true,
                    -- Put format options here
                    -- NOTE: the value should be STRING!!
                    defaultConfig = {
                      indent_style = "space",
                      indent_size = "2",
                    }
                  },
                }
              }
            }
          end,

          ['omnisharp'] = function()
            -- TODO: clean up & find way to start lsp server in a sub-dir
            -- that contains csproj or other file, or just start with .cs
            local lspconfig = require('lspconfig')
            local mason_registry = require('mason-registry')
            -- local uname = vim.loop.sysname

            -- print('setting up omnisharp')
            -- lspconfig.omnisharp.setup({
            --   capabilities = capabilities,
            --   handlers = {
            --     ["textDocument/definition"] = function(...)
            --       return require("omnisharp_extended").handler(...)
            --     end,
            --   },
            --   keys = {
            --     {
            --       "gd",
            --       M.has("telescope.nvim") and function()
            --         require("omnisharp_extended").telescope_lsp_definitions()
            --       end or function()
            --         require("omnisharp_extended").lsp_definitions()
            --       end,
            --       desc = "Goto Definition",
            --     },
            --   },
            --   enable_roslyn_analyzers = true,
            --   organize_imports_on_format = true,
            --   enable_import_completion = true,
            -- })

            -- NOTE: OS os get uname linux windows osx
            -- (Optional) Omnisharp-Roslyn/C#/Unity
            -- if uname == "Linux" then
            local omni_log_dir = os.getenv("HOME") .. "/.vim/OmiSharp_log"
            local mason_install_path = vim.fn.expand("$MASON")
            local omni_bin = mason_install_path .. '/bin/OmniSharp.cmd'

            -- local uname = assert(vim.loop.os_uname().sysname)
            -- uname = string.lower(uname)
            -- local is_windows = string.find(uname, 'windows')
            -- vim.g.OmniSharp_log_dir = omni_log_dir
            local pid = vim.fn.getpid()
            -- local omnisharp_bin = "/opt/omnisharp-roslyn/run"
            lspconfig.omnisharp.setup{
              capabilities = capabilities,
              -- on_attach = lsp.on_attach, -- Likely not needed
              flags = {
                debounce_text_changes = 150,
              },
              -- cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) };
              -- cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp.dll" },
              -- cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp.dll" },
              cmd = { omni_bin, "--languageserver", "--hostPID", tostring(pid) },
              enable_roslyn_analyzers = true,
              organize_imports_on_format = true,
              enable_import_completion = true,
              -- log_dir = omni_log_dir,
              -- root_dir = function ()
              --     return vim.loop.cwd() -- current working directory
              -- end,
            }
            -- else
            --   lspconfig.omnisharp.setup({
            --     capabilities = capabilities,
            --   })
            -- end
          end,

          ['ts_ls'] = function()
            local lspconfig = require('lspconfig')
            local mason_install_path = vim.fn.expand("$MASON")
            local vue_lsp_path = mason_install_path .. '/packages/vue-language-server/node_modules/@vue/language-server'
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
              filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            }
          end,

          -- ['volar'] = function()
          --   local lspconfig = require('lspconfig')
          --   lspconfig.volar.setup {
          --     -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          --     init_options = {
          --       vue = {
          --         hybridMode = false,
          --       },
          --     },
          --   }
          -- end,

          ['gdscript'] = function()
            local lspconfig = require('lspconfig')
            local port = os.getenv 'GDScript_Port' or '6005'
            local cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port))
            lspconfig.gdscript.setup {
              name = 'godot',
              cmd = cmd,
              filetypes = { 'gd', 'gdscript', 'gdscript3' },
              root_dir = lspconfig.util.root_pattern('project.godot', '.git'),
              docs = {
                description = [[
https://github.com/godotengine/godot

Language server for GDScript, used by Godot Engine.
]],
              },
            }
          end,
          ['gshader_lsp'] = function()
            local lspconfig = require('lspconfig')
            -- TODO: implement gdshader-lsp https://github.com/godofavacyn/gdshader-lsp
            -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/gdshader_lsp.lua#L4
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#gdshader_lsp
            -- https://www.reddit.com/r/neovim/comments/1c2bhcs/godotgdscript_in_neovim_with_lsp_and_debugging_in/
            lspconfig.gdshader_lsp.setup {
              cmd = { 'gdshader-lsp', '--stdio' },
              filetypes = { 'gdshader', 'gdshaderinc' },
              root_dir = lspconfig.util.root_pattern 'project.godot',
              docs = {
                description = [[
https://github.com/godofavacyn/gdshader-lsp

A language server for the Godot Shading language.
]],
              },
            }
          end,
        },
      })

      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          -- { name = "copilot", group_index = 2 },
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
        })
      })

      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- local lspconfig = require('lspconfig')

    end
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.csharpier)
    end,
  },
}
