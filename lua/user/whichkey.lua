local status_ok, which_key = pcall(require, "which-key")
if not status_ok then return end

-- 1. Modern V3.0 Configuration Block
which_key.setup({
    preset = "classic", -- Enables core default help mapping presets automatically
    plugins = {
        marks = true,
        registers = true,
        spelling = {enabled = true, suggestions = 20}
    },
    icons = {breadcrumb = "»", separator = "➜", group = "+"},
    -- Modern window layout configuration
    win = {
        border = "rounded",
        position = "bottom",
        margin = {1, 0, 1, 0},
        padding = {2, 2, 2, 2},
        wo = {winblend = 0}
    },
    layout = {spacing = 3, align = "left"},
    disable = {
        modes = {"i", "v"} -- Replaces legacy blacklist array blocks
    }
})

-- FIXED FOR NVIM 0.12+: Pre-register parent folders strictly as structural groups.
which_key.add({
    {"<leader>f", group = "Find/Files"}, {"<leader>p", group = "Lazy"},
    {"<leader>g", group = "Git"}, {"<leader>l", group = "LSP"},
    {"<leader>s", group = "Search"}, {"<leader>t", group = "Terminal"}
})

-- 2. Modernized Mappings Grid using the new .add() API layout
which_key.add({
    -- Top Level Controls
    {"<leader>a", "<cmd>Alpha<cr>", desc = "Alpha"}, {
        "<leader>b",
        function()
            require('telescope.builtin').buffers(
                require('telescope.themes').get_dropdown {previewer = false})
        end,
        desc = "Buffers"
    }, {"<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer"},
    {"<leader>o", "<cmd>Outline<CR>", desc = "Code Outline"},
    {"<leader>w", "<cmd>w!<CR>", desc = "Save"},
    {"<leader>q", "<cmd>q!<CR>", desc = "Quit"},
    {"<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer"},
    {"<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight"},

    -- Find / Files Lookups
    {
        "<leader>fd",
        function()
            require('telescope.builtin').find_files(
                require('telescope.themes').get_dropdown {previewer = false})
        end,
        desc = "Find files (Dropdown)"
    },
    {"<leader>F", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Find Text"},
    {
        "<leader>P",
        function() require('telescope').extensions.projects.projects() end,
        desc = "Projects"
    }, -- Lazy.nvim Plugin Manager Group
    {"<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync Plugins"},
    {"<leader>ph", "<cmd>Lazy home<cr>", desc = "Lazy Home"},
    {"<leader>pl", "<cmd>Lazy log<cr>", desc = "Lazy Log"},
    {"<leader>pu", "<cmd>Lazy update<cr>", desc = "Update Plugins"},

    -- Git Operations Group
    {
        "<leader>gg",
        function()
            if _LAZYGIT_TOGGLE then
                _LAZYGIT_TOGGLE()
            else
                vim.cmd("ToggleTerm direction=float")
                vim.cmd("lazygit")
            end
        end,
        desc = "Lazygit"
    }, {
        "<leader>gj",
        function() require('gitsigns').next_hunk() end,
        desc = "Next Hunk"
    }, {
        "<leader>gk",
        function() require('gitsigns').prev_hunk() end,
        desc = "Prev Hunk"
    },
    {
        "<leader>gl",
        function() require('gitsigns').blame_line() end,
        desc = "Blame"
    }, {
        "<leader>gp",
        function() require('gitsigns').preview_hunk() end,
        desc = "Preview Hunk"
    }, {
        "<leader>gr",
        function() require('gitsigns').reset_hunk() end,
        desc = "Reset Hunk"
    }, {
        "<leader>gR",
        function() require('gitsigns').reset_buffer() end,
        desc = "Reset Buffer"
    }, {
        "<leader>gs",
        function() require('gitsigns').stage_hunk() end,
        desc = "Stage Hunk"
    }, {
        "<leader>gu",
        function() require('gitsigns').undo_stage_hunk() end,
        desc = "Undo Stage Hunk"
    },
    {"<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file"},
    {"<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch"},
    {"<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit"},
    {"<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff"},

    -- LSP Operations Group
    {
        "<leader>la",
        function() vim.lsp.buf.code_action() end,
        desc = "Code Action"
    }, {
        "<leader>ld",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Document Diagnostics"
    }, {
        "<leader>lw",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Workspace Diagnostics"
    }, {
        "<leader>lf",
        function() vim.lsp.buf.format({async = true}) end,
        desc = "Format"
    }, {"<leader>li", "<cmd>LspInfo<cr>", desc = "Info"}, {
        "<leader>lj",
        function() vim.diagnostic.goto_next() end,
        desc = "Next Diagnostic"
    }, {
        "<leader>lk",
        function() vim.diagnostic.goto_prev() end,
        desc = "Prev Diagnostic"
    },
    {
        "<leader>ll",
        function() vim.lsp.codelens.run() end,
        desc = "CodeLens Action"
    },
    {
        "<leader>lq",
        function() vim.diagnostic.setloclist() end,
        desc = "Quickfix"
    }, {"<leader>lr", function() vim.lsp.buf.rename() end, desc = "Rename"}, {
        "<leader>ls",
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "Document Symbols"
    }, {
        "<leader>lS",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "Workspace Symbols"
    }, -- Search Operations Group
    {"<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch"},
    {"<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme"},
    {"<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help"},
    {"<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages"},
    {"<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File"},
    {"<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers"},
    {"<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps"},
    {"<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands"},

    -- Terminal Quick-Launch Group
    {"<leader>tn", "<cmd>ToggleTerm direction=float<cr>node<CR>", desc = "Node"},
    {"<leader>tu", "<cmd>ToggleTerm direction=float<cr>ncdu<CR>", desc = "NCDU"},
    {
        "<leader>tp",
        "<cmd>ToggleTerm direction=float<cr>python<CR>",
        desc = "Python"
    }, {"<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float"}, {
        "<leader>th",
        "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
        desc = "Horizontal"
    }, {
        "<leader>tv",
        "<cmd>ToggleTerm size=80 direction=vertical<cr>",
        desc = "Vertical"
    }
})
