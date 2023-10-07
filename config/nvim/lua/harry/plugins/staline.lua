return {
    'tamton-aquib/staline.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
    config = function()
        local no_unicode_modes = {
            n = "N",
            i = "I",
            c = "C",
            v = "v",
            V = "V"
        }

        local lsp_symbols = {
            Error = " ",
            Info = " ",
            Warn = " ",
            Hint = " "
        }

        require "staline".setup({
            mode_icons = no_unicode_modes,
            lsp_symbols = lsp_symbols,

            sections = {
                left = { '  ', 'mode', ' ', 'branch', ' ', 'git_diff' },
                mid = { 'lsp' },
                right = { 'file_name', 'line_column' }
            },
            mode_colors = {
                i = "#d4be98",
                n = "#e6e6fa",
                c = "#8fbf7f",
                v = "#fc802d",
            },
            defaults = {
                true_colors = true,
                line_column = " [%l/%L] :%c  ",
                branch_symbol = " ",
                mod_symbol = " "
            }
        })
    end
}
