local M = {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			keymaps = {
				["<C-h>"] = false,
				["<M-h>"] = "action.select_split",
			},
			view_options = {
				show_hidden = true,
			},
		})

		vim.keymap.set("n", "<Leader>op", "<CMD>Oil<CR>", { desc = "Oil: Open parent directory" })
		vim.keymap.set("n", "<Leader>ot", require("oil").toggle_float, { desc = "Oil: Open toggle directory" })
	end,
}

return M
