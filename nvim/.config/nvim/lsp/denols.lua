return {
	cmd = { "deno", "lsp" },
	filetypes = { "vue", "json", "typescript", "javascript", "typescriptreact", "javascriptreact" },
	root_markers = { "deno.json", "deno.jsonc" },
	settings = {
		deno = {
			enable = true,
			unstable = true,
			suggest = {
				imports = {
					hosts = {
						["https://deno.land"] = true
					}
				}
			}
		},
		typescript = {
			referencesCodeLens = {
				enabled = true, -- optional but helps navigation
			},
		},
		javascript = {
			referencesCodeLens = {
				enabled = true,
			},
		},
	},
}

