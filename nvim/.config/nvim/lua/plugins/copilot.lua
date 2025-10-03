return {
    "github/copilot.vim",
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "markdown", "css", "html" },
            callback = function()
                vim.g.copilot_enabled = 0
            end
        })
    end,

}
