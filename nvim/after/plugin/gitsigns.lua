require('gitsigns').setup()

-- Make the background of gitsigns transparent
vim.cmd('highlight GitSignsAdd guibg=NONE')
vim.cmd('highlight GitSignsChange guibg=NONE')
vim.cmd('highlight GitSignsDelete guibg=NONE')
