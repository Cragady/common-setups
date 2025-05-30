-- NOTE: mapleader and maplocalleader are now taken care of by config/lazy.lua
-- vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<M-z>", "<cmd>set wrap!<CR>")

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("t", "<A-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<A-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<A-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<A-l>", [[<C-\><C-n><C-w>l]])

-- moves highlighted items
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

-- deletes ending newline and appends the trimmed line below with a space
vim.keymap.set("n", "J", "mzJ`z")
-- Half page jumping with cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- No new motions, just changes behavior, keeps cursor in the middle while iterating search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>lspr", "<cmd>LspRestart<cr>")


-- Not installed or configured yet. Sounds like fun, may look into later
-- https://github.com/ThePrimeagen/vim-with-me
-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)

-- greatest remap ever
-- deletes highlighted word and pastes over without overwriting current clipboard register
-- aka: delete to void then (put)paste before cursor
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland -- imo this is the greatest
-- Yanks the highlighted text when in visual mode to the system clipboard
-- When executed in normal mode, it waits for a vim motion to know what to yank
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- same as above, but for entire line in normal mode, with no waiting for
-- motions in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- deletes to void in normal or visual
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- More info: `:h Q_re`, `:h x` -> `/Q`
---- :nnoremap Q gq
vim.keymap.set("n", "QQ", "Q")
vim.keymap.set("n", "Q", "gQ")
-- vim.keymap.set("n", "Q", "<nop>")

-- This now works, but neovim needs to be in an active tmux session.
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- NOTE: only for after installing conform.nvim - this is a formatter that helps
-- keep fold marks and other marks in buffer
-- vim.keymap.set("n", "<leader>f", function()
--     require("conform").format({ bufnr = 0 })
-- end)
-- vvv Useful for debugging
-- vim.keymap.set("n", "<C-f>", "<cmd>!tmux neww tmux-sessionizer<CR>")
-- Always works, just needs a propper LSP, Formatter, or Linter with the correct
-- config to work.
vim.keymap.set({"n", "v"}, "<leader>f", vim.lsp.buf.format)

-- See Editor Error - This is a diagnostic to show the error in its entirety
-- To enter the window, enter the leader see command after one of the following three commands
-- May take several goes -- AKA `<leader>vd`
vim.keymap.set("n", "<leader>see", "<cmd>lua vim.diagnostic.open_float(0, {scope = 'line'})<CR>")
-- Next Editor Error -- AKA ]d
vim.keymap.set("n", "<leader>nee", "<cmd>lua vim.diagnostic.goto_next()<CR>")
-- Previous Editor Error -- AKA [d
vim.keymap.set("n", "<leader>pee", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

-- This may work, I just don't know the context
-- for help: `:h <command>` e.g.: `:h cnext`, `:h lnext`, etc.
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- global search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- chmod +x for current file
-- Just use the CLI for this
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Edits Packer file
vim.keymap.set("n", "<leader>vecp", "<cmd>e ~/.config/nvim/lua/cragady/packer.lua<CR>");
-- Can also peek remaps with `:map`
vim.keymap.set("n", "<leader>vecr", "<cmd>e ~/.config/nvim/lua/cragady/remap.lua<CR>");

-- fun things
vim.keymap.set("n", "<leader>mir", "<cmd>CellularAutomaton make_it_rain<CR>");
vim.keymap.set("n", "<leader>gol", "<cmd>CellularAutomaton game_of_life<CR>");

-- sources current file (two spaces), I don't like this remap, just use `:so`
-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)


-- Golang specific binding
vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err"
)

