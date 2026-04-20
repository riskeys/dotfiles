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
	"https://github.com/nvim-mini/mini.completion",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-mini/mini.snippets",
	"https://github.com/neovim-treesitter/nvim-treesitter",
	"https://github.com/neovim-treesitter/treesitter-parser-registry",
	"https://github.com/tpope/vim-dadbod",
	"https://github.com/kristijanhusak/vim-dadbod-ui",
	"https://github.com/kristijanhusak/vim-dadbod-completion",
	"https://github.com/mistweaverco/kulala.nvim",
	'https://github.com/folke/which-key.nvim',
	"https://github.com/karb94/neoscroll.nvim",
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
