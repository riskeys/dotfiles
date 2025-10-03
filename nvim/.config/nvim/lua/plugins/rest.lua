return {
	"rest-nvim/rest.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
		end,
	},
	config = function()
		---@type rest.Opts
		vim.g.rest_nvim = {
			---@class rest.Config.Response
			response = {
				---Default response hooks
				---@class rest.Config.Response.Hooks
				hooks = {
					---@type boolean Decode the request URL segments on response UI to improve readability
					decode_url = true,
					---@type boolean Format the response body using `gq` command
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
						return vim.fn.system("%!jq", body)
					end,
				},
				formatters = function(body)
					print("Formatting with jq")
					return vim.fn.system("%!jq", body)
				end,
			},
		}

		vim.keymap.set("n", "<Leader>rr", "<cmd>Rest run<CR>", { desc = "Rest: run" })
	end
}
