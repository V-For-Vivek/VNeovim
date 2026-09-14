local servers = {
    "lua_ls", "pyright", "jsonls", "clangd", "jdtls", "vimls", "yamlls",
    "eslint"
}

local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "🤘",
            package_pending = "⏳",
            package_uninstalled = "🚨"
        }
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4
}

-- Initialize core Mason package manager
require("mason").setup(settings)

-- Setup the automatic installation bridge
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true
})

-- OPTIMIZED: Require the handlers module once outside the loop to boost startup speed
local status_handlers_ok, handlers = pcall(require, "user.lsp.handlers")
if not status_handlers_ok then
    vim.notify("LSP Handlers module not found inside mason.lua!")
    return
end

-- Modernized Server Configuration & Activation Loop
for _, server in ipairs(servers) do
    -- FIXED: Store the split name in a unique local variable instead of altering the loop iterator
    local server_name = vim.split(server, "@")[1]

    -- Build the options table using parameters defined in your handlers file
    local opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities
    }

    -- Deep merge specific server settings folders (e.g., user/lsp/settings/lua_ls.lua) if they exist
    local require_ok, conf_opts = pcall(require,
                                        "user.lsp.settings." .. server_name)
    if require_ok then opts = vim.tbl_deep_extend("force", conf_opts, opts) end

    -- Registers configurations and activates the server natively
    if opts and not vim.tbl_isempty(opts) then
        vim.lsp.config(server_name, opts)
    end

    -- Actively enable the server natively so it monitors matching file types
    vim.lsp.enable(server_name)
end
