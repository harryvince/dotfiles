return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup({
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true })

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true })

                -- Actions
                map('n', '<leader>tb', gs.toggle_current_line_blame)
                map('n', '<leader>hd', gs.diffthis)
                map('n', '<leader>td', gs.toggle_deleted)
            end
        })

        -- Make the background of gitsigns transparent
        vim.cmd('highlight GitSignsAdd guibg=NONE')
        vim.cmd('highlight GitSignsChange guibg=NONE')
        vim.cmd('highlight GitSignsDelete guibg=NONE')
    end
}
