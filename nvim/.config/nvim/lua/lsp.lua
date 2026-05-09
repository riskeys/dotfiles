vim.lsp.enable('lua_ls')
vim.lsp.enable('denols')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map('n', 'K', vim.lsp.buf.hover, 'LSP Hover')
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('n', 'gI', vim.lsp.buf.implementation, 'Go to implementation')
    map('n', 'gr', vim.lsp.buf.references, 'References')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('n', '<leader>gf', function()
      vim.lsp.buf.format({ async = true })
    end, 'Format buffer')
  end,
})


-- intellisense
-- require('mini.completion').setup()
local cmp = require('blink.cmp')
-- cmp.build():wait(60000)
cmp.setup({
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			-- cmdline = { min_keyword_length = 2, },
			cmdline = {},
		},
	},
	cmdline = {
		enabled = false,
		completion = { menu = { auto_show = true } },
		-- keymap = { },
	},
	keymap = {
		preset = 'default',
		['<C-n>'] = { 'select_next', 'fallback' },
		['<C-p>'] = { 'select_prev', 'fallback' },
	},
	fuzzy = { implementation = "lua" }
})
