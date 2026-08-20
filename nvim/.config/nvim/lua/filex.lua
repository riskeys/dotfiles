-- oil
require('oil').setup({
	view_options = {
		show_hidden = true,
	},
})

require('nvim-tree').setup()

vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons"
})
require("nvim-web-devicons").setup()

