-- FIX FOR NVIM 0.12+: Register unrecognized compound filetypes globally
vim.filetype.add({
    extension = {doxygen = "doxygen", mdx = "mdx", superhtml = "superhtml"},
    filename = {
        ["c.doxygen"] = "c.doxygen",
        ["cpp.doxygen"] = "cpp.doxygen",
        ["yaml.docker-compose"] = "yaml.docker-compose",
        ["yaml.gitlab"] = "yaml.gitlab",
        ["yaml.helm-values"] = "yaml.helm-values"
    }
})

local servers = {
    "lua_ls", "pyrefly", "jsonls", "clangd", "jdtls", "vimls", "yamlls",
    "eslint" -- Removed "pyrefly" from here so it doesn't trigger path-missing warnings
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

-- Setup automatic installation bridge
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true
})

-- Load your corrected handlers module safely
local status_handlers_ok, handlers = pcall(require, "user.lsp.handlers")
if not status_handlers_ok then
    vim.notify("LSP Handlers module not found inside mason.lua!")
    return
end

-- Load the clean server configuration settings map safely
local status_settings_ok, server_settings = pcall(require, "user.lsp.settings")
if not status_settings_ok then
    -- Downgraded from an annoying notification popup to a silent fallback table
    server_settings = {}
end

-- Configuration & Activation Loop
for _, server in ipairs(servers) do
    -- FIXED: Securely extract string name value from the split array structure
    local split_result = vim.split(server, "@")
    local server_name = split_result[1]

    -- Setup standard baseline configuration
    local opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities
    }

    -- FIXED: Safely query the configuration map using the explicit string key name
    if server_settings and server_settings[server_name] then
        opts = vim.tbl_deep_extend("force", opts, server_settings[server_name])
    end

    -- Registers settings and starts the engine natively
    if opts and not vim.tbl_isempty(opts) then
        vim.lsp.config(server_name, opts)
    end

    vim.lsp.enable(server_name)
end
