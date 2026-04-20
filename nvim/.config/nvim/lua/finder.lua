local fzf_lua = require("fzf-lua")
fzf_lua.setup({"fzf-vim"})
fzf_lua.setup({
	keymap = {
		builtin = {
			["<C-j>"] = "preview-down",
			["<C-k>"] = "preview-up",
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
		}
	},
	winopts = {
		-- fullscreen = true,
		preview = {
			horizontal = "down:80%",
			hidden = false,
		},
	},
})
fzf_lua.register_ui_select()

