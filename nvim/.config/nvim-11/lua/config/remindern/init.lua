-- vim.api.nvim_create_user_command("Notifi", notifi, { nargs = 0 })
-- vim.api.nvim_create_user_command("NotifiGetSchedule", show_schedule, { nargs = 0 })
local buf = nil
local width = 100
local height = 4

local col = math.floor((vim.o.columns - width) / 2)
local row = math.floor(vim.o.lines / 10)
local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
}
vim.api.nvim_create_user_command("Well", function()
    vim.notify("Buf not yet created")
    if buf ~= nil then
        vim.notify("Buf already created")
        return
    end
    buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(buf, true, win_config)
end, { nargs = 0 })

vim.api.nvim_create_user_command("WellEnter", function(opts)
    local timeout = opts.fargs[1]
    if buf == nil then
        vim.notify("Buf not yet created")
        return
    end
    local hoho = vim.api.nvim_buf_get_lines(buf, 0, -1, true)
    -- print(hoho)
    local content = ""
    for index, value in ipairs(hoho) do
        content = content .. value .. "\n"
    end
    vim.notify("will notify this after some time: " .. hoho[1])
    local timer = vim.uv.new_timer()
    if timer ~= nil then
        timer:start(tonumber(timeout, 10), 0, function()
            vim.notify("Reminder: " .. content)
        end)
    end
    vim.api.nvim_buf_delete(buf, { unload = false })
end, { nargs = 1 })


vim.keymap.set({ "n" }, "<Leader>pq", "<cmd>Well<CR>", { desc = "Create Reminder" })
vim.keymap.set({ "n" }, "<Leader>pw", "<cmd>WellEnter 10000<CR>", { desc = "Create Reminder Enter" })
-- vim.keymap.set({ "n" }, "<Leader>pw", vim.cmd.WellEnter("5000"), { desc = "Create Reminder Enter" })
