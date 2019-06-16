PLUGIN.name = "Голод+++"
PLUGIN.author = "LiGyH"
PLUGIN.desc = "Фабрики + голод."

if (SERVER) then
function PLUGIN:PostPlayerLoadout(client)
if client:getChar():getData("hunger") and client:getChar():getData("thirst") then
		client:setLocalVar("hunger", client:getChar():getData("hunger") )
		client:setLocalVar("thirst", client:getChar():getData("thirst"))
		else 
		client:setLocalVar("hunger", 100 )
		client:setLocalVar("thirst", 100)
		end
		local hungID = "nutHung"..client:SteamID()
		local thirID = "nutThir"..client:SteamID()
		local hungSpeed = 30
		local thirSpeed = 30
		
		timer.Create(thirID, 5, 0, function()
		if (IsValid(client)) then
			if (client:getLocalVar("hunger") <= 0) or (client:getLocalVar("thirst") <= 0) then
				client:TakeDamage(5)
			end
		else
			timer.Remove(thirID)
		end
		end)
		
end

local playerMeta = FindMetaTable("Player")

	function playerMeta:restoreHunger(amount)
		local current = self:getLocalVar("hunger", 0)
		local value = math.Clamp(current + amount, 0, 100)

		self:setLocalVar("hunger", value)
	end
	
	function playerMeta:restoreThirst(amount)
		local current = self:getLocalVar("thirst", 0)
		local value = math.Clamp(current + amount, 0, 100)

		self:setLocalVar("thirst", value)
	end
end