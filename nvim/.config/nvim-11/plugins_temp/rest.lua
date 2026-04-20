return {
	"rest-nvim/rest.nvim",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
		{ "nvim-neotest/nvim-nio", opts = {}, config = function() end },
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
		end,
	},
	config = function()
		require("rest-nvim").setup({
			response = {
				hooks = {
					format = true,
				},
			},
			result = {
				show_url = false,
				split = {
					horizontal = false,
					in_place = false,
					stay = false,
				},
				behavior = {
					formatters = function(body)
						print("Formatting with jq")
						return vim.fn.system("jq", body)
					end,
				},
				-- formatters = function(body)
				-- 	print("Formatting with jq")
				-- 	return vim.fn.system("jq", body)
				-- end,
			},
		})
	end,
}
--
--
-- return {}
