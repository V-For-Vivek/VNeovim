local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
    return
end

-- Safe option for true colors 
vim.opt.termguicolors = true

-- Configure listchars to show spaces as dots 
vim.opt.list = true
vim.opt.listchars:append "space:."

-- Initialize modern V3 configuration
ibl.setup {
    -- 1. Main indent behavior and character configurations
    indent = {
        char = "▎"
    },

    -- 2. Context / Scope configurations 
    scope = {
        enabled = true,
        show_start = true,
        include = {
            node_type = {
                -- OPTIMIZED: Cleaned layout mapping for broader Treesitter node matching
                ["*"] = {"class", "return", "function", "method", "if_statement", "while_statement", "for_statement",
                         "jsx_element", "jsx_self_closing_element", "block", "arguments", "else_clause",
                         "try_statement", "catch_clause", "import_statement", "operation_type", "table", "object"}
            }
        }
    },

    -- 3. File exclusions 
    exclude = {
        buftypes = {"terminal", "nofile"},
        filetypes = {"help", "startify", "dashboard", "packer", "neogitstatus", "NvimTree", "Trouble"}
    }
}
