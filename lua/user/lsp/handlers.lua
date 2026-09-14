local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    return M
end

-- 1. Initialize custom completion capabilities natively
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

-- 2. Modernized Buffer Keymaps Layout (Fixed gd and gD mappings)
local function lsp_keymaps(bufnr)
    local keymap = vim.keymap.set
    local opts = {
        buffer = bufnr,
        silent = true
    }

    -- FIXED: Swapped declaration and definition to work with modern language servers
    keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, {
        desc = "LSP: Go to Definition"
    }))
    keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, {
        desc = "LSP: Go to Declaration"
    }))
    keymap("n", "gh", vim.lsp.buf.hover, vim.tbl_extend("force", opts, {
        desc = "LSP: Hover Info"
    }))
    keymap("n", "gI", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, {
        desc = "LSP: Go to Implementation"
    }))
    keymap("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, {
        desc = "LSP: Find References"
    }))
    keymap("n", "gl", vim.diagnostic.open_float, vim.tbl_extend("force", opts, {
        desc = "LSP: Open Diagnostic Float"
    }))

    keymap("n", "<leader>lf", function()
        vim.lsp.buf.format({
            async = true
        })
    end, vim.tbl_extend("force", opts, {
        desc = "LSP: Format File"
    }))
    keymap("n", "<leader>li", "<cmd>LspInfo<cr>", vim.tbl_extend("force", opts, {
        desc = "LSP: Info Panel"
    }))
    keymap("n", "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, {
        desc = "LSP: Code Action"
    }))
    keymap("n", "<leader>lj", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, vim.tbl_extend("force", opts, {
        desc = "LSP: Next Diagnostic"
    }))
    keymap("n", "<leader>lk", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, vim.tbl_extend("force", opts, {
        desc = "LSP: Prev Diagnostic"
    }))    
    keymap("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, {
        desc = "LSP: Rename Variable"
    }))
    keymap("n", "<leader>ls", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, {
        desc = "LSP: Signature Help"
    }))
    keymap("n", "<leader>lq", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, {
        desc = "LSP: Quickfix Diagnostics"
    }))
end

-- 3. Core Attach Pipeline Setup
M.on_attach = function(client, bufnr)
    -- Disable formatting for lua_ls to prevent conflicts with stylua
    if client.name == "lua_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end

    lsp_keymaps(bufnr)

    local status_ok, illuminate = pcall(require, "illuminate")
    if status_ok then
        illuminate.on_attach(client)
    end
end

-- 4. Diagnostic Indicators Setup Block
M.setup = function()
    local config = {
        virtual_text = false, -- keeps your coding view clean and unpolluted
        -- UPDATED: Added valid visual icon for HINT
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "💡", 
                [vim.diagnostic.severity.INFO] = ""
            }
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded", -- Matches your general popup window theme
            source = "always",
            header = "",
            prefix = ""
        }
    }

    vim.diagnostic.config(config)

    -- Rounded borders configuration for native LSP hover layout parameters
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded"
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded"
    })
end

return M

