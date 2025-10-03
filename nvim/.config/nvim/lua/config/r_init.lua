vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 10

-- tabstop
vim.o.tabstop = 2
-- vim.o.softtabstop=4
vim.o.shiftwidth = 2
-- vim.opt.foldmethod = "indent"
-- vim.opt_local.foldmethod = "indent"
-- vim.opt.foldenable = true

-- keymap
-- for specific configuration of certain file types, check <filetype>.lua file in /after/ftplugin/ directory.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- auto command
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "json", "go", "lua", "ts" },
	callback = function()
		vim.opt_local.foldmethod = "syntax"
		vim.opt.foldenable = true
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "js", "ts", "typescript", "deno" },
	callback = function()
		vim.opt_local.foldmethod = "indent"
		vim.opt.foldenable = true
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function()
		vim.opt_local.foldmethod = "indent"
		vim.opt_local.foldenable = true
	end,
})

-- require("config.appearance")
require("config.terminal")
