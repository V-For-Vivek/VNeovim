-- ==========================================
-- Global Settings & Leader Setup
-- ==========================================
-- Set leader keys BEFORE any mappings are declared
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Shorten function name to the modern standard API
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap space as leader key and prevent it from moving the cursor
keymap("", "<Space>", "<Nop>", {silent = true})

-- ==========================================
-- Normal Mode ("n")
-- ==========================================
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h",opts)
keymap("n", "<C-j>", "<C-w>j",opts)
keymap("n", "<C-k>", "<C-w>k",opts)
keymap("n", "<C-l>", "<C-w>l",opts)

-- Resize with arrows (Using clean <cmd> syntax to hide the command-bar flash)
keymap("n", "<C-Up>", "<cmd>resize -2<CR>")
keymap("n", "<C-Down>", "<cmd>resize +2<CR>")
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>")
keymap("n", "<S-h>", "<cmd>bprevious<CR>")
keymap("n", "<S-c>", "<cmd>bd<CR>")

-- Move text lines up and down
keymap("n", "<A-j>", "<cmd>m .+1<CR>==")
keymap("n", "<A-k>", "<cmd>m .-2<CR>==")

-- Nvim Tree Toggle
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

-- Telescope Lookups
keymap("n", "ff", "<cmd>Telescope find_files<CR>")
keymap("n", "fl", "<cmd>Telescope live_grep<CR>")

keymap('n', 'tf', '<cmd>ToggleTerm direction=float<CR>',
       {desc = "Toggle Float Term"})
keymap('t', 'tf', '<cmd>ToggleTerm<CR>', {desc = "Toggle Float Term"})

-- Outline
keymap("n", "<leader>o", "<cmd>Outline<CR>", {desc = "Toggle Code Outline"})

-- Shift+Arrows Block Selection (Normal)
keymap("n", "<S-Up>", "v<Up>")
keymap("n", "<S-Down>", "v<Down>")
keymap("n", "<S-Left>", "v<Left>")
keymap("n", "<S-Right>", "v<Right>")

-- ==========================================
-- Insert Mode ("i")
-- ==========================================
-- Press jk or kj fast to exit insert mode
keymap("i", "jk", "<ESC>")
keymap("i", "kj", "<ESC>")

-- Shift+Arrows Block Selection (Insert)
keymap("i", "<S-Up>", "<Esc>v<Up>")
keymap("i", "<S-Down>", "<Esc>v<Down>")
keymap("i", "<S-Left>", "<Esc>v<Left>")
keymap("i", "<S-Right>", "<Esc>v<Right>")

-- ==========================================
-- Visual Mode ("v")
-- ==========================================
-- Stay in visual indent mode when shifting columns
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move highlighted lines up and down smoothly (FIXED: Using <cmd> syntax)
keymap("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv")
keymap("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv")

-- Standard paste behavior adjustment (prevents rewriting your paste register)
keymap("v", "p", '"_dP')

-- Shift+Arrows Block Selection (Visual)
keymap("v", "<S-Up>", "<Up>")
keymap("v", "<S-Down>", "<Down>")
