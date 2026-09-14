-- Helper function to quickly create groups
local function augroup(name)
    return vim.api.nvim_create_augroup(name, {
        clear = true
    })
end

-- 1. General Settings
local general_settings = augroup("_general_settings")
vim.api.nvim_create_autocmd("FileType", {
    group = general_settings,
    pattern = {"qf", "help", "man", "lspinfo"},
    callback = function()
        vim.keymap.set("n", "q", "<cmd>close<CR>", {
            buffer = true,
            silent = true
        })
    end
})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = general_settings,
    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = 200
        })
    end
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = general_settings,
    callback = function()
        vim.opt.formatoptions:remove({"c", "r", "o"})
    end
})
vim.api.nvim_create_autocmd("FileType", {
    group = general_settings,
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end
})

-- 2. Git Configuration
local git = augroup("_git")
vim.api.nvim_create_autocmd("FileType", {
    group = git,
    pattern = "gitcommit",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

-- 3. Markdown Configuration
local markdown = augroup("_markdown")
vim.api.nvim_create_autocmd("FileType", {
    group = markdown,
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

-- 4. Auto Resize Splits
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("_auto_resize"),
    command = "tabdo wincmd ="
})

-- 5. Alpha Dashboard Configuration
local alpha = augroup("_alpha")
vim.api.nvim_create_autocmd("User", {
    group = alpha,
    pattern = "AlphaReady",
    callback = function()
        vim.opt.showtabline = 0
        vim.opt.laststatus = 0

        -- Restore when leaving Alpha buffer
        vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            once = true,
            callback = function()
                vim.opt.showtabline = 2
                vim.opt.laststatus = 3
            end
        })
    end
})

-- 6. LSP Auto-formatting
-- Note: The broken "autocmd BufWriteCmd" has been safely removed.
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("_lsp"),
    callback = function()
        vim.lsp.buf.format({
            async = false
        })
    end
})
