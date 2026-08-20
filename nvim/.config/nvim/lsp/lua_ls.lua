local root_markers1 = {
  '.emmyrc.json',
  '.luarc.json',
  '.luarc.jsonc',
}
local root_markers2 = {
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
}

return {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers1, root_markers2, { '.git' } }
	or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { '.git' }),
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			},
			runtime = {
				version = 'LuaJIT',
			},
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
				},
			},
			codeLens = { enable = true },
			hint = { enable = true, semicolon = 'Disable' },
		},
	telemetry = { enable = false },
	},
}
