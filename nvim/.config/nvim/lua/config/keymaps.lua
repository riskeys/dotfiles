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
vim.keymap.set("n", "<Leader>xi", "<cmd>e ~/dotfiles/i3/.config/i3/config<CR>", { desc = 'Open i3 config' })
vim.keymap.set("n", "<Leader>xn", "<cmd>e ~/dotfiles/nvim/.config/nvim/init.lua<CR>", { desc = 'Open i3 config' })

vim.keymap.set("n", "<BS>", ":bp<CR>", { noremap = true, desc = 'Buffer: previous' })
vim.keymap.set("n", "\\", ":bn<CR>", { noremap = true, desc = 'Buffer: next' })
vim.keymap.set("n", "<C-b><C-b>", ":ls<CR>", { noremap = true, desc = 'Buffer: list' })
vim.keymap.set("n", "<C-b><C-d>", ":bd<CR>", { noremap = true, desc = 'Buffer: delete' })
