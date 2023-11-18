return {
    "harryvince/aws-sdk.nvim",
    dependencies = {
        { 'nvim-telescope/telescope.nvim' },
        { 'nvim-lua/plenary.nvim' }
    },
    name = "aws-sdk",
    dev = false,
    event = 'VeryLazy',
    config = function ()
        local aws = require('aws-sdk')

        vim.keymap.set('n', '<leader>aws', aws.find_command)
    end
}
