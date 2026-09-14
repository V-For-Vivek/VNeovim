local none_ls_status_ok, none_ls = pcall(require, "none-ls")
if not none_ls_status_ok then return end

-- 1. Safely link into the modernized global handlers sheet we built
local status_handlers_ok, handlers = pcall(require, "user.lsp.handlers")
if not status_handlers_ok then
    vim.notify("LSP Handlers module not found inside none-ls configuration!")
    return
end

-- Core shortcuts for none-ls builtins modules
local formatting = none_ls.builtins.formatting
local diagnostics = none_ls.builtins.diagnostics
local code_actions = none_ls.builtins.code_actions

-- REMOVED: The manual vim.lsp.config("clangd", ...) layout block was stripped from here. 
-- Clangd configurations are now handled cleanly inside your core mason.lua and lsp/settings workspace instead!

-- 2. Clean None-LS Setup Initialization
none_ls.setup({
    debug = false, -- Set to true if you are debugging broken formatters

    -- Inherit formatting shortcuts and floating popup designs from your handlers layout
    on_attach = handlers.on_attach,

    sources = { -- ==========================================
        -- Code Formatting Sources
        -- ==========================================
        formatting.black.with({extra_args = {"--fast"}}), formatting.stylua,
        formatting.clang_format, formatting.google_java_format,
        formatting.prettier, formatting.fixjson, formatting.beautysh, -- ==========================================
        -- Interactive Code Actions Sources
        -- ==========================================
        code_actions.eslint_d, code_actions.ltrs, code_actions.proselint,
        code_actions.refactoring,

        -- ==========================================
        -- Linter / Diagnostics Sources
        -- ==========================================
        diagnostics.cfn_lint,
        diagnostics.checkstyle.with({extra_args = {"-c", "/google_checks.xml"}}),
        diagnostics.cpplint, diagnostics.commitlint, diagnostics.eslint_d,
        diagnostics.flake8, diagnostics.golangci_lint, diagnostics.textlint,
        diagnostics.shellcheck, diagnostics.selene
    }
})
