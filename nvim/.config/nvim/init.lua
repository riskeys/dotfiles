require("options")

vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/OXY2DEV/markview.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-mini/mini.snippets",
	"https://github.com/neovim-treesitter/nvim-treesitter",
	"https://github.com/neovim-treesitter/treesitter-parser-registry",
	"https://github.com/tpope/vim-dadbod",
	"https://github.com/kristijanhusak/vim-dadbod-ui",
	"https://github.com/kristijanhusak/vim-dadbod-completion",
	"https://github.com/mistweaverco/kulala.nvim",
	'https://github.com/folke/which-key.nvim',
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/selimacerbas/live-server.nvim",
	"https://github.com/selimacerbas/markdown-preview.nvim",
	"https://github.com/seblyng/roslyn.nvim",
	{ src = "git@cb-r32:ziglang/zig.vim.git" },
})

-- vim.pack.delete("https://github.com/iamcco/markdown-preview.nvim")

vim.filetype.add({
	extension = {
		cshtml = "razor",
	}
})


require("git")
require("db")
require("ai")
require("lsp")
require("finder")
require("restclient")
require("treesitter")
require("autoformatter")
require("colorscheme")
require("filex")
require("keymap")
require("autocommands")


