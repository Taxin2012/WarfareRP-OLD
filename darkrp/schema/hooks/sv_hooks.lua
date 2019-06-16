function SCHEMA:PlayerFootstep(client, position, foot, soundName, volume)
	if (client:isRunning()) then
		if (client:Team() == FACTION_CP) then
			client:EmitSound("npc/metropolice/gear"..math.random(1, 6)..".wav", volume * 130)

			return true
		elseif (client:Team() == FACTION_OW) then
			client:EmitSound("npc/combine_soldier/gear"..math.random(1, 6)..".wav", volume * 100)

			return true
		end
	end
end

function SCHEMA:PlayerDeath(victim, weapon, attacker)
--------------------------¬«НЇ----------------------
--------------------------¬ЙЪТХ«Р?Ы----------------------
victim:getChar():setData("rep", victim:getChar():getData("rep", 0) - 0)---Ъросто умер
if (attacker:IsPlayer()) then
if (attacker:Team() == FACTION_LONER) then
if (victim:Team() == FACTION_LONER or victim:Team() == FACTION_DUTY or victim:Team() == FACTION_FREEDOM or victim:Team() == FACTION_CLEARSKY or victim:Team() == FACTION_SCIENTIST) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 10)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
end
elseif (attacker:Team() == FACTION_RAIDERS) then
if (victim:Team() == FACTION_RAIDERS or victim:Team() == FACTION_FREEDOM or victim:Team() == FACTION_MERCENARIES) then 
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 10)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
end
elseif (attacker:Team() == FACTION_DUTY) then
if (victim:Team() == FACTION_DUTY or victim:Team() == FACTION_LONER or victim:Team() == FACTION_SCIENTIST or victim:Team() == FACTION_MILITARY or victim:Team() == FACTION_CLEARSKY) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 10)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
end
elseif (attacker:Team() == FACTION_FREEDOM) then
if (victim:Team() == FACTION_FREEDOM or victim:Team() == FACTION_LONER or victim:Team() == FACTION_SCIENTIST or victim:Team() == FACTION_RAIDERS or victim:Team() == FACTION_MERCENARIES) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 10)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
end
elseif (attacker:Team() == FACTION_MONOLIT) then
if (victim:Team() == FACTION_MONOLIT) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 10)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
end
elseif (attacker:Team() == FACTION_RENEGAT) then
if (victim:Team() == FACTION_RENEGAT) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 1)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 1)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 1)
end
elseif (attacker:Team() == FACTION_MILITARY) then
if (victim:Team() == FACTION_MILITARY or victim:Team() == FACTION_DUTY or victim:Team() == FACTION_SCIENTIST) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 10)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
end
elseif (attacker:Team() == FACTION_MERCENARIES) then
if (victim:Team() == FACTION_MERCENARIES or victim:Team() == FACTION_FREEDOM or victim:Team() == FACTION_RAIDERS) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 10)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
end
elseif (attacker:Team() == FACTION_MERCHANTS) then
if (victim:Team() == FACTION_MERCHANTS) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 10)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
end
elseif (attacker:Team() == FACTION_GREH) then
if (victim:Team() == FACTION_GREH) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 10)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
end
elseif (attacker:Team() == FACTION_SCIENTIST) then
if (victim:Team() == FACTION_SCIENTIST or victim:Team() == FACTION_DUTY or victim:Team() == FACTION_MILITARY or victim:Team() == FACTION_LONER) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 50)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
else
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 10)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 10)
end
end
if ((attacker:getChar():getData("rep", 0) > 1999 and attacker:getChar():getData("rep", 0) < 2004)
 or (attacker:getChar():getData("rep", 0) > 999 and attacker:getChar():getData("rep", 0) < 1004)
 or (attacker:getChar():getData("rep", 0) > 499 and attacker:getChar():getData("rep", 0) < 504)
 or (attacker:getChar():getData("rep", 0) > 99 and attacker:getChar():getData("rep", 0) < 104)
 or (attacker:getChar():getData("rep", 0) > -84 and attacker:getChar():getData("rep", 0) < -79)
 or (attacker:getChar():getData("rep", 0) > -304 and attacker:getChar():getData("rep", 0) < -299)
 or (attacker:getChar():getData("rep", 0) > -604 and attacker:getChar():getData("rep", 0) < -599)) then
	 attacker:ConCommand("say /zdwonnewrep "..attacker:getChar():getData("rep", 0))
end

if ((attacker:getChar():getData("rank", 0) > 199 and attacker:getChar():getData("rank", 0) < 204)
 or (attacker:getChar():getData("rank", 0) > 599 and attacker:getChar():getData("rank", 0) < 604)
 or (attacker:getChar():getData("rank", 0) > 999 and attacker:getChar():getData("rank", 0) < 1004)
 or (attacker:getChar():getData("rank", 0) > 1999 and attacker:getChar():getData("rank", 0) < 2004)
 or (attacker:getChar():getData("rank", 0) > 3199 and attacker:getChar():getData("rank", 0) < 3204)
 or (attacker:getChar():getData("rank", 0) > 5199 and attacker:getChar():getData("rank", 0) < 5204)
 or (attacker:getChar():getData("rank", 0) > 11999 and attacker:getChar():getData("rank", 0) < 12004)) then
	 attacker:ConCommand("say /zupnewrank "..attacker:getChar():getData("rank", 0))
end

local character = attacker:getChar()
	if (character) then
		local inventory = character:getInv()
		if (attacker:getChar():getData("rank", 0) > 199 and attacker:getChar():getData("rank", 0) < 204) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m1_5")
				if (!items) then
					inventory:add("m1_5", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 599 and attacker:getChar():getData("rank", 0) < 604) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m2")
				if (!items) then
					inventory:add("m2", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 999 and attacker:getChar():getData("rank", 0) < 1004) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m3")
				if (!items) then
					inventory:add("m3", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 1999 and attacker:getChar():getData("rank", 0) < 2004) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m4")
				if (!items) then
					inventory:add("m4", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 3199 and attacker:getChar():getData("rank", 0) < 3204) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m5")
				if (!items) then
					inventory:add("m5", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 5199 and attacker:getChar():getData("rank", 0) < 5204) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m6")
				if (!items) then
					inventory:add("m6", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 11999 and attacker:getChar():getData("rank", 0) < 12004) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m9")
				if (!items) then
					inventory:add("m9", 1)
				end
			end			
		end
	end

if (attacker:Team() == FACTION_LONER and attacker:getChar():getData("rep", 0) < -30)
or (attacker:Team() == FACTION_RAIDERS and attacker:getChar():getData("rep", 0) < -30)
or (attacker:Team() == FACTION_MILITARY and attacker:getChar():getData("rep", 0) < -30)
or (attacker:Team() == FACTION_DUTY and attacker:getChar():getData("rep", 0) < -30)
or (attacker:Team() == FACTION_FREEDOM and attacker:getChar():getData("rep", 0) < -30)
or (attacker:Team() == FACTION_CLEARSKY and attacker:getChar():getData("rep", 0) < -30)
or (attacker:Team() == FACTION_MERCENARIES and attacker:getChar():getData("rep", 0) < -30)
or (attacker:Team() == FACTION_SCIENTISTS and attacker:getChar():getData("rep", 0) < -30)
or (attacker:Team() == FACTION_MONOLIT and attacker:getChar():getData("rep", 0) < -30)
or (attacker:Team() == FACTION_MERCHANTS and attacker:getChar():getData("rep", 0) < -30)
or (attacker:Team() == FACTION_MONOLIT and attacker:getChar():getData("rep", 0) < -30) then
--and attacker:getChar():getData("rep", 0) > -900 
--and attacker:getChar():getData("rep", 0) > -30) then
local faction = nut.faction.indices[FACTION_RENEGAT]
if (faction) then
	local faction = nut.faction.indices[FACTION_RENEGAT]
    local character = attacker:getChar()

    character.vars.faction = faction.uniqueID
    character:setFaction(faction.index)
end
attacker:SetModel("models/spenser/ssk/new_renegat_01_spen.mdl")
local character = attacker:getChar() 
if !character then return end 
local faction = nut.faction.indices[character:getFaction()] 
attacker:ConCommand("say /zfracquestc"..faction.name.."") 
end 

if (attacker:Team() == FACTION_RENEGAT and attacker:getChar():getData("rep", 0) > -29 and attacker:getChar():getData("rep", 0) < 99) then
local faction = nut.faction.indices[FACTION_LONER]

if (faction) then
    local character = attacker:getChar()

    character.vars.faction = faction.uniqueID
    character:setFaction(faction.index)
end
	attacker:SetModel("models/spenser/ssk/new_stalk_01_spen.mdl") 
	local character = attacker:getChar() 
	if !character then return end 
	local faction = nut.faction.indices[character:getFaction()] 
	attacker:ConCommand("say /zfracquestc"..faction.name.."") 
end
end	

end

function SCHEMA:OnNPCKilled( npc, attacker, inflictor )
if (attacker) then
if (npc:GetModel() == "models/spenser/ssk/contrler_spenser.mdl") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 7)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 7)
elseif (npc:GetModel() == "models/spenser/ssk/new_plot_spen.mdl") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 1)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 1)
elseif (npc:GetModel() == "models/spenser/ssk/new_krovo_spen.mdl" and npc:GetSkin() == 0) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 3)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 3)
elseif (npc:GetModel() == "models/spenser/ssk/new_krovo_spen.mdl" and npc:GetSkin() == 1) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 3)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 3)
elseif (npc:GetModel() == "models/spenser/ssk/new_krovo_spen.mdl" and npc:GetSkin() == 2) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 3)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 3)
elseif (npc:GetModel() == "models/spenser/ssk/new_dog_spen.mdl") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 1)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 1)
elseif (npc:GetModel() == "models/spenser/ssk/new_tush_spen.mdl") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 1)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 1)
elseif (npc:GetModel() == "models/spenser/ssk/new_boar_spen.mdl") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 1)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 1)
elseif (npc:GetModel() == "models/spenser/ssk/new_snork_spen.mdl") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 3)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 3)
elseif (npc:GetClass() == "ssk_phantom") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 1)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 1)
elseif (npc:GetClass() == "ssk_phantom2") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 1)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 1)
elseif (npc:GetModel() == "models/spenser/ssk/new_psydog_spen.mdl" and npc:GetSkin() == 0) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 3)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 3)
elseif (npc:GetModel() == "models/spenser/ssk/new_psydog_spen.mdl" and npc:GetSkin() == 1) then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 5)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 5)
attacker:SetNetVar("lostkill", 11)//Psy
elseif (npc:GetModel() == "models/spenser/ssk/new_burer_spen.mdl") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 5)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 5)
elseif (npc:GetModel() == "models/spenser/ssk/new_zombi_spen.mdl") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 2)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 2)
elseif (npc:GetModel() == "models/spenser/ssk/new_izlom_spen.mdl") then
attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 4)
attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 4)
end
--[[if (attacker:Team() == FACTION_RENEGAT and (attacker:getChar():getData("rep", 0) > -90 and attacker:getChar():getData("rep", 0) < -79) or (attacker:getChar():getData("rep", 0) > -309 and attacker:getChar():getData("rep", 0) < -299) or (attacker:getChar():getData("rep", 0) > -609 and attacker:getChar():getData("rep", 0) < -599) or (attacker:getChar():getData("rep", 0) > -609 and attacker:getChar():getData("rep", 0) < -599)) then
	 attacker:ConCommand("say 123")
end]]

if ((attacker:getChar():getData("rep", 0) > 1999 and attacker:getChar():getData("rep", 0) < 2004)
 or (attacker:getChar():getData("rep", 0) > 999 and attacker:getChar():getData("rep", 0) < 1004)
 or (attacker:getChar():getData("rep", 0) > 499 and attacker:getChar():getData("rep", 0) < 504)
 or (attacker:getChar():getData("rep", 0) > 99 and attacker:getChar():getData("rep", 0) < 104)
 or (attacker:getChar():getData("rep", 0) > -84 and attacker:getChar():getData("rep", 0) < -79)
 or (attacker:getChar():getData("rep", 0) > -304 and attacker:getChar():getData("rep", 0) < -299)
 or (attacker:getChar():getData("rep", 0) > -604 and attacker:getChar():getData("rep", 0) < -599)) then
	 attacker:ConCommand("say /zdwonnewrep "..attacker:getChar():getData("rep", 0))
end

if ((attacker:getChar():getData("rank", 0) > 199 and attacker:getChar():getData("rank", 0) < 204)
 or (attacker:getChar():getData("rank", 0) > 599 and attacker:getChar():getData("rank", 0) < 604)
 or (attacker:getChar():getData("rank", 0) > 999 and attacker:getChar():getData("rank", 0) < 1004)
 or (attacker:getChar():getData("rank", 0) > 1999 and attacker:getChar():getData("rank", 0) < 2004)
 or (attacker:getChar():getData("rank", 0) > 3199 and attacker:getChar():getData("rank", 0) < 3204)
 or (attacker:getChar():getData("rank", 0) > 5199 and attacker:getChar():getData("rank", 0) < 5204)
 or (attacker:getChar():getData("rank", 0) > 11999 and attacker:getChar():getData("rank", 0) < 12004)) then
	 attacker:ConCommand("say /zupnewrank "..attacker:getChar():getData("rank", 0))
end

local character = attacker:getChar()
	if (character) then
		local inventory = character:getInv()
		if (attacker:getChar():getData("rank", 0) > 199 and attacker:getChar():getData("rank", 0) < 204) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m1_5")
				if (!items) then
					inventory:add("m1_5", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 599 and attacker:getChar():getData("rank", 0) < 604) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m2")
				if (!items) then
					inventory:add("m2", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 999 and attacker:getChar():getData("rank", 0) < 1004) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m3")
				if (!items) then
					inventory:add("m3", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 1999 and attacker:getChar():getData("rank", 0) < 2004) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m4")
				if (!items) then
					inventory:add("m4", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 3199 and attacker:getChar():getData("rank", 0) < 3204) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m5")
				if (!items) then
					inventory:add("m5", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 5199 and attacker:getChar():getData("rank", 0) < 5204) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m6")
				if (!items) then
					inventory:add("m6", 1)
				end
			end
		elseif (attacker:getChar():getData("rank", 0) > 11999 and attacker:getChar():getData("rank", 0) < 12004) then
			if (inventory) then		
				local items = attacker:getChar():getInv():hasItem("m9")
				if (!items) then
					inventory:add("m9", 1)
				end
			end			
		end
	end

if (attacker:Team() == FACTION_RENEGAT and attacker:getChar():getData("rep", 0) > -29 and attacker:getChar():getData("rep", 0) < 99) then
------------
local faction = nut.faction.indices[FACTION_LONER]

if (faction) then
    local character = attacker:getChar()

    character.vars.faction = faction.uniqueID
    character:setFaction(faction.index)
end
----------------------
	attacker:SetModel("models/spenser/ssk/new_stalk_01_spen.mdl") 
	local character = attacker:getChar() 
	if !character then return end 
	local faction = nut.faction.indices[character:getFaction()] 
	attacker:ConCommand("say /zfracquestc"..faction.name.."") 
end
end	
end

--[[function SCHEMA:PlayerSpray(client) --можно рисовать на стене
	return !client:getChar():getInv():hasItem("spraycan") or false
end]]

function SCHEMA:OnCharCreated(client, character)
	local inventory = character:getInv()

	if (inventory) then		
		if (character:getFaction() == FACTION_MILITARY) then
			inventory:add("docsbu", 1, {})
			inventory:add("pda_loner", 1, {})
			inventory:add("uamre", 1, {})
			inventory:add("knife", 1, {})
			inventory:add("fort", 1, {})
			inventory:add("aksu", 1, {})
			inventory:add("545x39", 1, {})
			inventory:add("blow", 1, {})
			inventory:add("tinderbox", 1, {})
			inventory:add("brodyagelox", 1, {})
			inventory:add("9x18", 3, {})
			inventory:add("kowelek", 1, {})
			inventory:add("bint", 2, {})
			inventory:add("1000r", 1, {})
		elseif (character:getFaction() == FACTION_LONER) then
			inventory:add("pda_loner", 1, {})
			inventory:add("knife", 1, {})
			inventory:add("colt", 1, {})
			inventory:add("obrez", 1, {})
			inventory:add("tinderbox", 1, {})
			inventory:add("brodyagelox", 1, {})
			inventory:add("blow", 1, {})
			inventory:add("tinderbox", 1, {})
			inventory:add("45acp", 3, {})
			inventory:add("12x70", 1, {})
			inventory:add("kowelek", 1, {})
			inventory:add("boots", 1, {})
			inventory:add("bint", 2, {})
			inventory:add("1000r", 1, {})
			inventory:add("bread", 1, {})
			inventory:add("konservi", 1, {})
			inventory:add("water", 1, {})
			inventory:add("kithunt", 1, {})
		elseif (character:getFaction() == FACTION_RAIDERS) then
			inventory:add("pda_loner", 1, {})
			inventory:add("knife", 1, {})
			inventory:add("pm", 1, {})
			inventory:add("mp5", 1, {})
			inventory:add("blow", 1, {})
			inventory:add("tinderbox", 1, {})
			inventory:add("brodyagelox", 1, {})
			inventory:add("9x18", 3, {})
			inventory:add("9x19", 1, {})
			inventory:add("kowelek", 1, {})
			inventory:add("garmosh", 1, {})
			inventory:add("bint", 1, {})
			inventory:add("1000r", 1, {})
			inventory:add("bread", 1, {})
			inventory:add("konservi", 1, {})
			inventory:add("water", 1, {})
		end
	end
end

function SCHEMA:PlayerSpawn(client)
	client:setNetVar("mask1", false) 
	client:setNetVar("mask2", false) 
	client:setNetVar("mask3", false) 
	client:setNetVar("drunk", 0)
	
	timer.Remove("name1")
	
	timer.Create("name1", 8, 0, 
	function() 
	if (IsValid(client)) then 
	client:EmitSound("snd/bar/rndambient/fog_"..math.random(1,115)..".ogg") 
	end
	end)
	
	local character = client:getChar()
	if (character) then
		local inventory = character:getInv()
		if (client:Team() == FACTION_LONER) then
			if (inventory) then		
				local items = client:getChar():getInv():hasItem("ploner")
				if (!items) then
					inventory:add("ploner", 1)
				end
			end
		elseif (client:Team() == FACTION_MERCENARIES) then
			if (inventory) then		
				local items = client:getChar():getInv():hasItem("pmerc")
				if (!items) then
					inventory:add("pmerc", 1)
				end
			end
		elseif (client:Team() == FACTION_MILITARY) then
			if (inventory) then		
				local items = client:getChar():getInv():hasItem("pmilitary")
				if (!items) then
					inventory:add("pmilitary", 1)
				end
			end
		elseif (client:Team() == FACTION_RAIDERS) then
			if (inventory) then		
				local items = client:getChar():getInv():hasItem("pbandit1")
				if (!items) then
					inventory:add("pbandit1", 1)
				end
			end
		elseif (client:Team() == FACTION_RENEGAT) then
			if (inventory) then		
				local items = client:getChar():getInv():hasItem("prenegat")
				if (!items) then
					inventory:add("prenegat", 1)
				end
			end
		elseif (client:Team() == FACTION_FREEDOM) then
			if (inventory) then		
				local items = client:getChar():getInv():hasItem("pfreedom")
				if (!items) then
					inventory:add("pfreedom", 1)
				end
			end
		elseif (client:Team() == FACTION_DUTY) then
			if (inventory) then		
				local items = client:getChar():getInv():hasItem("pdolg")
				if (!items) then
					inventory:add("pdolg", 1)
				end
			end
		elseif (client:Team() == FACTION_CLEARSKY) then
			if (inventory) then		
				local items = client:getChar():getInv():hasItem("pclearsky")
				if (!items) then
					inventory:add("pclearsky", 1)
				end
			end
		elseif (client:Team() == FACTION_MONOLIT) then
			if (inventory) then		
				local items = client:getChar():getInv():hasItem("pmonolit")
				if (!items) then
					inventory:add("pmonolit", 1)
				end
			end
		end
--------------------------------------------------------------------------------------
		if (game.GetMap() == "rp_agroprom") then
			if (inventory) then		
				if  client:getChar():getInv():hasItem("svalka_agro") then
					timer.Simple(1.5,function()
					client:getChar():getInv():remove(client:getChar():getInv():hasItem("svalka_agro"):getID())
					client:SetPos(Vector(10616.571289, 52.016514, 9.646149
)) 					
					end)
				end
				--[[if  client:getChar():getInv():hasItem("bar_agro") then
					timer.Simple(1.5,function()
					client:getChar():getInv():remove(client:getChar():getInv():hasItem("bar_agro"):getID())
					client:SetPos(Vector(934.940979, 114.241577, -64.968750)) 					
					end)
				end]]
			end
		end
		if (game.GetMap() == "rp_rostok_v1") then
			if (inventory) then		
				if  client:getChar():getInv():hasItem("svalka_bar") then
					timer.Simple(1.5,function()
					client:getChar():getInv():remove(client:getChar():getInv():hasItem("svalka_bar"):getID()) 
					client:SetPos(Vector(-12715.385742188, -7182.5205078125, 38.294906616211)) 
					end)
				end
				--[[if  client:getChar():getInv():hasItem("agro_bar") then
					timer.Simple(1.5,function()
					client:getChar():getInv():remove(client:getChar():getInv():hasItem("agro_bar"):getID()) 
					client:SetPos(Vector(1461.7297363281, 2580.4514160156, 0.03125)) 
					end)
				end]]
				if  client:getChar():getInv():hasItem("armysklad_bar") then
					timer.Simple(1.5,function()
					client:getChar():getInv():remove(client:getChar():getInv():hasItem("armysklad_bar"):getID()) 
					client:SetPos(Vector(8114.619141, 2875.771973, -119.516174)) 
					end)
				end
			end
		end
		if (game.GetMap() == "rp_army_warehouses_v1a") then
			if (inventory) then		
				if  client:getChar():getInv():hasItem("bar_armysklad") then
					timer.Simple(1.5,function()
					client:getChar():getInv():remove(client:getChar():getInv():hasItem("bar_armysklad"):getID()) 
					client:SetPos(Vector(7978.1123046875, 7300.5483398438, -763.57672119141)) 
					end)
				end
			end
		end
		
		if (game.GetMap() == "rp_garbage_shoc") then
			if (inventory) then		
				if  client:getChar():getInv():hasItem("agro_svalka") then
					timer.Simple(1.5,function()
					client:getChar():getInv():remove(client:getChar():getInv():hasItem("agro_svalka"):getID()) 
					client:SetPos(Vector(-8303.011719, -1302.789307, 38.294495))
					end)
				end
				--[[if  client:getChar():getInv():hasItem("agro_bar") then
					timer.Simple(1.5,function()
					client:getChar():getInv():remove(client:getChar():getInv():hasItem("agro_bar"):getID()) 
					client:SetPos(Vector(1461.7297363281, 2580.4514160156, 0.03125)) 
					end)
				end]]
				if  client:getChar():getInv():hasItem("bar_svalka") then
					timer.Simple(1.5,function()
					client:getChar():getInv():remove(client:getChar():getInv():hasItem("bar_svalka"):getID()) 
					client:SetPos(Vector(893.165833, 9204.293945, 30.367172)) 
					end)
				end
			end
		end
--------------------------------------------------------------------		
	end
	client:setNetVar("gassound", false)
end

function SCHEMA:LoadData()
	--self:loadVendingMachines()
	self:loadDispensers()
	self:loadObjectives()
end

function SCHEMA:CanPlayerViewData(client, target)
	if (client:isCombine()) then
		return true
	end
end

function SCHEMA:PlayerUseDoor(client, entity)
	if (client:isCombine()) then
		local lock = entity.lock or (IsValid(entity:getDoorPartner()) and entity:getDoorPartner().lock)

		if (client:KeyDown(IN_SPEED) and IsValid(lock)) then
			lock:toggle()

			return false
		elseif (!entity:HasSpawnFlags(256) and !entity:HasSpawnFlags(1024)) then
			entity:Fire("open", "", 0)
		end
	end
end

function SCHEMA:PlayerRankChanged(client)
	for k, v in pairs(self.rankModels) do
		if (client:isCombineRank(k)) then
			client:SetModel(v)
		end
	end
end

function SCHEMA:KeyPress(client, key, item)
if (client.character) then
if (client:Alive()) then

if (key == IN_USE) then
local Hit = client:GetEyeTraceNoCursor()
local npc = Hit.Entity
if (npc:GetClass() == "nut_tent") then
if (npc:GetPos():Distance(client:GetPos()) <= 100) then
client:getChar():getInv():add("tent")
npc:Remove()
end
end
end

end
end
end

function SCHEMA:OnCharVarChanged(character, key, oldValue, value)
	if (key == "name" and IsValid(character:getPlayer()) and character:getPlayer():isCombine()) then
		for k, v in ipairs(nut.class.list) do
			if (character:joinClass(k)) then
				break
			end
		end

		hook.Run("PlayerRankChanged", character:getPlayer())
	end
end

local digitsToWords = {
	[0] = "zero",
	[1] = "one",
	[2] = "two",
	[3] = "three",
	[4] = "four",
	[5] = "five",
	[6] = "six",
	[7] = "seven",
	[8] = "eight",
	[9] = "nine"
}

function SCHEMA:GetPlayerDeathSound(client)
	if (client:isCombine()) then
		local sounds = self.deathSounds[client:Team()] or self.deathSounds[FACTION_CP]
		local digits = client:getDigits()
		local queue = {""}

		if (tonumber(digits)) then
			for i = 1, #digits do
				local digit = tonumber(digits:sub(i, i))
				local word = digitsToWords[digit]

				queue[#queue + 1] = "npc/overwatch/radiovoice/"..word..".wav"
			end

			local chance = math.random(1, 7)

			if (chance == 2) then
				queue[#queue + 1] = ""
			elseif (chance == 3) then
				queue[#queue + 1] = ""
			end

			queue[#queue + 1] = {table.Random(self.beepSounds[client:Team()] and self.beepSounds[client:Team()].off or self.beepSounds[FACTION_CP].off), nil, 0.25}

			for k, v in ipairs(player.GetAll()) do
				if (v:isCombine()) then
					nut.util.emitQueuedSounds(v, queue, 2, nil, v == client and 100 or 65)
				end
			end
		end
	end
end


function SCHEMA:GetPlayerPainSound(client)
	if (client:isCombine()) then
		local sounds = self.painSounds[client:Team()] or self.painSounds[FACTION_CP]

		return table.Random(sounds)
	end
end

function SCHEMA:PlayerMessageSend(client, chatType, message, anonymous, receivers)
	if (!nut.voice.chatTypes[chatType]) then
		return
	end

	for _, definition in ipairs(nut.voice.getClass(client)) do
		local sounds, message = nut.voice.getVoiceList(definition.class, message)

		if (sounds) then
			local volume = 80

			if (chatType == "w") then
				volume = 60
			elseif (chatType == "y") then
				volume = 150
			end
			
			if (definition.onModify) then
				if (definition.onModify(client, sounds, chatType, message) == false) then
					continue
				end
			end

			if (definition.isGlobal) then
				netstream.Start(nil, "voicePlay", sounds, volume)
			else
				netstream.Start(nil, "voicePlay", sounds, volume, client:EntIndex())

				if (chatType == "radio" and receivers) then
					for k, v in pairs(receivers) do
						if (receivers == client) then
							continue
						end

						netstream.Start(nil, "voicePlay", sounds, volume * 0.5, v:EntIndex())
					end
				end
			end

			return message
		end
	end
end

function SCHEMA:PlayerStaminaLost(client)
	if (client:isCombine()) then
		client:addDisplay("Local unit energy has been exhausted")
	end
end

function SCHEMA:CanPlayerViewObjectives(client)
	return client:isCombine()
end

function SCHEMA:CanPlayerEditObjectives(client)
	return client:isCombine()
end

netstream.Hook("dataCls", function(client, text)
	local target = client.nutDataTarget

	if (text and IsValid(target) and target:getChar() and hook.Run("CanPlayerEditData", client, target)) then
		target:getChar():setData("txt", text:sub(1, 750))
		client:EmitSound("buttons/combine_button7.wav", 60, 150)
	end

	client.nutDataTarget = nil
end)

netstream.Hook("obj", function(client, text)
	if (hook.Run("CanPlayerEditObjectives", client)) then
		SCHEMA.objectives = text
		SCHEMA:addDisplay(client:Name().." has updated the objectives", Color(0, 0, 255))
		SCHEMA:saveObjectives()
	end
end)

function SCHEMA:Think()
for k , v in pairs(ents.FindByClass("prop_ragdoll")) do
if (!v.timeremove or v.timeremove < CurTime()) then
if (IsValid(v)) then
v:Fire("FadeAndRemove","",20)
v.timeremove = CurTime() + 1--?ремџ исчезновениџ
end
end
end
---------------?опли
for k , v in pairs(player.GetAll()) do
if (IsValid(v)) then
if (v:Health() > 0 and v:Health() <= 20) then
if (!v.timeremove or v.timeremove < CurTime()) then
v:EmitSound("lowhp/health_"..math.random(1,10)..".ogg")
v.timeremove = CurTime() + 3
end
end

if (v:IsPlayer()) then
local client = v
if (client.character) then
if (client:Health() > 0 and client:Health() < 150 ) then
if (client:Team() == FACTION_ZOMB) then
if (!client.timeregen or client.timeregen < CurTime()) then
client:SetHealth(client:Health() + 5)
client.timeregen = CurTime() + 5
end
end
end
end
end
--------------------------Уонарик--------------------------
--[[if (!v.timeflash or v.timeflash < CurTime()) then
local character = v:getChar()
if (character) then
--
if (v:FlashlightIsOn()) then
-----v
if (character:getData("flashlightzarad", 0) > 0) then
character:setData("flashlightzarad", character:getData("flashlightzarad", 0) - 300)--кол-во зарџда
else
v:Flashlight( false )	
end
--
end

---------
end--if (character) then
v.timeflash = CurTime() + 300--времџ за сколько тратитсџ кол-во
end]]
--- DAMGE ART	
if (v:getChar()) then
if (v:getChar():getInv():hasItem("momboosy")) 
or (v:getChar():getInv():hasItem("colobok")) 
or (v:getChar():getInv():hasItem("cvetok")) 
or (v:getChar():getInv():hasItem("fireball")) 
or (v:getChar():getInv():hasItem("glas")) 
or (v:getChar():getInv():hasItem("goldfish")) 
or (v:getChar():getInv():hasItem("gravy")) 
or (v:getChar():getInv():hasItem("kristal")) 
or (v:getChar():getInv():hasItem("krovkamna")) 
or (v:getChar():getInv():hasItem("meduza")) 
or (v:getChar():getInv():hasItem("nightstar")) 
or (v:getChar():getInv():hasItem("snefinka")) 
or (v:getChar():getInv():hasItem("pyzir")) 
or (v:getChar():getInv():hasItem("soul")) 
or (v:getChar():getInv():hasItem("vyvert")) 
or (v:getChar():getInv():hasItem("batary")) then
if (v:Health() > 0) then
if (!v.timedmgar or v.timedmgar < CurTime()) then
--v:SetHealth(v:Health() - 3)
v:addRAD(5)
if (v:Health() < 0) then
	v:Kill()
end
v.timedmgar = CurTime() + 3
end	
end
end
end
----
-------------------Чыхание 
if (v:getNetVar("gassound", true) == true and v:Health() > 0) then 
if (!v.timedih or v.timedih < CurTime()) then 
v:EmitSound("hardbass/dobi4iklox_"..math.random(1,6)..".ogg") 
v.timedih = CurTime() + 3 
end 
end 
---------
end
end
end


-----------------------ѕутанты--------------------------------------------
---Лбщее
------------------Хушкан
function Attacktush(ent)
  local self = ent
  local hit = false
  local x = "stand_attack_"..math.random( 0, 2 )
  self:SetSequence( x )
  local all = ents.FindInSphere(self:GetPos() + self:GetForward()*85,55)
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 5

            ////
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageForce(Vector(0,0,0))
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )
          
          end
          ////////////
          if (!v:IsPlayer() and v:GetClass() != "ssk_tush") then
            local di = DamageInfo()
            di:SetDamage( 5 )
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
              self:SetSequence( "stand_run_0" )
            end)
            hit = true
          end
          /////////
        end
      end
    end
  end
  if (hit == false) then
    local seq, dur = self:LookupSequence(x)
    timer.Simple(dur,function ()
      self:SetSequence( "stand_run_0" )
    end)
  end
end
---
function RunBehaviourtush(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 215 )		
			self.loco:SetAcceleration( 215 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 215 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 35 )		
			self.loco:SetAcceleration( 35 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end
end
---------јабан
function Attackboar(ent)
  local self = ent
  local hit = false
  local all = ents.FindInSphere(self:GetPos() + self:GetForward()*75,50)
  local x = "stand_attack_"..math.random( 0, 2 )
  self:SetSequence( x )
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 20

            ////
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )

            
          end
          ////////////
          if (!v:IsPlayer() and (v:GetClass() != "ssk_boar_s" or v:GetClass() != "ssk_boar_m")) then
            local di = DamageInfo()
            di:SetDamage( 25 )
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "stand_run_fwd_0" )
            end)
            hit = true
          end
          /////////
        end
      end
    end
  end
  if (hit == false) then
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
    self:SetSequence( "stand_run_fwd_0" )
    end)
  end
end
---
function RunBehaviourboar(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 150 )		
			self.loco:SetAcceleration( 150 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 150 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 35 )		
			self.loco:SetAcceleration( 35 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end

end
---------Ълоть---
function Attackflash(ent)
  local self = ent
  local hit = false
  local all = ents.FindInSphere(self:GetPos() + self:GetForward()*75,75)
  local x = "stand_attack_"..math.random( 0, 2 )
  self:SetSequence( x )
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 18

            ////
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetDamageForce(Vector(0,0,0))
            di:SetInflictor( self )
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )

            
            self:SetNWFloat("attack", 0)
          end
          ////////////
          if (!v:IsPlayer() and (v:GetClass() != "ssk_flash_m" or v:GetClass() != "ssk_flash_s")) then
            local di = DamageInfo()
            di:SetDamage( 18 )
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )
            self:SetNWFloat("attack", 0)
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "stand_run_0" )
            end)
            hit = true
          end
          /////////
        end
      end
    end
  end
  if (hit == false) then
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
    self:SetSequence( "stand_run_0" )
    end)
  end
end
---
function RunBehaviourflash(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 140 )		
			self.loco:SetAcceleration( 140 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 140 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 50 )		
			self.loco:SetAcceleration( 50 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end
end
-------Ъсы---
function Attackdog(ent)
  local self = ent
  local hit = false
  local all = ents.FindInSphere(self:GetPos() + self:GetForward()*75,50)
  local x = "jump_ataka_01"
  self:SetSequence( x )
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 10

            ////
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )

            
          end
          ////////////
          if (!v:IsPlayer() and v:GetClass() != "ssk_dog") then
            local di = DamageInfo()
            di:SetDamage( 10 )
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "stand_run_0" )
            end)
            hit = true
          end
          /////////
        end
      end
    end
  end
  if (hit == false) then
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
    self:SetSequence( "stand_run_0" )
    end)
  end
end
---
function RunBehaviourdog(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 200 )		
			self.loco:SetAcceleration( 200 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 200 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 40 )		
			self.loco:SetAcceleration( 40 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end
end
-------
----јрово
function Attackkrovo(ent)
local self = ent
local hit = false
local all = ents.FindInSphere(self:GetPos() + self:GetForward()*85,55)
local x = "stand_attack_run_0"
self:SetSequence( x )
self:SetMaterial("")
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 20

            ////
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageForce(Vector(0,0,0))
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )
            self:SetEnemy( nil )
            self:FindEnemy()
            self:HaveEnemy()
          end
          ////////////
          if (!v:IsPlayer() and (v:GetClass() != "ssk_krovo_e" or v:GetClass() != "ssk_krovo_s" or v:GetClass() != "ssk_krovo_m")) then
            local di = DamageInfo()
            di:SetDamage( 5 )
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )
            self:SetEnemy( nil )
            self:FindEnemy()
            
            self:HaveEnemy()
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "run(8)" )
            end)
            hit = true
          end
          /////////
        end
      end
    end
  end
  if (hit == false) then
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
    self:SetSequence( "run(8)" )
    end)
  end
end
---
function Attackkrovo2(ent)
local self = ent
local hit = false
local all = ents.FindInSphere(self:GetPos() + self:GetForward()*85,55)
local x = "vampire"
self:SetSequence( x )
self:SetMaterial("")
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            v:Freeze(true)
            v:SetNetVar("sosatt", true)
            local di = DamageInfo()
            local damga = 30

            ////
            local s, d = self:LookupSequence("vampire")
            local time = CurTime() + d + 10
            self:SetNWFloat("sos", time)
            timer.Simple(d,function ()
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageForce(Vector(0,0,0))
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )
            self:SetEnemy( nil )
            self:FindEnemy()
            
            v:Freeze(false)
            v:SetNetVar("sosatt", false)
            self:HaveEnemy()
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "run(8)" )
            end)
            hit = true
            end)
          end
          ////////////
          /////////
        end
      end
    end
  end
  if (hit == false) then
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
    self:SetSequence( "stand_run_0" )
    end)
  end
end
---
function RunBehaviourkrovo(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 260 )		
			self.loco:SetAcceleration( 260 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 260 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 70 )		
			self.loco:SetAcceleration( 70 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end
end
---------------------------------
-----Фнорк
function Attacksnork(ent)
local self = ent
local hit = false
local all = ents.FindInSphere(self:GetPos() + self:GetForward()*85,55)
local x = "stand_attack_"..math.random(0,1)
self:SetSequence( x)
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 15

            ////
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageForce(Vector(0,0,0))
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )
       
            
            self:SetEnemy( nil )
            self:FindEnemy()
            
            self:HaveEnemy()
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "stand_run_0" )
            end)
            hit = true
          ////////////
          /////////
        end
      end
    end
  end
end
  if (hit == false) then
                local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
    self:SetSequence( "stand_run_0" )
    end)
  end
end
---
function RunBehavioursnork(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 150 )		
			self.loco:SetAcceleration( 150 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 150 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 40 )		
			self.loco:SetAcceleration( 40 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end
end
-----
----?омб
function Attackzombie(ent)
local self = ent
local hit = false
local all = ents.FindInSphere(self:GetPos() + self:GetForward()*85,65)
local x = "stand_attack_"..math.random(0, 3)
self:SetSequence( x)
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 25
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageForce(Vector(0,0,0))
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )

            
            self:SetEnemy( nil )
            self:FindEnemy()
            
            self:HaveEnemy()
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "stand_run_0" )
            end)
            hit = true
          ////////////
          /////////
        end
      end
    end
  end
end
  if (hit == false) then
                local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
    self:SetSequence( "stand_run_0" )
    end)
  end
end

function RunBehaviourzombie(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 60 )		
			self.loco:SetAcceleration( 60 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 60 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 35 )		
			self.loco:SetAcceleration( 35 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end
end
-----
----?злом
function Attackizlom(ent)
local self = ent
local hit = false
local all = ents.FindInSphere(self:GetPos() + self:GetForward()*85,55)
local x = "stand_run_attack_0"
self:SetSequence( x)
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 15

            ////

            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageForce(Vector(0,0,0))
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )

            
            self:SetEnemy( nil )
            self:FindEnemy()
            
            self:HaveEnemy()
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "stand_run_0" )
            end)
            hit = true
          ////////////
          /////////
        end
      end
    end
  end
end
  if (hit == false) then
                local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
    self:SetSequence( "stand_run_0" )
    end)
  end
end
---
function RunBehaviourizlom(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 150 )		
			self.loco:SetAcceleration( 150 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 150 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 55 )		
			self.loco:SetAcceleration( 55 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end

end
-----
----Ґимера
function Attackhimera(ent)
local self = ent
local hit = false
local all = ents.FindInSphere(self:GetPos() + self:GetForward()*85,55)
local x = "jump_attack_0"
self:SetSequence( x)
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 50

            ////
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageForce(Vector(0,0,0))
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )

            
            self:SetEnemy( nil )
            self:FindEnemy()
            
            self:HaveEnemy()
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "stand_run_fwd_0" )
            end)
            hit = true
          ////////////
          /////////
        end
      end
    end
  end
end
  if (hit == false) then
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
    self:SetSequence( "stand_run_fwd_0" )
    end)
  end
end
function RunBehaviourhimera(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 220 )		
			self.loco:SetAcceleration( 220 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 220 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 70 )		
			self.loco:SetAcceleration( 70 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end
end
------
------Ъсевдопес
function Attackpsydog(ent)
local self = ent
local hit = false
local all = ents.FindInSphere(self:GetPos() + self:GetForward()*85,55)
local x = "jump_attack_all"
self:SetSequence( x)
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 20

            ////
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageForce(Vector(0,0,0))
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )

            self:SetEnemy( nil )
            self:FindEnemy()
            
            self:HaveEnemy()
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "run" )
            end)
            hit = true
          ////////////
          /////////
        end
      end
    end
  end
end
  if (hit == false) then
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
      self:SetSequence( "run" )
      end)
  end
end
function RunBehaviourpsydog(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 235 )		
			self.loco:SetAcceleration( 235 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 235 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 60 )		
			self.loco:SetAcceleration( 60 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end

end
-----
----Ъси-Ъес
function RunBehaviourpsydog2(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 235 )		
			self.loco:SetAcceleration( 235 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 235 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 60 )		
			self.loco:SetAcceleration( 60 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end

end
----Їигант
function Attackgiant(ent)
local self = ent
local hit = false
local all = ents.FindInSphere(self:GetPos() + self:GetForward()*105,55)
local x = "stand_attack_"..math.random(0,2)
self:SetSequence( x)
  if all != nil then
    for k,v in pairs(all) do
      if (v != self) then
        if (v:Health() > 0) then
          if (v:IsPlayer()) then
            ////
            local di = DamageInfo()
            local damga = 50

            ////
            di:SetDamage(damga)
            di:SetAttacker( self )
            di:SetInflictor( self )
            di:SetDamageForce(Vector(0,0,0))
            di:SetDamageType( DMG_SLASH )
            v:TakeDamageInfo( di )

            
            self:SetEnemy( nil )
            self:FindEnemy()
            
            self:HaveEnemy()
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
            self:SetSequence( "stand_walk_fwd_0" )
            end)
            hit = true
          ////////////
          /////////
        end
      end
    end
  end
end
  if (hit == false) then
            local seq, dur = self:LookupSequence(x)
            timer.Simple(dur,function ()
    self:SetSequence( "stand_walk_fwd_0" )
    end)
  end
end
---
function Attackgiant2(ent)
            local self = ent
            self:EmitSound("mutants/ssk/giant/giant_attack_"..math.random(0, 1)..".mp3")
            timer.Simple(0.001, function()
              local sequence = "stand_kick_0"
              local seq, dur = self:LookupSequence(sequence)
              self:PlaySequenceAndWait( "stand_kick_0")
              timer.Simple(dur/2.5,function ()
                self:EmitSound("mutants/ssk/giant/giant_hit.mp3")
                local pos = self:GetPos()
                local effectdata = EffectData()
                effectdata:SetStart( self:GetPos() + Vector( 0, 0, 0 )) 
                effectdata:SetOrigin( self:GetPos() + Vector( 0, 0, 0 ))
                effectdata:SetScale( 690 )
                effectdata:SetRadius( 0.3 )
                effectdata:SetMagnitude( 0.3 )
                util.Effect( "ThumperDust", effectdata ) 
                //
                for k, v in pairs( ents.FindInSphere( self:GetPos(), 400 ) ) do 
                  if (v != self) then
                    if (v:IsNPC()) then
                      v:TakeDamage(math.random(25, 35))
                    end
                    if (v:IsPlayer()) then
                      v:TakeDamage(math.random(25, 35))
                      v:ViewPunch( Angle( math.random(-200,200), math.random(-200,200), math.random(-200,200)) )
                      --v.character:SetVar("stamina", v.character:GetVar("stamina", 0) - 50)
                      --v:ScreenFadeOut(0.5, Color(255, 0, 0))
                    end
                  end
                  //
                  if (string.find( v:GetClass(), "prop" )) then
                    //
                    if (!v:IsRagdoll()) then
                      local dir = ( self:GetForward() ):GetNormal()
                      local force = 295
                      local distance = dir:Length()
                      local maxdistance = 200
                      local ratio = math.Clamp( (1 - (distance/maxdistance)), 0, 1 )
                      local vForce = -1*dir * (force * ratio)
                      local phys = v:GetPhysicsObject()
                      phys:ApplyForceCenter( dir * phys:GetMass() * 1550 )
                    else
                      local dir = ( self:GetForward() ):GetNormal()
                      local force = 5000
                      local distance = dir:Length()
                      local maxdistance = 500
                      local ratio = math.Clamp( (1 - (distance/maxdistance)), 0, 1 )
                      local vForce = -1*dir * (force * ratio)
                      local phys = v:GetPhysicsObject()
                      phys:ApplyForceCenter(dir*phys:GetMass()+v:GetUp()*math.random(5,15) * 5000)
                      //
                      timer.Simple(.1,function ()
                      phys:ApplyForceCenter( dir * phys:GetMass() * 2000)
                        end)
                      //
                      end
                      //
                    end
                    //
                 end
                 //
              end)
          end)

end
function RunBehaviourgiant(ent)
  local self = ent
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )	
			self:StartActivity( ACT_RUN )		
			self.loco:SetDesiredSpeed( 150 )		
			self.loco:SetAcceleration( 150 )		
			self:ChaseEnemy() 					
			self.pove = "agre"	
			self.loco:SetAcceleration( 150 )			
			self:StartActivity( ACT_IDLE )	
		else
			self:StartActivity( ACT_WALK )
			self.loco:SetDesiredSpeed( 95 )		
			self.loco:SetAcceleration( 95 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:StartActivity( ACT_IDLE )
			self.pove = "idle"
		end
		coroutine.wait( 2 )
	end

end
-----

