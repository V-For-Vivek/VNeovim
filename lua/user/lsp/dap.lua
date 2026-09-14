local status_ok_dapui, dapui = pcall(require, "dapui")
local status_ok_dap, dap = pcall(require, "dap")
if not status_ok_dap or not status_ok_dapui then
    return
end

-- Initialize the Mason DAP bridge helper safely
local status_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
if status_mason_dap then
    mason_dap.setup({
        automatic_setup = true,
        handlers = {}
    })
end

-- ==========================================
-- Debugger Execution Keymaps
-- ==========================================
local keymap = vim.keymap.set

keymap('n', '<F5>', dap.continue, {
    desc = "DAP: Continue"
})
keymap('n', '<F1>', dap.step_into, {
    desc = "DAP: Step Into"
})
keymap('n', '<F2>', dap.step_over, {
    desc = "DAP: Step Over"
})
keymap('n', '<F3>', dap.step_out, {
    desc = "DAP: Step Out"
})
keymap('n', '<leader>b', dap.toggle_breakpoint, {
    desc = "DAP: Toggle Breakpoint"
})
keymap('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, {
    desc = "DAP: Conditional Breakpoint"
})

-- ==========================================
-- Modernized DAP UI Configuration Block
-- ==========================================
dapui.setup({
    -- Control panel glyph overrides
    controls = {
        enabled = true,
        element = "repl",
        icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹'
        }
    },
    -- Floating frame layout configurations
    floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded", -- Matches your WhichKey and Telescope styling
        mappings = {
            close = {"q", "<Esc>"}
        }
    }
})

-- ==========================================
-- Modern Automated Window Hook Triggers
-- ==========================================
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
