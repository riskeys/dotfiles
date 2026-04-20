vim.api.nvim_create_user_command('DenoUnitTestCurrentFile', function()
	local filename = vim.api.nvim_buf_get_name(0)
	if filename == '' then
		print('No file name')
		return
	end
	print(filename)
	local cmd = 'deno test --no-check --allow-net --allow-env=INT_TEST_*,UNIT_TEST_* --env ' .. filename
	vim.cmd('split | terminal ' .. cmd)
end, {})

vim.keymap.set('n', '<leader>dtc', ':DenoUnitTestCurrentFile<CR>',
	{ noremap = true, silent = true, desc = 'Run Deno Unit Test for Current File' })
vim.keymap.set('n', '<leader>dtd', ':ToggleTerm<CR>deno task dev_v2',
	{ noremap = true, silent = true, desc = 'Run Deno' })
