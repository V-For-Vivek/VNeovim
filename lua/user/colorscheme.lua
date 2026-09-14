-- 1. Safely load the plugin to prevent boot crashes if it is missing
local status_ok, onedark = pcall(require, "onedark")
if not status_ok then return end

-- 2. Configure your theme preferences
onedark.setup({
    style = 'darker',
    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'bold',
        strings = 'none',
        variables = 'none'
    },
    transparent = true,
    lualine = {
        transparent = true -- keeps lualine center bar blended perfectly
    }
})

-- 3. UPDATED: Load the colorscheme via the modern native Lua function
local colorscheme = "onedark"
local load_ok = pcall(vim.cmd.colorscheme, colorscheme)
if not load_ok then
    vim.notify("Colorscheme " .. colorscheme .. " not found!")
    return
end
