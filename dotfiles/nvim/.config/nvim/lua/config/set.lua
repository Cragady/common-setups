--vim.opt.guicursor = ""

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.nu = true
vim.opt.relativenumber = true

-- https://github.com/sitiom/nvim-numbertoggle/blob/main/plugin/numbertoggle.lua
local augroup = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
   pattern = "*",
   group = augroup,
   callback = function()
      if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
         vim.opt.relativenumber = true
      end
   end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
   pattern = "*",
   group = augroup,
   callback = function()
      if vim.o.nu then
         vim.opt.relativenumber = false
         -- NOTE: with the chagnes in 0.11.0, this screws with `vim.lsp.buf.code_action()`
         -- if behavior is whack without `vim.cmd "redraw"` please find an alternative
         -- for this behavior
         -- vim.cmd "redraw"
      end
   end,
})
-- end https://github.com/sitiom/nvim-numbertoggle/blob/main/plugin/numbertoggle.lua

-- 4 space indent for now
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- see how you feel about this
vim.opt.wrap = false

-- use undodir for backups instead of swp
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Buffers the cursor so that there's 8 lines from bottom
-- vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

