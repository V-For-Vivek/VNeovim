local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal"
        }
    }
})

-- 1. Modern buffer keymaps mapping layout (uses standard local mapping API)
local function set_terminal_keymaps()
    local keymap = vim.keymap.set
    local opts = {
        buffer = 0
    }

    keymap("t", "<esc>", [[<C-\><C-n>]], opts)
    keymap("t", "jk", [[<C-\><C-n>]], opts)
    keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
    keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
    keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
    keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
end

-- 2. UPDATED: Replaced legacy string-based vim.cmd with modern native Lua autocommand
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        set_terminal_keymaps()
    end
})

-- 3. Custom Application Terminals Configuration
local Terminal = require("toggleterm.terminal").Terminal

-- LazyGit Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true
})
vim.keymap.set("n", "<leader>g", function()
    lazygit:toggle()
end, {
    desc = "Toggle LazyGit"
})

-- Node Terminal
local node = Terminal:new({
    cmd = "node",
    hidden = true
})
vim.keymap.set("n", "<leader>tn", function()
    node:toggle()
end, {
    desc = "Toggle Node Terminal"
})

-- NCDU Disk Usage Terminal
local ncdu = Terminal:new({
    cmd = "ncdu",
    hidden = true
})
vim.keymap.set("n", "<leader>tu", function()
    ncdu:toggle()
end, {
    desc = "Toggle NCDU Terminal"
})

-- Python REPL Terminal
local python = Terminal:new({
    cmd = "python",
    hidden = true
})
vim.keymap.set("n", "<leader>tp", function()
    python:toggle()
end, {
    desc = "Toggle Python REPL"
})
