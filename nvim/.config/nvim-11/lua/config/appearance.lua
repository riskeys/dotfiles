vim.cmd.colorscheme("catppuccin")

local dark_mode = true
local transparent_mode = false

vim.api.nvim_create_user_command("ToggleDarkMode", function()
    if dark_mode then
        -- vim.cmd.colorscheme("catppuccin-latte")
        vim.cmd.colorscheme("kanagawa-lotus")
        dark_mode = false
    else
        vim.cmd.colorscheme("kanagawa-dragon")
        dark_mode = true
    end
end, {})

vim.api.nvim_create_user_command("ToggleTransparent", function()
    if transparent_mode then
        local current_color = vim.g.colors_name
        vim.cmd.colorscheme(current_color)
        transparent_mode = false
    else
        vim.cmd.hi("Comment gui=none")
        vim.cmd.hi("Normal guibg=none")
        vim.cmd.hi("NonText guibg=none")
        vim.cmd.hi("Normal ctermbg=none")
        vim.cmd.hi("NonText guibg=none")
        transparent_mode = true
    end
end, {})

vim.keymap.set("n", "<C-b><C-g>", ":ToggleDarkMode<CR>", { desc = "Toggle Dark Mode" })
vim.keymap.set("n", "<C-b><C-t>", ":ToggleTransparent<CR>", { desc = "Toggle Transparent" })
