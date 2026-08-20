vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.zig",
	group = vim.api.nvim_create_augroup("ZigFormat", { clear = true }),
	callback = function()
		print("Formatting Zig file before saving...")
		-- vim.lsp.buf.format({ async = false })
	end,
})
