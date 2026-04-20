return {
    "junegunn/fzf.vim",
    config = function()
        -- You can set various options for fzf.vim here
        -- vim.g.fzf_layout = { right = '40%' } -- Example: set layout to use bottom 40% of the screen

        vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
        vim.g.fzf_command_prefix = 'Fzf' -- Example: set command prefix to avoid conflicts

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
        vim.api.nvim_set_keymap('n', '<leader>fc', ':Colors<CR>',
            { noremap = true, silent = true, desc = "Fzf Colors" })
        vim.keymap.set("n", "<leader><leader>", ":Buffers<CR>", { desc = "[ ] Find existing buffers" })

        vim.cmd([[
            let $FZF_DEFAULT_OPTS = '--bind ctrl-j:preview-down,ctrl-k:preview-up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up'
            " Use fzf for command history
            command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'options': [
            \ '--info=inline',
            \ '--preview', 'batcat --style=numbers --line-range=:500 {}']},
            \ <bang>0)
        ]])
    end,
}
