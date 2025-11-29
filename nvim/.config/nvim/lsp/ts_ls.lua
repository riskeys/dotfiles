return {
	cmd = {
		"typescript-language-server",
		"--stdio"
	},
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
	-- root_markers = { "package.json", "tsconfig.json" },
	root_dir = function(bufnr, on_dir)
		-- vim.notify(bufnr)
		local cwd = vim.fn.getcwd(0)
		local parent = vim.fn.fnamemodify(cwd, ":h")
		local dirs = vim.fs.find(
			{ "package.json" },
			{ upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)), stop = parent }
		)
		for _, dir in ipairs(dirs) do
			if dir then
				vim.notify(dir)
				on_dir(dir)
				break
			end
		end
	end,
}
