return {
	cmd = { 'lua-language-server' },
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	},
	workspace = {
		checkThirdParty = false,
		library = {
			vim.env.VIMRUNTIME,
		},
	},
	telemetry = { enable = false },
}
