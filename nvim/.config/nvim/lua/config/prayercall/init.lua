local title = "Praytell"
local test_total = 1
local is_test = true
local timer = nil
local pre_reminder_amount = 2
local log_levels = vim.log.levels
local default_repeat_in_ms = 600000
-- local default_repeat_in_ms = 60000
local absolute_dir = vim.fs.abspath("~/.local/share/nvim/praytell/")
local init_dir = function()
	if vim.fn.isdirectory(absolute_dir) == 0 then
		vim.cmd("!mkdir " .. absolute_dir)
	end
end
init_dir()

local M = {}

---@param jam string
---@return { hour: number, minute: number, in_ms: number }
local time_parser = function(jam)
	local temp_table = {}
	for value in string.gmatch(jam, "([^:]+)") do
		table.insert(temp_table, tonumber(value))
	end

	return {
		hour = temp_table[1],
		minute = temp_table[2],
		in_ms = temp_table[1] * 3600000 + temp_table[2] * 60000
	}
end

local city_id = 1219
local time_names = {
	"subuh",
	"dzuhur",
	"ashar",
	"maghrib",
	"isya",
}

local time_now = os.time()

---@param target_date string|osdate
---@return any
local function get_schedule(target_date)
	target_date = target_date or os.date("*t")
	local the_date = string.format("%d/%02d/%02d", tostring(target_date.year), tostring(target_date.month),
		tostring(target_date.day))
	-- local file_name = "output_" .. the_date .. ".json"
	local file_name = "output_" ..
		string.format("%d%02d%02d", tostring(target_date.year), tostring(target_date.month), tostring(target_date.day)) ..
		".json"
	if vim.fn.filereadable(absolute_dir .. file_name) == 0 then
		local command = "!curl -s 'https://api.myquran.com/v2/sholat/jadwal/" ..
			city_id .. "/" .. the_date .. "' | jq '.' > " .. absolute_dir .. file_name
		vim.cmd(command)
	end

	local json_str = vim.fn.readfile(absolute_dir .. file_name)
	local json_data = vim.fn.json_decode(table.concat(json_str, "\n"))
	return json_data
end

---@param current_time_name string
---@param _timer? uv.uv_timer_t
local function get_next_schedule(_timer, current_time_name)
	local today = os.date("*t")
	local schedules = get_schedule(today)
	for index, value in ipairs(time_names) do
		local temp_index = index
		if temp_index == #time_names then
			temp_index = 0
			-- local ms_additions = ms_additions + (24 * 60 * 60 * 1000)
			local ms_additions = (24 * 60 * 60 * 1000)
			local time_next_day = time_now + (ms_additions / 1000)
			today = os.date("*t", time_next_day)
			schedules = get_schedule(today)
		end

		if value == current_time_name then
			local next_time_name_index = temp_index + 1
			local next_time_name = time_names[next_time_name_index]
			local next_time_clock = schedules.data.jadwal[next_time_name]
			local next_time_clock_parsed = time_parser(next_time_clock)
			local next_time = os.time({
				year = today.year,
				month = today.month,
				day = today.day,
				hour = next_time_clock_parsed.hour,
				min =
					next_time_clock_parsed.minute,
				sec = 0
			})
			local next_time_in_ms = (next_time - os.time()) * 1000
			if _timer ~= nil then
				_timer:set_repeat(next_time_in_ms)
				if is_test then
					test_total = test_total + 1

					if test_total > 6 then
						_timer:close()
					end
				end
			end
			return {
				time_name = time_names[next_time_name_index],
				time_clock = next_time_clock,
				time_in_ms =
					next_time_in_ms
			}
		end
	end
	return { time_name = "", time_clock = "" }
end



local get_initial_value = function()
	local time_name = ""
	local ms_additions = 0
	local n = 1
	local nearest = 14400000
	local today = os.date("*t")
	local clock = ""

	while time_name == "" and n < 4 do
		local schedule = get_schedule(today)
		local now = os.time()
		for i = #time_names, 1, -1 do
			local key = time_names[i]
			local time_parsed = time_parser(schedule.data.jadwal[key])
			local time_in_ms = os.time({
				year = today.year,
				month = today.month,
				day = today.day,
				hour = time_parsed
					.hour,
				min = time_parsed.minute,
				sec = 0
			})
			if now >= time_in_ms then
				break
			end

			local diff = time_in_ms - now
			nearest = math.min(nearest, diff)
			clock = schedule.data.jadwal[key]
			time_name = key
		end

		if time_name == "" then
			n = n + 1
			ms_additions = ms_additions + (24 * 60 * 60)
			today = os.date("*t", ms_additions)
		end
	end

	local secondary = get_next_schedule(nil, time_name)

	return {
		first_time_name = time_name,
		first_time_in_ms = nearest * 1000,
		first_time_clock = clock,
		second_time_name = secondary.time_name,
		second_time_in_ms = secondary.time_in_ms,
		second_time_clock = secondary.time_clock,
	}
end



---@param time_name? string
---@return {
---time_name: string,
---time_in_ms: integer,
---timeout_in_ms: integer,
---repeat_in_ms: integer,
---time_clock: string,
---}
local function get_initial_reminder_time(time_name)
	local repeat_in_ms = default_repeat_in_ms
	local first_repeat = repeat_in_ms * pre_reminder_amount
	if time_name ~= nil then
		local next = get_next_schedule(nil, time_name)
		local first_time_in_ms = next.time_in_ms
		if first_time_in_ms <= first_repeat then
			repeat_in_ms = 0
		end

		return {
			time_name = next.time_name,
			time_in_ms = first_time_in_ms,
			timeout_in_ms = first_time_in_ms - first_repeat,
			repeat_in_ms = repeat_in_ms,
			time_clock = next.time_clock,
		}
	end

	local ms_additions = 0
	local n = 1
	local nearest = 14400000
	local today = os.date("*t")
	local clock = ""
	time_name = ""

	while time_name == "" and n < 4 do
		local schedule = get_schedule(today)
		local now = os.time()
		for i = #time_names, 1, -1 do
			local key = time_names[i]
			local time_parsed = time_parser(schedule.data.jadwal[key])
			local time_in_ms = os.time({
				year = today.year,
				month = today.month,
				day = today.day,
				hour = time_parsed.hour,
				min = time_parsed.minute,
				sec = 0
			})
			if now >= time_in_ms then
				break
			end

			local diff = time_in_ms - now
			nearest = math.min(nearest, diff)
			clock = schedule.data.jadwal[key]
			time_name = key
		end

		if time_name == "" then
			n = n + 1
			ms_additions = ms_additions + (24 * 60 * 60)
			today = os.date("*t", now + ms_additions)
		end
	end

	local first_time_in_ms = nearest * 1000
	first_repeat = repeat_in_ms * pre_reminder_amount
	if first_time_in_ms <= first_repeat then
		repeat_in_ms = 0
	end

	return {
		time_name = time_name,
		time_in_ms = first_time_in_ms,
		timeout_in_ms = first_time_in_ms - first_repeat,
		repeat_in_ms = repeat_in_ms,
		time_clock = clock,
	}
end

local notifi = function()
	local _timer = vim.uv.new_timer()

	local initial_values = get_initial_value()
	local time_name = initial_values.first_time_name
	local initial_timeout = initial_values.first_time_in_ms
	-- local initial_timeout = 2000

	local clock = initial_values.first_time_clock
	local initial_caption = "Next: " ..
		time_name .. " at " .. clock .. " in " .. tostring(initial_timeout / 1000) .. " seconds"
	local initial_repeat_in_ms = initial_values.second_time_in_ms
	local init = true

	vim.defer_fn(function()
		vim.notify(initial_caption, vim.log.levels.INFO, {
			title = "Reminder: Next Prayer Call",
			timeout = 4000
		})
	end, 500)

	if _timer ~= nil then
		_timer:start(initial_timeout, initial_repeat_in_ms, vim.schedule_wrap(function()
			-- local current_time_name = time_name
			local next_schedule = nil
			if init then
				next_schedule = {
					time_name = initial_values.second_time_name,
					time_in_ms = initial_values.second_time_in_ms,
					time_clock = initial_values.second_time_clock,
				}
				init = false
			else
				next_schedule = get_next_schedule(_timer, time_name)
			end
			local caption = "It's " ..
				string.upper(time_name) ..
				" time!\n" .. "next: " .. next_schedule.time_name .. " at " .. next_schedule.time_clock
			vim.notify(caption, vim.log.levels.INFO, {
				title = "Reminder: Prayer Call",
				timeout = 8000
			})

			-- if repeat_in_ms <= 0 then
			-- 	repeat_in_ms = 0
			-- 	timer:close()
			-- end

			time_name = next_schedule.time_name
		end))
	end
end


---@param opts? {
---time_name?: string,
---thetimer?: uv.uv_timer_t,
---}
local function create_timer(opts)
	local param = opts or {}
	if param.thetimer ~= nil and param.thetimer:is_active() then
		vim.notify("Timer is already active.", log_levels.WARN, {
			title = title,
			timeout = 4000
		})
		return param.thetimer
	else
		vim.notify("Timer initialized successfully.", log_levels.INFO, {
			title = title,
			timeout = 4000
		})
	end
	local _timer = param.thetimer or vim.uv.new_timer()
	local pre_reminder_count = pre_reminder_amount
	local function execute_notify(xxx, trigger, repeat_in_ms, init_time_name)
		if trigger then
			-- vim.notify("asda")
			local caption = "It's " ..
				init_time_name:upper() .. " time!\n"
			-- .. "next: " .. next_schedule.time_name .. " at " .. next_schedule.time_clock
			vim.notify(caption, vim.log.levels.INFO, {
				title = "Reminder: Prayer Call",
				timeout = 8000
			})
			xxx:close()
			timer = create_timer({ time_name = init_time_name })
			return { trigger_current_schedule = false }
		else
			vim.notify(init_time_name .. " in " .. tostring((repeat_in_ms * pre_reminder_count) / 60000) .. " minutes!")
			pre_reminder_count = pre_reminder_count - 1
		end

		-- trigger = trigger_next_call({
		-- 	clock = time_clock,
		-- 	today = os.date("*t"),
		-- 	now_in_ms = os.time(),
		-- 	repeat_in_ms = repeat_in_ms
		-- })
		return { trigger_current_schedule = pre_reminder_count == 0 }
	end

	local initial_reminder_time = get_initial_reminder_time(param.time_name)
	local initial_timeout = initial_reminder_time.timeout_in_ms
	local initial_repeat_in_ms = initial_reminder_time.repeat_in_ms
	if _timer == nil then
		return
	end


	local trigger = false

	local debug_msg = "debug\n"
		.. "initial time name " .. tostring(param.time_name) .. "\n"
		.. "Initial timeout: " .. tostring(initial_timeout) .. "\n"
		.. "initial repeat: " .. tostring(initial_repeat_in_ms) .. "\n"
	vim.notify(debug_msg, vim.log.levels.DEBUG, {
		timeout = 10000
	})


	local init_create_message = "Information\n"
		.. "Next prayer: " .. tostring(initial_reminder_time.time_name:upper()) .. "\n"
		.. initial_reminder_time.time_clock .. "\n"
		.. "Due in " ..
		tostring(math.floor((initial_reminder_time.timeout_in_ms + (initial_repeat_in_ms * pre_reminder_amount)) / 60000)) ..
		" minutes."

	vim.notify(init_create_message, vim.log.levels.INFO, {
		title = title,
		timeout = 10000
	})

	_timer:start(initial_timeout, initial_repeat_in_ms, vim.schedule_wrap(function()
		local execute_result = execute_notify(_timer, trigger, initial_repeat_in_ms, initial_reminder_time.time_name)

		trigger = execute_result.trigger_current_schedule
	end))

	return _timer
end

-- timer = create_timer({})


---@param param_timer? uv.uv_timer_t
local function stop_timer(param_timer)
	if param_timer ~= nil and param_timer:is_active() then
		param_timer:close()
		vim.notify("Timer stopped")
	else
		vim.notify("No active timer")
	end
end

local show_schedule = function()
	local today = os.date("*t")
	local today_schedule = get_schedule(today)
	local tomorrow = os.date("*t", os.time() + 86400)
	local tomorrow_schedule = get_schedule(tomorrow)
	local msg = "Prayer times - " .. today_schedule.data.lokasi .. "\n\n"
		.. "Today" .. "\n"
		.. today_schedule.data.jadwal.tanggal .. "\n"
		.. "subuh: " .. today_schedule.data.jadwal.subuh .. "\n"
		.. "dzuhur: " .. today_schedule.data.jadwal.dzuhur .. "\n"
		.. "ashar: " .. today_schedule.data.jadwal.ashar .. "\n"
		.. "maghrib: " .. today_schedule.data.jadwal.maghrib .. "\n"
		.. "isya: " .. today_schedule.data.jadwal.isya .. "\n"
		.. "\n"
		.. "Tomorrow" .. "\n"
		.. tomorrow_schedule.data.jadwal.tanggal .. "\n"
		.. "subuh: " .. tomorrow_schedule.data.jadwal.subuh .. "\n"
		.. "dzuhur: " .. tomorrow_schedule.data.jadwal.dzuhur .. "\n"
		.. "ashar: " .. tomorrow_schedule.data.jadwal.ashar .. "\n"
		.. "maghrib: " .. tomorrow_schedule.data.jadwal.maghrib .. "\n"
		.. "isya: " .. tomorrow_schedule.data.jadwal.isya .. "\n"

	vim.notify(msg, vim.log.levels.INFO, {
		title = "Prayer Call Schedule",
		timeout = 15000
	})
end

vim.api.nvim_create_user_command("Notifi", notifi, { nargs = 0 })
vim.api.nvim_create_user_command("NotifiGetSchedule", show_schedule, { nargs = 0 })
vim.api.nvim_create_user_command("AdzanCreateTimer", function()
	timer = create_timer({ thetimer = timer })
end, { nargs = 0 })
vim.api.nvim_create_user_command("AdzanStopTimer", function()
	stop_timer(timer)
end, { nargs = 0 })

vim.keymap.set({ "n", "t" }, "<Leader>pr", "<cmd>Notifi<CR>", { desc = "Notify - Init" })
vim.keymap.set({ "n", "t" }, "<Leader>po", "<cmd>NotifiGetSchedule<CR>", { desc = "Notify - Get Schedule" })
vim.keymap.set({ "n", "t" }, "<Leader>pt", "<cmd>AdzanCreateTimer<CR>", { desc = "Notify - Create Timer" })
vim.keymap.set({ "n", "t" }, "<Leader>ps", "<cmd>AdzanStopTimer<CR>", { desc = "Notify - Stop Timer" })

return M
