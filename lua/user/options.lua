local options = {
    backup = false,
    clipboard = "unnamedplus",
    cmdheight = 1,
    completeopt = {"menuone", "noselect"},
    conceallevel = 0,
    fileencoding = "utf-8",
    hlsearch = true,
    ignorecase = true,
    mouse = "a",
    pumheight = 10,
    showmode = false,
    showtabline = 2,
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    termguicolors = true,
    timeoutlen = 1000,
    undofile = true,
    updatetime = 300,
    writebackup = false,
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
    cursorline = true,
    number = true,
    relativenumber = false,
    numberwidth = 4,
    signcolumn = "yes",
    wrap = true,
    linebreak = true,
    scrolloff = 8,
    sidescrolloff = 8,
    guifont = "FiraCode Nerd Font:h13",
    backspace = {"indent", "eol", "start"}
}

vim.g.loaded_perl_provider = 0

for k, v in pairs(options) do vim.opt[k] = v end

vim.opt.shortmess:append("c")
vim.opt.iskeyword:append("-")
vim.opt.formatoptions:remove({"c", "r", "o"})
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

local lazydev_ok, lazydev = pcall(require, "lazydev")
if lazydev_ok then
    lazydev.setup({
        library = {{path = "luvit-meta/library", words = {"vim%.uv"}}}
    })
end

if vim.fn.has("win32") == 1 then
    local powershell_options = {
        shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = ""
    }

    for option, value in pairs(powershell_options) do vim.opt[option] = value end
end
