return {
    -- Core definitions for the native Neovim v0.11 registration engine
    cmd = {"lua-language-server"},
    filetypes = {"lua"},
    root_markers = {".luarc.json", ".luarc.jsonc", ".git"},

    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT" -- Explicitly specifies Neovim's compiler target
            },
            diagnostics = {
                -- Safely whitelist the core global vim indicator variable
                globals = {"vim"}
            },
            workspace = {
                -- OPTIMIZED: Native core workspace layout mapping
                checkThirdParty = false,
                library = {
                    -- Only keep the baseline runtime layout definitions here.
                    -- Plugins-scoped environment paths are handled dynamically by lazydev.nvim!
                    vim.env.VIMRUNTIME
                }
            },
            telemetry = {
                enable = false -- Disables background analytics pings for snappy boots
            }
        }
    }
}
