-- ==========================================
-- Global Settings & Leader Setup
-- ==========================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.timeoutlen = 2500

local keymap = vim.keymap.set
local opts = {noremap = true, silent = true}

-- ==========================================
-- Normal Mode ("n")
-- ==========================================
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-Up>", "<cmd>resize -2<CR>")
keymap("n", "<C-Down>", "<cmd>resize +2<CR>")
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

keymap("n", "<S-l>", "<cmd>bnext<CR>")
keymap("n", "<S-h>", "<cmd>bprevious<CR>")
keymap("n", "<S-c>", "<cmd>bd<CR>")

keymap("n", "<A-j>", "<cmd>m .+1<CR>==")
keymap("n", "<A-k>", "<cmd>m .-2<CR>==")

keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>",
       {desc = "Telescope Find Files"})
keymap("n", "<leader>fl", "<cmd>Telescope live_grep<CR>",
       {desc = "Telescope Live Grep"})

keymap('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>',
       {desc = "Toggle Float Term"})
keymap('t', '<leader>tf', '<cmd>ToggleTerm<CR>', {desc = "Toggle Float Term"})

keymap("n", "<leader>o", "<cmd>Outline<CR>", {desc = "Toggle Code Outline"})

keymap("n", "<S-Up>", "v<Up>")
keymap("n", "<S-Down>", "v<Down>")
keymap("n", "<S-Left>", "v<Left>")
keymap("n", "<S-Right>", "v<Right>")

-- ==========================================
-- Insert Mode ("i")
-- ==========================================
keymap("i", "jk", "<ESC>")
keymap("i", "kj", "<ESC>")

keymap("i", "<S-Up>", "<Esc>v<Up>")
keymap("i", "<S-Down>", "<Esc>v<Down>")
keymap("i", "<S-Left>", "<Esc>v<Left>")
keymap("i", "<S-Right>", "<Esc>v<Right>")

-- ==========================================
-- Visual Mode ("v")
-- ==========================================
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

keymap("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv")
keymap("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv")

keymap("v", "p", '"_dP')

keymap("v", "<S-Up>", "<Up>")
keymap("v", "<S-Down>", "<Down>")

keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", {desc = "Lazygit"})
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", {desc = "Diff Hunk"})
keymap("n", "<leader>gl", "<cmd>Gitsigns blame_line<CR>", {desc = "Blame Line"})
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>",
       {desc = "Checkout branch"})
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>",
       {desc = "Checkout commit"})

-- Git Hunks sub-group (<leader>gh...)
keymap("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>", {desc = "Stage Hunk"})
keymap("n", "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<CR>",
       {desc = "Undo Stage Hunk"})
keymap("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<CR>", {desc = "Reset Hunk"})
keymap("n", "<leader>ghR", "<cmd>Gitsigns reset_buffer<CR>",
       {desc = "Reset Buffer"})
keymap("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk<CR>",
       {desc = "Preview Hunk"})
keymap("n", "<leader>ghj", "<cmd>Gitsigns next_hunk<CR>", {desc = "Next Hunk"})
keymap("n", "<leader>ghk", "<cmd>Gitsigns prev_hunk<CR>", {desc = "Prev Hunk"})
keymap("n", "<leader>gho", "<cmd>Gitsigns open_deleted<CR>",
       {desc = "Open changed file"})
