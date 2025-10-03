return {
    "junegunn/fzf.vim",
    config = function()
        -- You can set various options for fzf.vim here
        vim.g.fzf_layout = { down = '40%' } -- Example: set layout to use bottom 40% of the screen
        vim.g.fzf_command_prefix = 'Fzf'    -- Example: set command prefix to avoid conflicts

        -- Key mappings for fzf.vim commands
        vim.api.nvim_set_keymap('n', '<leader>ff', ':Files<CR>',
            { noremap = true, silent = true, desc = "Fzf Find Files" })
        vim.api.nvim_set_keymap('n', '<leader>fg', ':GFiles<CR>',
            { noremap = true, silent = true, desc = "Fzf Git Files" })
        vim.api.nvim_set_keymap('n', '<leader>fb', ':Buffers<CR>',
            { noremap = true, silent = true, desc = "Fzf Buffers" })
        vim.api.nvim_set_keymap('n', '<leader>fh', ':Helptags<CR>',
            { noremap = true, silent = true, desc = "Fzf Help Tags" })
        vim.api.nvim_set_keymap('n', '<leader>fl', ':Lines<CR>',
            { noremap = true, silent = true, desc = "Fzf Lines in File" })
        vim.api.nvim_set_keymap('n', '<leader>fr', ':Rg<CR>',
            { noremap = true, silent = true, desc = "Fzf Ripgrep Search" })
        vim.api.nvim_set_keymap('n', '<leader>fm', ':Marks<CR>',
            { noremap = true, silent = true, desc = "Fzf Marks" })
    end,
}
