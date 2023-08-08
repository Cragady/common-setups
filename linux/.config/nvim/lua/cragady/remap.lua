vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<M-z>", "<cmd>set wrap!<CR>")

-- moves highlighted items
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- deletes ending newline and appends the trimmed line below with a space
vim.keymap.set("n", "J", "mzJ`z")
-- Half page jumping with cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- No new motions, just changes behavior, keeps cursor in the middle while iterating search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- Not installed or configured yet. Sounds like fun, may look into later
vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
-- deletes highlighted word and pastes over without overwriting current clipboard register
-- aka: delete to void then (put)paste before cursor
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland -- imo this is the greatest
-- Yanks the highlighted text in normal or visual to the system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- same as above, but for entire line in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- deletes to void in normal or visual
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled - ThePrimeagen (lol)
-- Useful for exiting input mode while retaining your changes
-- I don't have this issue because I didn't pick this up from 
-- from IntelliJ
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Capital "Q" is the "worst place in the universe" lmao
-- Capital "Q" replays last recorded macro. That's terrible hahaha
vim.keymap.set("n", "Q", "<nop>")
-- tmux installed, still not working - find out why
-- Out of what doesn't work, this seems like the coolest thing
-- to not work
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vvv Useful for debugging
-- vim.keymap.set("n", "<C-f>", "<cmd>!tmux neww tmux-sessionizer<CR>")
-- sometimes works - This has more to do with LSP setups
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Not currently working - find out why
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- global search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- chmod +x for current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- ?? Unknown
-- Pretty sure this opens the file, or empty buffer, in the string of the third arg
-- I won't have this, if I have a need/want for it, I'll figure out what's going on and
-- create a dir structure + change the arg to replace 'theprimeagen' with 'cragady'
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");

-- fun things
vim.keymap.set("n", "<leader>mir", "<cmd>CellularAutomaton make_it_rain<CR>");
vim.keymap.set("n", "<leader>gol", "<cmd>CellularAutomaton game_of_life<CR>");

-- sources current file (two spaces)
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

