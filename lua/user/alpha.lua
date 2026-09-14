local status_ok, alpha = pcall(require, "alpha")
if not status_ok then return end

local dashboard = require("alpha.themes.dashboard")

-- 1. Main ASCII Header Definition
dashboard.section.header.val = {
    " █████   ███████████   █████                              ███                ",
    "░░███   ░░███░░██████ ░░███                              ░░░                 ",
    " ░███    ░███ ░███░███ ░███   ██████  ██████  █████ █████████ █████████████  ",
    " ░███    ░███ ░███░░███░███  ███░░██████░░███░░███ ░░███░░███░░███░░███░░███ ",
    " ░░███   ███  ░███ ░░██████ ░███████░███ ░███ ░███  ░███ ░███ ░███ ░███ ░███ ",
    "  ░░░█████░   ░███  ░░█████ ░███░░░ ░███ ░███ ░░███ ███  ░███ ░███ ░███ ░███ ",
    "    ░░███     █████  ░░█████░░██████░░██████   ░░█████   ██████████░███ █████",
    "     ░░░     ░░░░░    ░░░░░  ░░░░░░  ░░░░░░     ░░░░░   ░░░░░░░░░░ ░░░ ░░░░░ ",
    "                                                                             "
}

-- 2. Button Short-key Assignments
dashboard.section.buttons.val = {
    dashboard.button("f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
    dashboard.button("e", "  New file", "<cmd>ene | startinsert<CR>"),
    dashboard.button("p", "  Find project", "<cmd>Telescope projects<CR>"),
    dashboard.button("r", "󰄉  Recently used files",
                     "<cmd>Telescope oldfiles<CR>"),
    dashboard.button("t", "󰊄  Find text", "<cmd>Telescope live_grep<CR>"),
    dashboard.button("c", "  Configuration", "<cmd>e $MYVIMRC<CR>"),
    dashboard.button("q", "󰅚  Quit Neovim", "<cmd>qa<CR>")
}

-- 3. Footer Definition
local function footer() return "Be Enigmatic 👾" end

dashboard.section.footer.val = footer()

-- 4. Aesthetic Highlight Assignments
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

-- Prevent alpha dashboard from throwing tracking hooks when not ready
dashboard.config.opts.noautocmd = true

-- 5. Native Setup Initiation
alpha.setup(dashboard.opts)

-- 6. Modern Native Autocommand Implementation (Replaces legacy vim.cmd block)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function() vim.opt_local.foldenable = false end
})
