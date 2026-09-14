local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            {"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"},
            {"\nPress any key to exit..."}
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- 2. Setup plugins configuration
local plugins = { -- Useful lua functions used by lots of plugins
    {"nvim-lua/plenary.nvim"}, -- Autopairs, integrates with both cmp and treesitter
    {"windwp/nvim-autopairs"}, -- Code commenting
    {"numToStr/Comment.nvim"}, {"JoosepAlviste/nvim-ts-context-commentstring"}, -- Icons and File Tree
    {"kyazdani42/nvim-web-devicons"}, {"kyazdani42/nvim-tree.lua"}, -- Tabs and Buffers
    {"akinsho/bufferline.nvim"}, {"moll/vim-bbye"},

    -- Status line (Dependencies are defined via 'dependencies' array in lazy)
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {"kyazdani42/nvim-web-devicons"}
    }, -- Utilities & UI Extensions
    {"akinsho/toggleterm.nvim"}, {"lukas-reineke/indent-blankline.nvim"},
    {"goolord/alpha-nvim"}, {"folke/which-key.nvim"}, -- Hop Navigation
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = {"n", "x", "o"},
                function() require("flash").jump() end,
                desc = "Flash"
            }, {
                "S",
                mode = {"n", "x", "o"},
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter"
            }, {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc = "Remote Flash"
            }, {
                "R",
                mode = {"o", "x"},
                function() require("flash").treesitter_search() end,
                desc = "Treesitter Search"
            }, {
                "<c-s>",
                mode = {"c"},
                function() require("flash").toggle() end,
                desc = "Toggle Flash Search"
            }
        }
    }, -- Colorscheme
    {"navarasu/onedark.nvim"}, -- CMP Completion Ecosystem
    {"hrsh7th/nvim-cmp"}, -- The completion plugin
    {"hrsh7th/cmp-buffer"}, -- buffer completions
    {"hrsh7th/cmp-path"}, -- path completions
    {"saadparwaiz1/cmp_luasnip"}, -- snippet completions
    {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-nvim-lua"},
    {"mfussenegger/nvim-jdtls"}, -- DAP Debugger Ecosystem
    {"mfussenegger/nvim-dap"}, {"rcarriga/nvim-dap-ui"},
    {"jay-babu/mason-nvim-dap.nvim"}, -- Snippets Engine
    {"L3MON4D3/LuaSnip"}, {"rafamadriz/friendly-snippets"}, -- LSP Core Configuration
    {"neovim/nvim-lspconfig"}, {"williamboman/mason.nvim"}, -- simple to use language server installer
    {"williamboman/mason-lspconfig.nvim"}, {"nvimtools/none-ls.nvim"}, -- for formatters and linters
    {"RRethy/vim-illuminate"}, -- Fuzzy Finder
    {"nvim-telescope/telescope.nvim"}, -- Treesitter Parsers
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master", -- Crucial for your Neovim 0.11.6 version!
        build = ":TSUpdate",
        config = function()
            -- This block ONLY runs after lazy.nvim successfully downloads the plugin folder
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {"lua", "vim", "vimdoc", "query"},
                highlight = {enable = true}
            })
        end
    }, {"HiPhish/rainbow-delimiters.nvim"}, -- Git Integration
    {"lewis6991/gitsigns.nvim"}, -- UI Enhancements
    {"gen740/SmoothCursor.nvim"}, {"folke/neodev.nvim"},
    {"hedyhli/outline.nvim"}, {"j-hui/fidget.nvim"},
    {"arkav/lualine-lsp-progress"}
}

-- 3. Initialize lazy.nvim with Configuration (Replaces packer.init)
require("lazy").setup(plugins, {
    ui = {
        border = "rounded" -- Restores your rounded floating pop-up design
    }
})
