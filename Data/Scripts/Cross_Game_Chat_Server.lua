local CROSS_GAME_CHAT_KEY = script:GetCustomProperty("CrossGameChat")

local message_queue = {}
local wait_time = 5
local max_queue = 20
local max_concurrent = 50
local last_timestamp = 0
local server_id = nil
local RNG = RandomStream.New(os.time())

local function uuid()
	local template ="xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"

	return string.gsub(template, "[xy]", function(c)
		local v = (c == "x") and RNG:GetInteger(0, 0xf) or RNG:GetInteger(8, 0xb)
		return string.format('%x', v)
	end)
end

local function get_last_timestamp()
	local old_data = Storage.GetConcurrentCreatorData(CROSS_GAME_CHAT_KEY)

	if(#old_data > 0) then
		last_timestamp = old_data[#old_data][2]
	end

	if(server_id == nil) then
		server_id = uuid()
	end
end

local function add_message_to_queue(speaker, params)
	table.insert(message_queue, { server_id, DateTime.CurrentTime().secondsSinceEpoch, params.speakerName, params.message })
end

local function prune_table(t, prune_length)
	while(#t >= prune_length) do
		table.remove(t, 1)
	end

	return t
end

local function save_message_queue(data)
	local queue = prune_table(message_queue, max_queue)
	local concurrent_data = prune_table(data, max_concurrent)

	for i, m in ipairs(queue) do
		table.insert(concurrent_data, m)
	end

	message_queue = {}

	return concurrent_data
end

local function get_messages(key, data)
	for i, m in ipairs(data) do
		if(m[1] ~= server_id and m[2] > last_timestamp) then
			Chat.BroadcastMessage(m[3] .. ": " .. m[4])
			last_timestamp = m[2]
		end
	end
end

function Tick()
	Task.Wait(wait_time)

	if(#message_queue == 0 or Storage.HasPendingSetConcurrentCreatorData(CROSS_GAME_CHAT_KEY)) then
		return
	end

	Storage.SetConcurrentCreatorData(CROSS_GAME_CHAT_KEY, save_message_queue)
	message_queue = {}
end

get_last_timestamp()

Chat.receiveMessageHook:Connect(add_message_to_queue)
Storage.ConnectToConcurrentCreatorDataChanged(CROSS_GAME_CHAT_KEY, get_messages)