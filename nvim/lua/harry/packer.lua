-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' }, { 'kdheepak/lazygit.nvim' } },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    })

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {
        'olivercederborg/poimandres.nvim',
        config = function()
            require('poimandres').setup {
                dim_nc_background = true,
                disable_background = true,
                disable_float_background = false,
            }
        end
    }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('voldikss/vim-floaterm')
    use('lewis6991/gitsigns.nvim')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },          -- Required
            { 'hrsh7th/cmp-nvim-lsp' },      -- Required
            { 'hrsh7th/cmp-buffer' },        -- Optional
            { 'hrsh7th/cmp-path' },          -- Optional
            { 'saadparwaiz1/cmp_luasnip' },  -- Optional
            { 'hrsh7th/cmp-nvim-lua' },      -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional

            -- Rust
            { 'simrat39/rust-tools.nvim' }
        }
    }
end)
