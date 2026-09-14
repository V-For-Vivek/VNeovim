local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
    vim.notify("Neovim Treesitter Status Not Ok !")
    return
end

-- In recent updates, configs.setup was replaced by a top-level .setup method
treesitter.setup({
    ensure_installed = {"c", "cpp", "java", "lua", "vim", "javascript", "markdown", "json"},
    auto_install = true,
    highlight = {
        enable = true -- false will disable the whole extension
    },
    autopairs = {
        enable = true
    },
    indent = {
        enable = true,
        disable = {"python", "css"}
    },

    -- The broken rainbow configuration block has been cleanly removed from here

    context_commentstring = {
        enable = true
    }
})
