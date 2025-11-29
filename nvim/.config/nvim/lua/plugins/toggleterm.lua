return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        highlights = {
            Normal = {
                guibg = "#ebebeb",
            },
            NormalFloat = {
                guibg = "#1e1e2e",
            },
            FloatBorder = {
                guifg = "#f38ba8",
                guibg = "#1e1e2e",
            },
        }
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)
        vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
    end,
}
