require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = { "deno_fmt" },
    typescript = { "deno_fmt" },
  },
})


