return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' }, { 'kdheepak/lazygit.nvim' } },
    config = function()
        require('telescope').load_extension('lazygit')
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
    end,
}