local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    return
end

-- Check if the context context_commentstring plugin is available safely
local ts_context_ok, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")

comment.setup {
    -- UPDATED: Replaced manual logic blocks with the official native integration helper
    pre_hook = ts_context_ok and ts_context.create_pre_hook() or nil
}
