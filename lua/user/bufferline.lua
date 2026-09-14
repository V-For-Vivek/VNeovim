local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then return end

-- 1. Correctly scoped diagnostic indicators function
local diagnostics_indicator = function(count, level, diagnostics_dict, context)
    local s = " "
    for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or
                        (e == "warning" and " " or "")
        s = s .. n .. sym
    end
    return s
end

bufferline.setup {
    options = {
        numbers = "none",
        close_command = "Bdelete! %d",
        right_mouse_command = "Bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,

        indicator = {style = "icon", icon = "▎"},
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 21,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = diagnostics_indicator,

        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true
            }
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thick",
        enforce_regular_tabs = true,
        always_show_bufferline = true
    },

    -- FIXED: Used the exact syntax expected by bufferline's custom highlight parser
    highlights = {
        fill = {fg = "#ff0000", bg = {attribute = "bg", highlight = "TabLine"}},
        background = {
            fg = {attribute = "fg", highlight = "TabLine"},
            bg = {attribute = "bg", highlight = "TabLine"}
        },
        buffer_visible = {
            fg = {attribute = "fg", highlight = "TabLine"},
            bg = {attribute = "bg", highlight = "TabLine"}
        },
        close_button = {
            fg = {attribute = "fg", highlight = "TabLine"},
            bg = {attribute = "bg", highlight = "TabLine"}
        },
        close_button_visible = {
            fg = {attribute = "fg", highlight = "TabLine"},
            bg = {attribute = "bg", highlight = "TabLine"}
        },
        tab_selected = {
            fg = {attribute = "fg", highlight = "Normal"},
            bg = {attribute = "bg", highlight = "Normal"}
        },
        tab = {
            fg = {attribute = "fg", highlight = "TabLine"},
            bg = {attribute = "bg", highlight = "TabLine"}
        },
        tab_close = {
            fg = {attribute = "fg", highlight = "TabLineSel"},
            bg = {attribute = "bg", highlight = "Normal"}
        },
        duplicate_selected = {
            fg = {attribute = "fg", highlight = "TabLineSel"},
            bg = {attribute = "bg", highlight = "TabLineSel"},
            underline = true
        },
        duplicate_visible = {
            fg = {attribute = "fg", highlight = "TabLine"},
            bg = {attribute = "bg", highlight = "TabLine"},
            underline = true
        },
        duplicate = {
            fg = {attribute = "fg", highlight = "TabLine"},
            bg = {attribute = "bg", highlight = "TabLine"},
            underline = true
        },
        modified = {
            fg = {attribute = "fg", highlight = "TabLine"},
            bg = {attribute = "bg", highlight = "TabLine"}
        },
        modified_selected = {
            fg = {attribute = "fg", highlight = "Normal"},
            bg = {attribute = "bg", highlight = "Normal"}
        },
        modified_visible = {
            fg = {attribute = "fg", highlight = "TabLine"},
            bg = {attribute = "bg", highlight = "TabLine"}
        },
        separator = {
            fg = {attribute = "bg", highlight = "TabLine"},
            bg = {attribute = "bg", highlight = "TabLine"}
        },
        separator_selected = {
            fg = {attribute = "bg", highlight = "Normal"},
            bg = {attribute = "bg", highlight = "Normal"}
        },
        indicator_selected = {
            fg = {attribute = "fg", highlight = "DiagnosticHint"},
            bg = {attribute = "bg", highlight = "Normal"}
        }
    }
}
