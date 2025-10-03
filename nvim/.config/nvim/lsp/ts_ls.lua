return {
	filetypes = { "vue", "json", "typescript", "javascript", "typescriptreact", "javascriptreact" },
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
	root_markers = { "package.json", "tsconfig.json" }
}
