local status_ok, smoothcursor = pcall(require, "smoothcursor")
if not status_ok then
    return
end

smoothcursor.setup({
    autostart = true,
    cursor = "", -- Modernized cursor indicator (requires Nerd Font)
    texthl = "SmoothCursor", -- Target tracking style layer
    linehl = nil, -- Set to "CursorLine" if you want full line following
    type = "default", -- Movement animation style: "default", "exp", or "matrix"

    fancy = {
        enable = false, -- Set to true if you prefer the trailing multi-segment tail
        head = {
            cursor = "▷",
            texthl = "SmoothCursor",
            linehl = nil
        },

        -- UPDATED: Replaced legacy v2 icons with modern v3.0+ compliant dot characters (  )
        body = {{
            cursor = "  ",
            texthl = "SmoothCursorRed"
        }, {
            cursor = "  ",
            texthl = "SmoothCursorOrange"
        }, {
            cursor = "●",
            texthl = "SmoothCursorYellow"
        }, {
            cursor = "●",
            texthl = "SmoothCursorGreen"
        }, {
            cursor = "•",
            texthl = "SmoothCursorAqua"
        }, {
            cursor = ".",
            texthl = "SmoothCursorBlue"
        }, {
            cursor = ".",
            texthl = "SmoothCursorPurple"
        }},
        tail = {
            cursor = nil,
            texthl = "SmoothCursor"
        }
    },

    flyin_effect = nil, -- "bottom" or "top"
    speed = 25, -- Animation speed index
    intervals = 35, -- Refresh update rates in ms
    priority = 10, -- Gutter priority layers
    timeout = 3000, -- Timeout to halt active animations
    threshold = 3, -- Animate only if jumps span past 3 lines
    disable_float_win = false, -- Skips rendering markers inside floating menus
    enabled_filetypes = nil, -- Active context restriction list
    disabled_filetypes = nil -- Skips rendering inside NvimTree, Telescope prompts, etc.
})
