local status_ok, outline = pcall(require, "outline")
if not status_ok then return end

outline.setup({
    outline_window = {
        position = "right",
        width = 25,
        relative_width = true,
        auto_close = false,
        -- Matches your general workspace's rounded window borders template
        winhl = "Normal:Normal,FloatBorder:Normal"
    },

    preview_window = {
        border = "rounded",
        winhl = "Normal:Normal,FloatBorder:Normal"
    },

    -- OPTIMIZED: Modern, robust map for Nerd Fonts v3.0+ compliant code glyphs
    symbols = {
        filter = nil, -- Shows all elements. Restrict via string list if needed.
        icons = {
            File = {icon = "  ", hl = "Identifier"},
            Module = {icon = "", hl = "Include"},
            Namespace = {icon = "", hl = "Include"},
            Package = {icon = "", hl = "Include"},
            Class = {icon = "  ", hl = "Type"},
            Method = {icon = "", hl = "Function"},
            Property = {icon = "", hl = "Identifier"},
            Field = {icon = "", hl = "Identifier"},
            Constructor = {icon = "", hl = "Special"},
            Enum = {icon = "", hl = "Type"},
            Interface = {icon = "", hl = "Type"},
            Function = {icon = "  ", hl = "Function"},
            Variable = {icon = "", hl = "Identifier"},
            Constant = {icon = "  ", hl = "Constant"},
            String = {icon = "", hl = "String"},
            Number = {icon = "", hl = "Number"},
            Boolean = {icon = "", hl = "Boolean"},
            Array = {icon = "", hl = "Constant"},
            Object = {icon = "", hl = "Type"},
            Key = {icon = "", hl = "Type"},
            Null = {icon = "  ", hl = "Type"},
            EnumMember = {icon = "", hl = "Identifier"},
            Struct = {icon = "", hl = "Type"},
            Event = {icon = "", hl = "Type"},
            Operator = {icon = "", hl = "Operator"},
            TypeParameter = {icon = "", hl = "Identifier"}
        }
    }
})
