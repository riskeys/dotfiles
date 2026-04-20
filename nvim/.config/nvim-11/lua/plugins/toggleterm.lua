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
        vim.keymap.set("n", "<leader>tt1", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
        vim.keymap.set("n", "<leader>tt2", "<cmd>ToggleTerm 2<cr>", { desc = "Toggle terminal 2" })
        vim.keymap.set("n", "<leader>ttt", "<cmd>ToggleTermToggleAll<cr>", { desc = "Toggle terminal all" })
    end,
}
