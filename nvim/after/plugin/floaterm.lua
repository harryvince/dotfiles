local options = { noremap = true }

local dir = vim.fn.expand('ls %:p:h')

vim.keymap.set('n', '<leader>tt', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 zsh<CR>', options)
vim.keymap.set('n', '<leader>ti', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 ~/bin/scripts/cht.sh<CR>', options)
