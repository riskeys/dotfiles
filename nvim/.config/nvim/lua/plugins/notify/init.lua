-- return {
--     "echasnovski/mini.notify",
--     version = false,
--     config = function()
--         local notifier = require("mini.notify")
--         notifier.setup({
--             window = {
--                 config = {
--                     width = 20
--                 },
--
--             }
--         })
--         vim.notify = notifier
--     end
-- }
return {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")
        notify.setup({
            merge_duplicates = true,
            level = 1
        })
        vim.notify = notify
    end
}
