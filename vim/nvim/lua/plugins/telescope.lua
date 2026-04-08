return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<C-h>', builtin.help_tags, { desc = 'Telescope help tags' })
    end,
}
