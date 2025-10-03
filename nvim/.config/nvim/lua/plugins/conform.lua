return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters = {
				kulala = {
					command = "kulala-fmt",
					args = { "format", "$FILENAME" },
					stdin = false,
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "golines", "gofmt" },
				http = { "kulala" }
				-- javascript = { "deno" },
				-- typescript = { "denols" },
			},
			format_on_save = {
				lsp_format = "prefer",
				timeout_ms = 500
			},
			-- format_after_save = {
			-- 	lsp_format = "fallback",
			-- },
			-- format_on_save = {
			--     lsp_fallback = true,
			--     async = false,
			-- },
		})
	end,
}
