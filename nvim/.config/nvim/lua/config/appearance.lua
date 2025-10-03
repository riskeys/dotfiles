-- vim.cmd.colorscheme("unokai")
-- vim.cmd.colorscheme("gruvbox-material")
vim.cmd.colorscheme("kanagawa-dragon")
-- vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("catppuccin-latte")
vim.cmd.hi("Comment gui=none")
vim.cmd.hi("Normal guibg=none")
vim.cmd.hi("NonText guibg=none")
vim.cmd.hi("Normal ctermbg=none")
vim.cmd.hi("NonText guibg=none")

local dark_mode = true

vim.api.nvim_create_user_command("ToggleDarkMode", function()
    if dark_mode then
        vim.cmd.colorscheme("catppuccin-latte")
        dark_mode = false
    else
        vim.cmd.colorscheme("kanagawa-dragon")
        vim.cmd.hi("Comment gui=none")
        vim.cmd.hi("Normal guibg=none")
        vim.cmd.hi("NonText guibg=none")
        vim.cmd.hi("Normal ctermbg=none")
        vim.cmd.hi("NonText guibg=none")
        dark_mode = true
    end
end, {})

vim.keymap.set("n", "<C-b>", ":ToggleDarkMode<CR>", { desc = "Toggle Dark Mode" })
