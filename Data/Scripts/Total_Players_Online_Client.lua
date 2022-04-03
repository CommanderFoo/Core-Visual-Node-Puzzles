local COUNT = script:GetCustomProperty("Count"):WaitForObject()
local MENU_COUNT = script:GetCustomProperty("MenuCount"):WaitForObject()

local DATA = script:GetCustomProperty("Data"):WaitForObject()

local function update_total_players(obj, prop)
	if(prop == "total_players") then
		COUNT.text = tostring(DATA:GetCustomProperty("total_players"))
		MENU_COUNT.text = tostring(DATA:GetCustomProperty("total_players"))
	end
end

DATA.customPropertyChangedEvent:Connect(update_total_players)

update_total_players(DATA, "total_players")