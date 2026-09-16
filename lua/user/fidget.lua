local status_ok, fidget = pcall(require, "fidget")
if not status_ok then return end

fidget.setup {
    -- Options related to the LSP progress notification subsystem
    progress = {
        display = {
            -- UPDATED: Modern way to define the spinner style animation
            progress_icon = "moon",

            -- UPDATED: Modern functional overrides for text lifecycle markers
            done_style = "Constant", -- Highlight group for finished tasks
            icon_style = "Question", -- Highlight group for progress icons

            -- Customize the final completion message formatting text
            format_message = function(msg)
                if msg.done then return "👌 Completed" end
                return msg.message or "Running..."
            end
        }
    },

    -- Configures Fidget as the active backend for standard vim.notify announcements
    notification = {
        window = {
            winblend = 0 -- Keeps the notification window completely transparent
        }
    }
}
