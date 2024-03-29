
function GM:PlayerInitialSpawn(client)
	client.nutJoinTime = RealTime()
	
	if (client:IsBot()) then
		local botID = os.time()
		local index = math.random(1, table.Count(nut.faction.indices))
		local faction = nut.faction.indices[index]

		local character = nut.char.new({
			name = client:Name(),
			faction = faction and faction.uniqueID or "unknown",
			model = faction and table.Random(faction.models) or "models/gman.mdl"
		}, botID, client, client:SteamID64())
		character.isBot = true

		local inventory = nut.item.createInv(nut.config.get("invW"), nut.config.get("invH"), botID)
		inventory:setOwner(botID)
		inventory.noSave = true

		character.vars.inv = {inventory}

		nut.char.loaded[os.time()] = character

		character:setup()
		client:Spawn()

		return
	end

	nut.config.send(client)
	nut.date.send(client)
	
	client:loadNutData(function(data)
		if (!IsValid(client)) then return end

		local address = nut.util.getAddress()			
		local noCache = client:getNutData("lastIP", address) != address
		client:setNutData("lastIP", address)

		netstream.Start(client, "nutDataSync", data, client.nutPlayTime)

		nut.char.restore(client, function(charList)
			if (!IsValid(client)) then return end

			MsgN("Loaded ("..table.concat(charList, ", ")..") for "..client:Name())

			for k, v in ipairs(charList) do
				nut.char.loaded[v]:sync(client)
			end

			for k, v in ipairs(player.GetAll()) do
				if (v:getChar()) then
					v:getChar():sync(client)
				end
			end

			client.nutCharList = charList
				netstream.Start(client, "charMenu", charList)
			client.nutLoaded = true

			client:setNutData("intro", true)
		end, noCache)
	end)

	client:SetNoDraw(true)
	client:SetNotSolid(true)
	client:Lock()

	timer.Simple(1, function()
		if (!IsValid(client)) then return end
		
		client:KillSilent()
		client:StripAmmo()
	end)
end

function GM:PlayerUse(client, entity)
	if (client:getNetVar("restricted")) then
		return false
	end

	if (entity:isDoor()) then
		local result = hook.Run("CanPlayerUseDoor", client, entity)

		if (result == false) then
			return false
		else
			hook.Run("PlayerUseDoor", client, entity)
		end
	end

	return true
end

function GM:KeyPress(client, key)
	if (key == IN_RELOAD) then
		timer.Create("nutToggleRaise"..client:SteamID(), 1, 1, function()
			if (IsValid(client)) then
				client:toggleWepRaised()
			end
		end)
	elseif (key == IN_USE) then
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local entity = util.TraceLine(data).Entity

		if (IsValid(entity) and entity:isDoor() or entity:IsPlayer()) then
			hook.Run("PlayerUse", client, entity)
		end
	end
end

function GM:KeyRelease(client, key)
	if (key == IN_RELOAD) then
		timer.Remove("nutToggleRaise"..client:SteamID())
	end
end

function GM:CanPlayerInteractItem(client, action, item)
	if (client:getNetVar("restricted")) then
		return false
	end

	if (action == "drop" and hook.Run("CanPlayerDropItem", client, item) == false) then
		return false
	end

	if (action == "take" and hook.Run("CanPlayerTakeItem", client, item) == false) then
		return false
	end

	return client:Alive()
end

function GM:CanPlayerTakeItem(client, item)
	if (type(item) == "Entity") then
		local char = client:getChar()
		
		if (item.nutSteamID and item.nutSteamID == client:SteamID() and item.nutCharID != char:getID()) then
			client:notifyLocalized("playerCharBelonging")

			return false
		end
	end
end

function GM:PlayerSwitchWeapon(client, oldWeapon, newWeapon)
	client:setWepRaised(false)
end

function GM:PlayerShouldTakeDamage(client, attacker)
	return client:getChar() != nil
end

function GM:GetFallDamage(client, speed)
	return (speed - 580) * (100 / 444)
end

function GM:EntityTakeDamage(entity, dmgInfo)
	if (IsValid(entity.nutPlayer)) then
		if (dmgInfo:IsDamageType(DMG_CRUSH)) then
			if ((entity.nutFallGrace or 0) < CurTime()) then
				if (dmgInfo:GetDamage() <= 10) then
					dmgInfo:SetDamage(0)
				end

				entity.nutFallGrace = CurTime() + 0.5
			else
				return
			end
		end

		entity.nutPlayer:TakeDamageInfo(dmgInfo)
	end
end

function GM:PrePlayerLoadedChar(client, character, lastChar)
	-- Remove all skins
	client:SetBodyGroups("000000000")
	client:SetSkin(0)
	client:ConCommand("say /zcharconnect , добро пожаловать в «Единую Сталкерскую Сеть»")
end

function GM:PlayerLoadedChar(client, character, lastChar)
	if (lastChar) then
		local charEnts = lastChar:getVar("charEnts") or {}

		for k, v in ipairs(charEnts) do
			if (v and IsValid(v)) then
				v:Remove()
			end
		end

		lastChar:setVar("charEnts", nil) 
	end

	if (character) then
		for k, v in pairs(nut.class.list) do
			if (v.faction == client:Team()) then
				if (v.isDefault) then
					character:setClass(v.index)

					break
				end
			end
		end
	end

	if (IsValid(client.nutRagdoll)) then
		client.nutRagdoll.nutNoReset = true
		client.nutRagdoll.nutIgnoreDelete = true
		client.nutRagdoll:Remove()
	end

	local faction = nut.faction.indices[character:getFaction()]

	if (faction and faction.pay and faction.pay > 0) then
		timer.Create("nutSalary"..client:UniqueID(), faction.payTime or 300, 0, function()
			local pay = hook.Run("GetSalaryAmount", client, faction) or faction.pay

			character:giveMoney(pay)
			client:notifyLocalized("salary", nut.currency.get(pay))
		end)
	end


	hook.Run("PlayerLoadout", client)
end

function GM:CharacterLoaded(id)
	local character = nut.char.loaded[id]

	if (character) then
		local client = character:getPlayer()

		if (IsValid(client)) then
			local uniqueID = "nutSaveChar"..client:SteamID()

			timer.Create(uniqueID, nut.config.get("saveInterval"), 0, function()
				if (IsValid(client) and client:getChar()) then
					client:getChar():save()
				else
					timer.Remove(uniqueID)
				end
			end)
		end
	end
end

function GM:PlayerSay(client, message)
	local chatType, message, anonymous = nut.chat.parse(client, message, true)

	if (chatType == "ic") then
		if (nut.command.parse(client, message)) then
			return ""
		end
	end

	nut.chat.send(client, chatType, message, anonymous)
	nut.log.add(client, "chat", chatType and chatType:upper() or "??", message)
	--nut.log.add(client:Name().." said ["..chatType:upper().."] \""..message.."\"")

	hook.Run("PostPlayerSay", client, message, chatType, anonymous)

	return ""
end

function GM:PlayerSpawn(client)
	client:SetNoDraw(false)
	client:UnLock()
	client:SetNotSolid(false)
	client:setAction()

	hook.Run("PlayerLoadout", client)
end

-- Shortcuts for (super)admin only things.
local IsAdmin = function(_, client) return client:IsAdmin() end

-- Set the gamemode hooks to the appropriate shortcuts.
GM.PlayerGiveSWEP = IsAdmin
GM.PlayerSpawnEffect = IsAdmin
GM.PlayerSpawnSENT = IsAdmin

function GM:PlayerSpawnNPC(client, npcType, weapon)
	return client:IsAdmin() or client:getChar():hasFlags("n")
end

function GM:PlayerSpawnSWEP(client, weapon, info)
	return client:IsAdmin()
end

function GM:PlayerSpawnProp(client)
	if (client:getChar() and client:getChar():hasFlags("e")) then
		return true
	end

	return false
end

function GM:PlayerSpawnVehicle(client, model, name, data)
	if (client:getChar()) then
		if (data.Category == "Chairs") then
			return client:getChar():hasFlags("c")
		else
			return client:getChar():hasFlags("C")
		end
	end
	
	return false
end

-- Called when weapons should be given to a player.
function GM:PlayerLoadout(client)
	if (client.nutSkipLoadout) then
		client.nutSkipLoadout = nil

		return
	end
	
	client:SetWeaponColor(Vector(client:GetInfo("cl_weaponcolor")))
	client:StripWeapons()
	client:setLocalVar("blur", nil)

	local character = client:getChar()

	-- Check if they have loaded a character.
	if (character) then
		client:SetupHands()
		-- Set their player model to the character's model.
		client:SetModel(character:getModel())
		--client:Give("ssk_knife")
		client:SetWalkSpeed(nut.config.get("walkSpeed"))
		client:SetRunSpeed(nut.config.get("runSpeed"))
		
		local faction = nut.faction.indices[client:Team()]

		if (faction) then
			-- If their faction wants to do something when the player spawns, let it.
			if (faction.onSpawn) then
				faction:onSpawn(client)
			end

			-- If the faction has default weapons, give them to the player.
			if (faction.weapons) then
				for k, v in ipairs(faction.weapons) do
					client:Give(v)
				end
			end
		end

		-- Ditto, but for classes.
		local class = nut.class.list[client:getChar():getClass()]

		if (class) then
			if (class.onSpawn) then
				class:onSpawn(client)
			end

			if (class.weapons) then
				for k, v in ipairs(class.weapons) do
					client:Give(v)
				end
			end
		end

		-- Apply any flags as needed.
		nut.flag.onSpawn(client)
		nut.attribs.setup(client)

		hook.Run("PostPlayerLoadout", client)

		client:SelectWeapon("nut_keys")
	else
		client:SetNoDraw(true)
		client:Lock()
		client:SetNotSolid(true)
	end
end

function GM:PostPlayerLoadout(client)
	-- Reload All Attrib Boosts
	local char = client:getChar()

	if (char:getInv()) then
		for k, v in pairs(char:getInv():getItems()) do
			v:call("onLoadout", client)

			if (v:getData("equip")) then
				if (v.attribBoosts) then
					for k, v in pairs(v.attribBoosts) do
						char:addBoost(v.uniqueID, k, v)
					end
				end
			end
		end
	end
end

local deathSounds = {
	Sound("vo/npc/male01/pain07.wav"),
	Sound("vo/npc/male01/pain08.wav"),
	Sound("vo/npc/male01/pain09.wav")
}

function GM:PlayerDeath(client, inflictor, attacker)
	if (client:getChar()) then
		if (IsValid(client.nutRagdoll)) then
			client.nutRagdoll.nutIgnoreDelete = true
			client.nutRagdoll:Remove()
			client:setLocalVar("blur", nil)
		end

		client:setNetVar("deathStartTime", CurTime())
		client:setNetVar("deathTime", CurTime() + nut.config.get("spawnTime", 5))

		local deathSound = hook.Run("GetPlayerDeathSound", client) or table.Random(deathSounds)

		if (client:isFemale() and !deathSound:find("female")) then
			deathSound = deathSound:gsub("male", "female")
		end

		client:EmitSound(deathSound)
-----------------------------это в nutscript/gamemode/core/hooks/sv_hooks.lua
	--[[	if (client:Team() == FACTION_LONER and attacker:Team() == FACTION_LONER) then
			--local faction = nut.faction.teams["Ренегаты"]
			--faction:onTransfered(attacker)
			attacker:getChar():setFaction(FACTION_FREEDOM)
			attacker:getChar().vars.faction = freedom -- тут как файл фраки называется sh_renegat.lua без sh_
			attacker:SetModel("models/spenser/ssk/new_renegat_01_spen.mdl")
		end]]
---------------------------
	end
end

function GM:PlayerDeathThink(client) 
if (client:getChar()) then 
local deathTime = client:getNetVar("deathTime") 

if (deathTime and deathTime <= CurTime()) then 
local trup = ents.Create("prop_ragdoll") 
trup:SetPos(client:GetPos() ) 
trup:SetModel("models/stalkertnb/zombie_mutant.mdl") 
trup:Spawn() 
timer.Simple(5, function() 
if (IsValid(trup)) then 
nut.item.spawn("bint", trup:GetPos()) 
local bone2 = ents.Create("prop_physics") 
if (math.random(1, 10) < 9) then 
local bone1 = ents.Create("prop_physics") 
bone1:SetPos(trup:GetPos()) 
bone1:SetModel("models/hardbass/skelet_crash_polt1.mdl") 
bone1:Spawn() 
bone1:Activate() 
timer.Simple(3, function () 
bone1:Remove() 
end) 
end 
if (math.random(1, 10) < 9) then 
local bone2 = ents.Create("prop_physics") 
bone2:SetPos(trup:GetPos()) 
bone2:SetModel("models/hardbass/skelet_crash_polt10.mdl") 
bone2:Spawn() 
bone2:Activate() 
timer.Simple(3, function () 
bone2:Remove() 
end) 
end 
if (math.random(1, 10) < 9) then 
local bone3 = ents.Create("prop_physics") 
bone3:SetPos(trup:GetPos()) 
bone3:SetModel("models/hardbass/skelet_crash_polt9.mdl") 
bone3:Spawn() 
bone3:Activate() 
timer.Simple(3, function () 
bone3:Remove() 
end) 
end 
if (math.random(1, 10) < 9) then 
local bone4 = ents.Create("prop_physics") 
bone4:SetPos(trup:GetPos()) 
bone4:SetModel("models/hardbass/skelet_crash_polt11.mdl") 
bone4:Spawn() 
bone4:Activate() 
timer.Simple(3, function () 
bone4:Remove() 
end) 
end 
if (math.random(1, 10) < 9) then 
local bone5 = ents.Create("prop_physics") 
bone5:SetPos(trup:GetPos()) 
bone5:SetModel("models/hardbass/skelet_crash_polt12.mdl") 
bone5:Spawn() 
bone5:Activate() 
timer.Simple(3, function () 
bone5:Remove() 
end) 
end 
if (math.random(1, 10) < 9) then 
local bone6 = ents.Create("prop_physics") 
bone6:SetPos(trup:GetPos()) 
bone6:SetModel("models/hardbass/skelet_crash_polt13.mdl") 
bone6:Spawn() 
bone6:Activate() 
timer.Simple(3, function () 
bone6:Remove() 
end) 
end 
if (math.random(1, 10) < 8) then 
local bone7 = ents.Create("prop_physics") 
bone7:SetPos(trup:GetPos()) 
bone7:SetModel("models/hardbass/skelet_crash_polt14.mdl") 
bone7:Spawn() 
bone7:Activate() 
timer.Simple(3, function () 
bone7:Remove() 
end) 
end 
if (math.random(1, 10) < 8) then 
local bone8 = ents.Create("prop_physics") 
bone8:SetPos(trup:GetPos()) 
bone8:SetModel("models/hardbass/skelet_crash_polt15.mdl") 
bone8:Spawn() 
bone8:Activate() 
timer.Simple(3, function () 
bone8:Remove() 
end) 
end 
if (math.random(1, 10) < 8) then 
local bone9 = ents.Create("prop_physics") 
bone9:SetPos(trup:GetPos()) 
bone9:SetModel("models/hardbass/skelet_crash_polt2.mdl") 
bone9:Spawn() 
bone9:Activate() 
timer.Simple(3, function () 
bone9:Remove() 
end) 
end 
if (math.random(1, 10) < 8) then 
local bone10 = ents.Create("prop_physics") 
bone10:SetPos(trup:GetPos()) 
bone10:SetModel("models/hardbass/skelet_crash_polt3.mdl") 
bone10:Spawn() 
bone10:Activate() 
timer.Simple(3, function () 
bone10:Remove() 
end) 
end 
if (math.random(1, 10) < 8) then 
local bone11 = ents.Create("prop_physics") 
bone11:SetPos(trup:GetPos()) 
bone11:SetModel("models/hardbass/skelet_crash_polt4.mdl") 
bone11:Spawn() 
bone11:Activate() 
timer.Simple(3, function () 
bone11:Remove() 
end) 
end 
if (math.random(1, 10) < 8) then 
local bone12 = ents.Create("prop_physics") 
bone12:SetPos(trup:GetPos()) 
bone12:SetModel("models/hardbass/skelet_crash_polt5.mdl") 
bone12:Spawn() 
bone12:Activate() 
timer.Simple(3, function () 
bone12:Remove() 
end) 
end 
if (math.random(1, 10) < 8) then 
local bone13 = ents.Create("prop_physics") 
bone13:SetPos(trup:GetPos()) 
bone13:SetModel("models/hardbass/skelet_crash_polt6.mdl") 
bone13:Spawn() 
bone13:Activate() 
timer.Simple(3, function () 
bone13:Remove() 
end) 
end 
if (math.random(1, 10) < 8) then 
local bone14 = ents.Create("prop_physics") 
bone14:SetPos(trup:GetPos()) 
bone14:SetModel("models/hardbass/skelet_crash_polt7.mdl") 
bone14:Spawn() 
bone14:Activate() 
timer.Simple(3, function () 
bone14:Remove() 
end) 
end 
if (math.random(1, 10) < 8) then 
local bone15 = ents.Create("prop_physics") 
bone15:SetPos(trup:GetPos()) 
bone15:SetModel("models/hardbass/skelet_crash_polt8.mdl") 
bone15:Spawn() 
bone15:Activate() 
timer.Simple(3, function () 
bone15:Remove() 
end) 
end 
trup:Remove() 
end 
end) 
client:Spawn() 
end 
end 
return false 
end

local painSounds = {
	Sound("vo/npc/male01/pain01.wav"),
	Sound("vo/npc/male01/pain02.wav"),
	Sound("vo/npc/male01/pain03.wav"),
	Sound("vo/npc/male01/pain04.wav"),
	Sound("vo/npc/male01/pain05.wav"),
	Sound("vo/npc/male01/pain06.wav")
}

local drownSounds = {
	Sound("player/pl_drown1.wav"),
	Sound("player/pl_drown2.wav"),
	Sound("player/pl_drown3.wav"),
}

function GM:GetPlayerPainSound(client)
	if (client:WaterLevel() >= 3) then
		return table.Random(drownSounds)
	end
end

function GM:PlayerHurt(client, attacker, health, damage)
	if ((client.nutNextPain or 0) < CurTime()) then
		local painSound = hook.Run("GetPlayerPainSound", client) or table.Random(painSounds)

		if (client:isFemale() and !painSound:find("female")) then
			painSound = painSound:gsub("male", "female")
		end

		client:EmitSound(painSound)
		client.nutNextPain = CurTime() + 0.33
	end
end

--[[function GM:PlayerDeathThink(client)
	if (client:getChar()) then
		local deathTime = client:getNetVar("deathTime")

		if (deathTime and deathTime <= CurTime()) then
			client:Spawn()
		end
	end

	return false
end]]

function GM:PlayerDisconnected(client)
	client:saveNutData()

	local character = client:getChar()

	if (character) then
		local charEnts = character:getVar("charEnts") or {}

		for k, v in ipairs(charEnts) do
			if (v and IsValid(v)) then
				v:Remove()
			end
		end

		hook.Run("OnCharDisconnect", client, character)
		character:save()
	end
end

function GM:InitPostEntity()
	local doors = ents.FindByClass("prop_door_rotating")

	for k, v in ipairs(doors) do
		local parent = v:GetOwner()

		if (IsValid(parent)) then
			v.nutPartner = parent
			parent.nutPartner = v
		else
			for k2, v2 in ipairs(doors) do
				if (v2:GetOwner() == v) then
					v2.nutPartner = v
					v.nutPartner = v2

					break
				end
			end
		end
	end

	timer.Simple(0.1, function()
		hook.Run("LoadData")
	end)

	timer.Simple(2, function()
		nut.entityDataLoaded = true
	end)
end

function GM:ShutDown()
	nut.shuttingDown = true
	nut.config.save()

	hook.Run("SaveData")

	for k, v in ipairs(player.GetAll()) do
		v:saveNutData()

		if (v:getChar()) then
			v:getChar():save()
		end
	end
end

LIMB_GROUPS = {}
LIMB_GROUPS[HITGROUP_LEFTARM] = true
LIMB_GROUPS[HITGROUP_RIGHTARM] = true
LIMB_GROUPS[HITGROUP_LEFTLEG] = true
LIMB_GROUPS[HITGROUP_RIGHTLEG] = true
LIMB_GROUPS[HITGROUP_GEAR] = true

function GM:ScalePlayerDamage(client, hitGroup, dmgInfo)
	dmgInfo:ScaleDamage(1.5)

	if (hitGroup == HITGROUP_HEAD) then
		dmgInfo:ScaleDamage(7)
	elseif (LIMB_GROUPS[hitGroup]) then
		dmgInfo:ScaleDamage(0.5)
	end
end

function GM:GetGameDescription()
	return "NS - "..(SCHEMA and SCHEMA.name or "Unknown")
end

function GM:OnPlayerUseBusiness(client, item)
	-- You can manipulate purchased items with this hook.
	-- does not requires any kind of return.
	-- ex) item:setData("businessItem", true)
	-- then every purchased item will be marked as Business Item.
end

function GM:PlayerDeathSound()
	return true
end

function GM:InitializedSchema()
	if (!nut.data.get("date", nil, false, true)) then
		nut.data.set("date", os.time(), false, true)
	end

	nut.date.start = nut.data.get("date", os.time(), false, true)

	game.ConsoleCommand("sbox_persist ns_"..SCHEMA.folder.."\n")
end

function GM:PlayerCanHearPlayersVoice(listener, speaker)
	local allowVoice = nut.config.get("allowVoice")
	if allowVoice then
		local listener_pos = listener:GetPos()
		local speaker_pos = speaker:GetPos()
		local voice_dis = math.Distance(speaker_pos.x, speaker_pos.y, listener_pos.x, listener_pos.y)
		if voice_dis > nut.config.get("voiceDistance") then
			allowVoice = false
		end
	end
	return allowVoice
end

function GM:OnPhysgunFreeze(weapon, physObj, entity, client)
	-- Object is already frozen (!?)
	if (!physObj:IsMoveable()) then return false end
	if (entity:GetUnFreezable()) then return false end

	physObj:EnableMotion(false)

	-- With the jeep we need to pause all of its physics objects
	-- to stop it spazzing out and killing the server.
	if (entity:GetClass() == "prop_vehicle_jeep") then
		local objects = ent:GetPhysicsObjectCount()

		for i = 0, objects - 1 do
			entity:GetPhysicsObjectNum(i):EnableMotion(false)
		end
	end

	-- Add it to the player's frozen props
	client:AddFrozenPhysicsObject(entity, physObj)
	client:SendHint("PhysgunUnfreeze", 0.3)
	client:SuppressHint("PhysgunFreeze")

	return true
end

function GM:CanPlayerSuicide(client)
	return false
end

function GM:AllowPlayerPickup(client, entity)
	return false
end

function GM:PreCleanupMap()
	hook.Run("SaveData")
	hook.Run("PersistenceSave")
end

function GM:PostCleanupMap()
	hook.Run("LoadData")
	hook.Run("PostLoadData")
end

function GM:CharacterPreSave(character)
	local client = character:getPlayer()

	for k, v in pairs(character:getInv():getItems()) do
		if (v.onSave) then
			v:call("onSave", client)
		end
	end
end

timer.Create("nutLifeGuard", 1, 0, function()
	for k, v in ipairs(player.GetAll()) do
		if (v:getChar() and v:Alive() and hook.Run("ShouldPlayerDrowned", v) != false) then
			if (v:WaterLevel() >= 3) then
				if (!v.drowningTime) then
					v.drowningTime = CurTime() + 30
					v.nextDrowning = CurTime()
					v.drownDamage = v.drownDamage or 0
				end

				if (v.drowningTime < CurTime()) then
					if (v.nextDrowning < CurTime()) then
						v:ScreenFade(1, Color(0, 0, 255, 100), 1, 0)
						v:TakeDamage(10)
						v.drownDamage = v.drownDamage + 10
						v.nextDrowning = CurTime() + 1
					end
				end
			else
				if (v.drowningTime) then
					v.drowningTime = nil
					v.nextDrowning = nil
					v.nextRecover = CurTime() + 2
				end

				if (v.nextRecover and v.nextRecover < CurTime() and v.drownDamage > 0) then
					v.drownDamage = v.drownDamage - 10
					v:SetHealth(math.Clamp(v:Health() + 10, 0, v:GetMaxHealth()))
					v.nextRecover = CurTime() + 1
				end
			end
		end
	end
end)

netstream.Hook("strReq", function(client, time, text)
	if (client.nutStrReqs and client.nutStrReqs[time]) then
		client.nutStrReqs[time](text)
		client.nutStrReqs[time] = nil
	end
end)
