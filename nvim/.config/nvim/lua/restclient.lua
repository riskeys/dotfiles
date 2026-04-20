-- kulala
require("kulala").setup()
vim.keymap.set("n", "<leader>rr", "<cmd>lua require('kulala').run()<cr>", { desc = "Run Request" })

