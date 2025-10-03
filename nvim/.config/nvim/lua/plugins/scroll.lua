return {
	"karb94/neoscroll.nvim",
	opts = {},
	config = function()
		local scroll = require("neoscroll")
		scroll.setup({
			duration_multiplier = 0.7,
			mappings = {},
			hide_cursor = false,
		})

		local keymap = {
			["<C-u>"] = function()
				scroll.ctrl_u({ duration = 250 })
			end,
			["<C-d>"] = function()
				scroll.ctrl_d({ duration = 250 })
			end,
			["<C-b>"] = function()
				scroll.ctrl_b({ duration = 450 })
			end,
			["<C-f>"] = function()
				scroll.ctrl_f({ duration = 450 })
			end,
			["<C-y>"] = function()
				scroll.scroll(-0.1, { move_cursor = false, duration = 100 })
			end,
			["<C-m>"] = function()
				scroll.scroll(0.1, { move_cursor = false, duration = 100 })
			end,
			["zt"] = function()
				scroll.zt({ half_win_duration = 250 })
			end,
			["zz"] = function()
				scroll.zz({ half_win_duration = 250 })
			end,
			["zb"] = function()
				scroll.zb({ half_win_duration = 250 })
			end,
		}
		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func)
		end
	end,
}
