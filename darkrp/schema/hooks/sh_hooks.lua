function SCHEMA:CanPlayerEditData(client, target)
	if (client:isCombine()) then
		return true
	end

	return false
end

hook.Add("PlayerDeath", "SCHEMA.PlayerDeathThing", function(victim, inflictor, attacker) 
local character = victim:getChar() 
if !character then return end 

local faction = nut.faction.indices[character:getFaction()] 

nut.chat.send(victim, "dead", character:getName().." «"..faction.name.."»", nil, player.GetAll()) 
end)