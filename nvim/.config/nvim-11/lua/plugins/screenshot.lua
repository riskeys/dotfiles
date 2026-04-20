local plugin = {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	main = "nvim-silicon",
	opts = {
		-- Configuration here, or leave empty to use defaults
		line_offset = function(args)
			return args.line1
		end,
	},
	init = function()
		local wk = require("which-key")
		wk.add({
			mode = { "v" },
			{ "<leader>s", group = "Silicon" },
			{
				"<leader>sc",
				function()
					require("nvim-silicon").clip()
				end,
				desc = "Copy code screenshot to clipboard",
			},
			{
				"<leader>sf",
				function()
					require("nvim-silicon").file()
				end,
				desc = "Save code screenshot as file",
			},
			{
				"<leader>ss",
				function()
					require("nvim-silicon").shoot()
				end,
				desc = "Create code screenshot",
			},
		})
	end,
	config = function()
		require("nvim-silicon").setup({
			debug = false,
			theme = "Coldark-Cold",
			language = function()
				return vim.bo.filetype
			end,
		})
	end,
}
return plugin

---- theme
-- 1337
-- Coldark-Cold
-- Coldark-Dark
-- DarkNeon
-- Dracula
-- GitHub
-- Monokai Extended
-- Monokai Extended Bright
-- Monokai Extended Light
-- Monokai Extended Origin
-- Nord
-- OneHalfDark
-- OneHalfLight
-- Solarized (dark)
-- Solarized (light)
-- Sublime Snazzy
-- TwoDark
-- Visual Studio Dark+
-- ansi
-- base16
-- base16-256
-- gruvbox-dark
-- gruvbox-light
-- zenburn
--
