vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = 'Open [E]xplorer' })

vim.keymap.set("n", "<leader>xp", "yy2o<ESC>kpV:!/bin/bash<CR>")
vim.keymap.set("v", "<leader>xl", "y'<P'<O<ESC>'>o<ESC>:<C-u>'<,'>!/bin/bash<CR>")

vim.keymap.set("n", "<Leader>fj", "ggVG:!jq .<CR>", { desc = 'Formatting Json' })
vim.keymap.set("n", "<Leader>xb", "<cmd>ToggleTabBufferKeymap<CR>", { desc = 'Toggle Tab Buffer Keymap' })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript" },
    callback = function()
        vim.keymap.set("i", ",tlinf", "this.logger.info(``);<Esc>F`i",
            { noremap = true, buffer = true, desc = '(this) Logger: info' })
        vim.keymap.set("i", ",tldbg", "this.logger.debug(``);<Esc>F`i",
            { noremap = true, buffer = true, desc = '(this) Logger: debug' })
        vim.keymap.set("i", ",tlerr", "this.logger.error(``);<Esc>F`i",
            { noremap = true, buffer = true, desc = '(this) Logger: error' })
        vim.keymap.set("i", ",tlwrn", "this.logger.warn(``);<Esc>F`i",
            { noremap = true, buffer = true, desc = '(this) Logger: warning' })
    end,
})
