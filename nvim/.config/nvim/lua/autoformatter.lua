require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
		go = { "gofmt" },
		zig = { "zig_fmt" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = { "deno_fmt" },
    typescript = { "deno_fmt" },
    typescriptreact = { "deno_fmt" },
  },
	formatters = {
		zig_fmt = {
			command = "zig",
			args = { "fmt", "$FILENAME" },
			stdin = false,
		},
	}
})


