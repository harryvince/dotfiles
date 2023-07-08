return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' }, { 'kdheepak/lazygit.nvim' } },
    config = function()
        require('telescope').load_extension('lazygit')
        require('telescope').load_extension('notify')
        require('telescope').setup({
            pickers = {
                find_files = {
                    disable_devicons = true
                }
            }
        })
        local builtin = require('telescope.builtin')
        -- File finding 
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>bf', builtin.buffers, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
        -- LSP Helpers
        vim.keymap.set('n', '<leader>se', builtin.diagnostics, {})
    end,
}
