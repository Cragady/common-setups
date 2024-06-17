-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- vim.cmd.packadd("packer.nvim") --

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- THEMES
    -- https://github.com/topics/neovim-colorscheme
    -- https://dotfyle.com/neovim/colorscheme/trending
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    use ({
      'folke/tokyonight.nvim',
      as = 'tokyonight',
      config = function()
        vim.cmd('colorscheme tokyonight')
      end
    })
    use({
      'Mofiqul/vscode.nvim',
      config = function()
        vim.cmd('colorscheme vscode')
      end

    })
    use('navarasu/onedark.nvim')

    -- play around with later
    use('rktjmp/lush.nvim')
    -- /THEMES

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    -- use {
    --     'nvim-treesitter/nvim-treesitter',
    --     run = function()
    --       local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    --       ts_update()
    --     end,}
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    -- use("theprimeagen/vim-be-good")       -- see if wanted
    -- use("theprimeagen/refactoring.nvim")  -- see if wanted
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    -- use("nvim-treesitter/nvim-treesitter-context");

    -- use("epwalsh/obsidian.nvim") -- maybe

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            -- {"hrsh7th/cmp-buffer"}, -- check
            -- {"hrsh7th/cmp-path"}, -- check
            -- {"saadparwaiz1/cmp_luasnip"}, -- check
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            -- {"hrsh7th/cmp-nvim-lua"}, -- check

            -- Snippets
            { 'L3MON4D3/LuaSnip' },     -- Required
            -- {"rafamadriz/friendly-snippets"}, -- check
        }
    }

    -- use("folke/zen-mode.nvim") -- see if wanted
    use("eandrju/cellular-automaton.nvim")
    -- use("laytan/cloak.nvim")
    use('nvim-lua/plenary.nvim')

    use {
        'folke/trouble.nvim',
        requires = {
            { 'nvim-tree/nvim-web-devicons' },
        }
        -- config = function()
        --   require("trouble").setup {
        --     icons = false,
        --       -- your configuration comes here
        --       -- or leave it empty to use the default settings
        --       -- refer to the configuration section below
        --   }
        -- end
    }

    use {
        'folke/todo-comments.nvim',
        as = 'todo-comments',
        requires = {
            { 'nvim-lua/plenary.nvim' },
        }
    }

    use('mattn/emmet-vim')

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    -- Think on this one
    -- use('hiphish/rainbow-delimiters.nvim')

    use('airblade/vim-gitgutter')
    -- Alternative to above (vim-gitgutter)
    -- use('lewis6991/gitsigns.nvim')


end)
