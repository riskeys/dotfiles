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

vim.keymap.set("n", "<Leader>jf", "ggVG:!jq .<CR>", { desc = 'Json: Format' })
vim.keymap.set("n", "<Leader>xb", "<cmd>ToggleTabBufferKeymap<CR>", { desc = 'Toggle Tab Buffer Keymap' })
vim.keymap.set("n", "<Leader>xi", "<cmd>e ~/dotfiles/i3/.config/i3/config<CR>", { desc = 'Open i3 config' })
vim.keymap.set("n", "<Leader>xn", "<cmd>e ~/dotfiles/nvim/.config/nvim/init.lua<CR>", { desc = 'Open i3 config' })

vim.keymap.set("n", "<BS>", ":bp<CR>", { noremap = true, desc = 'Buffer: previous' })
vim.keymap.set("n", "\\", ":bn<CR>", { noremap = true, desc = 'Buffer: next' })
vim.keymap.set("n", "<C-b><C-b>", ":ls<CR>", { noremap = true, desc = 'Buffer: list' })
vim.keymap.set("n", "<C-b><C-d>", ":bd<CR>", { noremap = true, desc = 'Buffer: delete' })

vim.keymap.set("n", "<Leader>cv", ":cd ~/dotfiles/nvim/.config/nvim<CR>", { noremap = true, desc = 'change dir: neovim' })
vim.keymap.set("n", "<Leader>cm", ":cd ~/Documents/repos/minilodon<CR>", { noremap = true, desc = 'change dir: minilo' })
vim.keymap.set("n", "<Leader>cd", ":cd ~/Documents/repos/dashify<CR>", { noremap = true, desc = 'change dir: dashify' })
vim.keymap.set("n", "<Leader>ci", ":cd ~/Documents/repos/inspira<CR>", { noremap = true, desc = 'change dir: inspira' })
vim.keymap.set("n", "<Leader>cx", ":cd ~/Documents/repos/xyz<CR>", { noremap = true, desc = 'change dir: xyz' })
vim.keymap.set("n", "<Leader>cei", ":e ~/dotfiles/i3/.config/i3/config<CR>",
    { noremap = true, desc = 'change dir: inspira' })

-- Session management
vim.keymap.set("n", "<Leader>soa", ":so session_1.vim<CR>", { noremap = true, desc = 'Session: open 1' })
vim.keymap.set("n", "<Leader>sob", ":so session_2.vim<CR>", { noremap = true, desc = 'Session: open 2' })
vim.keymap.set("n", "<Leader>soc", ":so session_3.vim<CR>", { noremap = true, desc = 'Session: open 3' })

vim.keymap.set("n", "<Leader>ssa", ":mksession! session_1.vim", { noremap = true, desc = 'Session: make 1' })
vim.keymap.set("n", "<Leader>ssb", ":mksession! session_2.vim", { noremap = true, desc = 'Session: make 2' })
vim.keymap.set("n", "<Leader>ssc", ":mksession! session_3.vim", { noremap = true, desc = 'Session: make 3' })

-- CopilotChat
vim.keymap.set("n", "cp", ":CopilotChatToggle<CR>", { noremap = true, desc = 'CopilotChat: Toggle' })
vim.keymap.set("n", "co", ":CopilotChatOpen<CR>", { noremap = true, desc = 'CopilotChat: Open' })
vim.keymap.set("n", "cm", ":CopilotChatLoad ", { noremap = true, desc = 'CopilotChat: Load' })
vim.keymap.set("n", "cx", ":CopilotChat", { noremap = true, desc = 'CopilotCha' })

-- window
vim.keymap.set("n", "<C-l>", "<C-w>>", { noremap = true, desc = 'Window: increase width' })
vim.keymap.set("n", "<C-l>", "<C-w>>", { noremap = true, desc = 'Window: increase width' })
vim.keymap.set("n", "<C-j>", "<C-w>+", { noremap = true, desc = 'Window: increase height' })
vim.keymap.set("n", "<C-k>", "<C-w>-", { noremap = true, desc = 'Window: decrease height' })


-- fzf
-- Key mappings for fzf.vim commands
vim.keymap.set('n', '<leader>ff', ':Files<CR>', { noremap = true, silent = true, desc = "Fzf Find Files" })
vim.keymap.set('n', '<leader>fg', ':GFiles<CR>', { noremap = true, silent = true, desc = "Fzf Git Files" })
vim.keymap.set('n', '<leader>fb', ':Buffers<CR>', { noremap = true, silent = true, desc = "Fzf Buffers" })
vim.keymap.set('n', '<leader>fh', ':Helptags<CR>', { noremap = true, silent = true, desc = "Fzf Help Tags" })
vim.keymap.set('n', '<leader>fl', ':Lines<CR>', { noremap = true, silent = true, desc = "Fzf Lines in File" })
vim.keymap.set('n', '<leader>fr', ':Rg<CR>', { noremap = true, silent = true, desc = "Fzf Ripgrep Search" })
vim.keymap.set('n', '<leader>fm', ':Marks<CR>', { noremap = true, silent = true, desc = "Fzf Marks" })
vim.keymap.set('n', '<leader>fc', ':Colors<CR>', { noremap = true, silent = true, desc = "Fzf Colors" })
vim.keymap.set("n", "<leader><leader>", ":Buffers<CR>", { desc = "[ ] Find existing buffers" })

-- oil
vim.keymap.set("n", "<Leader>op", "<CMD>Oil<CR>", { desc = "Oil: Open parent directory" })
vim.keymap.set("n", "<Leader>ot", require("oil").toggle_float, { desc = "Oil: Open toggle directory" })

