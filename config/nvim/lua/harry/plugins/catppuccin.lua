return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato",     -- latte, frappe, macchiato, mocha
            transparent_background = true,
            show_end_of_buffer = false,
            term_colors = true,
            integrations = {
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                harpoon = true,
                mason = true,
                treesitter_context = true,
                treesitter = true,
            },
        })

        -- setup must be called before loading
        vim.cmd.colorscheme "catppuccin"
        vim.cmd "highlight LineNr guifg=#E9EC6B"
    end
}
