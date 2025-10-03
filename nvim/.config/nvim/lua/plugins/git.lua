return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gf", ":G<CR>", { desc = "Open fugitive?" })
	end,
}
