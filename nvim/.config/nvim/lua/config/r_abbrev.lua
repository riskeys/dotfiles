local abbrevs = {
	"btw by the way",
}

local state = false

local function str_split(str, sep)
	if sep == nil then
		sep = '%s'
	end

	local res = {}
	local func = function(w)
		table.insert(res, w)
	end

	string.gsub(str, '[^' .. sep .. ']+', func)
	return res
end

local toggle = function()
	state = not state
	if state then
		for _, value in ipairs(abbrevs) do
			local cmd = "noreabbrev " .. value
			vim.cmd(cmd)
		end
		print("Toggle abbrev: ON")
	else
		for _, value in ipairs(abbrevs) do
			local abbrev = str_split(value, " ")[1]
			local cmd = "unabbrev " .. abbrev
			-- print(cmd)
			vim.cmd(cmd)
		end
		print("Toggle abbrev: OFF")
	end
end

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("TestAbbrev", toggle, {})

vim.keymap.set({ "n" }, "<Leader>ta", "<cmd>TestAbbrev<CR>", { desc = "Test Toggle Abbreviation" })
