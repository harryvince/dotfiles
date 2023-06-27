vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

--vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

-- Disable the line as we now have a nice line
vim.cmd "set noshowmode"

-- Custom tabbing etc..
vim.cmd "autocmd Filetype html setlocal ts=2 sw=2"
vim.cmd "autocmd Filetype typescript setlocal ts=2 sw=2"
vim.cmd "autocmd Filetype javascript setlocal ts=2 sw=2"
