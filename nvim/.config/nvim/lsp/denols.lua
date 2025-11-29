return {
	cmd = { "deno", "lsp" },
	filetypes = { "vue", "json", "typescript", "javascript", "typescriptreact", "javascriptreact" },
	root_markers = { "deno.json", "deno.jsonc" },
	root_dir = function(bufnr, on_dir)
		-- local cwd = vim.fn.getcwd(0)
		-- local parent = vim.fn.fnamemodify(cwd, ":h")
		-- local dirs = vim.fs.find(
		-- 	{ "deno.json", "deno.jsonc" },
		-- 	-- { limit = 1, upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) }
		-- 	{ upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)), stop = parent }
		-- )
		-- for _, dir in ipairs(dirs) do
		-- 	if dir then
		-- 		on_dir(dir)
		-- 		break
		-- 	end
		-- end
		--
		local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
		local found = vim.fs.find(
			{ "deno.json", "deno.jsonc" },
			{ upward = true, path = dir, limit = 1 }
		)[1]
		if found then
			on_dir(vim.fs.dirname(found))
		end
	end,
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
