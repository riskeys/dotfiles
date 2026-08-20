vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "json", "go", "lua", "ts", "typescript", "zig" },
    callback = function()
        vim.opt_local.foldmethod = "syntax"
        vim.opt.foldenable = true
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local function go_to_next_file()
  -- Get current file path and its directory
	local root_dir = vim.fn.getcwd()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == "" then return end
  local current_dir = vim.fs.dirname(current_file)


  -- Scan all items in the directory and sort them alphabetically
  local files = vim.fn.readdir(current_dir)
  table.sort(files)

  -- Filter down to only files (skip directories)
  local valid_files = {}
  for _, file in ipairs(files) do
    local full_path = current_dir .. "/" .. file
    if vim.fn.isdirectory(full_path) == 0 then
      table.insert(valid_files, full_path)
    end
  end

  -- Find the current file index and open the next one
  for i, file_path in ipairs(valid_files) do
    if file_path == current_file then
      local next_file = valid_files[i + 1] or valid_files[1] -- Loops back to start
			local next_file_relative = vim.fs.relpath(root_dir, next_file)
			if next_file_relative then
				vim.cmd("edit " .. vim.fn.fnameescape(next_file_relative))
			end
      return
    end
  end
end

-- Keymap to trigger with Leader + fn
vim.keymap.set("n", ",nn", go_to_next_file, { desc = "Go to next relative file" })


local zig_win = nil
local zig_buf = nil

vim.keymap.set("n", ",zx", function()
	if zig_win ~= nil and vim.api.nvim_win_is_valid(zig_win) then
		vim.api.nvim_win_close(zig_win, true)
	end
end, { silent = true, desc = "Close zig exercise test" })

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "**/exercises/*.zig",
	group = vim.api.nvim_create_augroup("ZigExerciseAutoRunGroup", { clear = true }),
	callback = function()
		if zig_buf == nil then
			zig_buf = vim.api.nvim_create_buf(false, true)
		end

		vim.api.nvim_buf_set_lines(zig_buf, 0, -1, false, { "Running Zig exercise file..." })
		local current_file_name = vim.fn.expand("%:p")
		vim.fn.jobstart({ "zig", "run", current_file_name }, {
			stdout_buffered = true,
			stderr_buffered = true,
			on_stdout = function(_, data, _)
				vim.api.nvim_buf_set_lines(zig_buf, -1, -1, false, { "Std output from Zig run:" })
				if data then
					vim.api.nvim_buf_set_lines(zig_buf, -1, -1, false, data)
				end
			end,
			on_stderr = function(_, data, _)
				vim.api.nvim_buf_set_lines(zig_buf, -1, -1, false, { "Error output from Zig run:" })
				if data then
					vim.api.nvim_buf_set_lines(zig_buf, -1, -1, false, data)
				end
			end,
			on_exit = function(_, code, _)
				if code ~= 0 then
					vim.api.nvim_buf_set_lines(zig_buf, -1, -1, false, { "Zig run failed with exit code: " .. code })
				end
			end,
		})


		if zig_win == nil or vim.api.nvim_win_is_valid(zig_win) == false then
			-- vim.api.nvim_win_set_buf(zig_win, zig_buf)
			zig_win = vim.api.nvim_open_win(zig_buf, true, {
				win = 0,
				vertical = false,
				height = 10,
				split = "below",
				style = "minimal",
			})
		end
	end,
})


local test_runner = require("dev")
vim.keymap.set("n", ",tt", test_runner.unit_test_cur_file, { silent = true, desc = "battletest: run unit test" })
vim.keymap.set("n", ",tx", test_runner.close_win, { silent = true, desc = "battletest: close win" })
vim.keymap.set("n", ",to", test_runner.open_win, { silent = true, desc = "battletest: open win" })

