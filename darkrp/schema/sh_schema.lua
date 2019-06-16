SCHEMA.name = "DarkRP"
SCHEMA.author = "Kek1ch"
SCHEMA.desc = "DarkRP"
SCHEMA.IncludeFilesTable = {"sh_config.lua"} 

function SCHEMA:isCombineFaction(faction)
	return faction == FACTION_RAIDERS or faction == FACTION_LONER or faction == FACTION_MILITARY or faction == FACTION_DUTY or faction == FACTION_FREEDOM or faction == FACTION_CLEARSKY or faction == FACTION_MERCENARIES or faction == FACTION_SCIENTISTS or faction == FACTION_LASTDAY or faction == FACTION_MONOLIT or faction == FACTION_MERCHANTS
end

nut.command.add("getpos", {
	onRun = function(client, arguments)
		client:ChatPrint(tostring(client:GetPos()))
	end
})

do
	local playerMeta = FindMetaTable("Player")

	function playerMeta:isCombine()
		return SCHEMA:isCombineFaction(self:Team())
	end

	function playerMeta:getCombineRank()
		local name = self:Name()

		for k, v in ipairs(SCHEMA.scnRanks) do
			local rank = string.PatternSafe(v)

			if (name:find("[%D+]"..rank.."[%D+]")) then
				return
			end
		end

		for k, v in ipairs(SCHEMA.rctRanks) do
			local rank = string.PatternSafe(v)

			if (name:find("[%D+]"..rank.."[%D+]")) then
				return v
			end
		end

		for k, v in ipairs(SCHEMA.unitRanks) do
			local rank = string.PatternSafe(v)

			if (name:find("[%D+]"..rank.."[%D+]")) then
				return v
			end
		end

		for k, v in ipairs(SCHEMA.eliteRanks) do
			local rank = string.PatternSafe(v)

			if (name:find("[%D+]"..rank.."[%D+]")) then
				return v
			end
		end
	end

	function playerMeta:isCombineRank(rank)
		if (type(rank) == "table") then
			local name = self:Name()

			for k, v in ipairs(rank) do
				local rank = string.PatternSafe(v)

				--[[if (name:find("[%D+]"..rank.."[%D+]")) then
					return v
				end]]		
			end

			return false
		else
			return self:getCombineRank() == rank
		end
	end

	function SCHEMA:isDispatch(client)
		return client:isCombineRank(self.eliteRanks) or client:isCombineRank(self.scnRanks)
	end

	function playerMeta:getDigits()
		if (self:isCombine()) then
			local name = self:Name():reverse()
			local digits = name:match("(%d+)")

			if (digits) then
				return tostring(digits):reverse()
			end
		end

		return "UNKNOWN"
	end

	if (SERVER) then
		function playerMeta:addDisplay(text, color)
			if (self:isCombine()) then
				netstream.Start(self, "cDisp", text, color)
			end
		end
	end
end

nut.util.include("sh_config.lua")
nut.util.include("sh_commands.lua")
nut.util.includeDir("hooks")

if (SERVER) then
	SCHEMA.objectives = SCHEMA.objectives or ""
	
	concommand.Add("nut_setupnexusdoors", function(client, command, arguments)
		if (!IsValid(client)) then
			if (!nut.plugin.list.doors) then
				return MsgN("[NutScript] Door plugin is missing!")
			end

			local name = table.concat(arguments, " ")

			for _, entity in ipairs(ents.FindByClass("func_door")) do
				if (!entity:HasSpawnFlags(256) and !entity:HasSpawnFlags(1024)) then
					entity:setNetVar("noSell", true)
					entity:setNetVar("name", !name:find("%S") and "Nexus" or name)
				end
			end

			nut.plugin.list.doors:SaveDoorData()

			MsgN("[NutScript] Nexus doors have been set up.")
		end
	end)
end

for k, v in pairs(SCHEMA.beepSounds) do
	for k2, v2 in ipairs(v.on) do
		util.PrecacheSound(v2)
	end

	for k2, v2 in ipairs(v.off) do
		util.PrecacheSound(v2)
	end
end

for k, v in pairs(SCHEMA.deathSounds) do
	for k2, v2 in ipairs(v) do
		util.PrecacheSound(v2)
	end
end

for k, v in pairs(SCHEMA.painSounds) do
	for k2, v2 in ipairs(v) do
		util.PrecacheSound(v2)
	end
end

for k, v in pairs(SCHEMA.rankModels) do
	nut.anim.setModelClass(v, "metrocop")
	player_manager.AddValidModel("combine", v)

	util.PrecacheModel(v)
end

nut.util.include("sh_voices.lua")

if (SERVER) then
	function SCHEMA:saveObjectives()
		nut.data.set("objectives", self.objectives, false, true)
	end

	function SCHEMA:saveVendingMachines()
		local data = {}

		for k, v in ipairs(ents.FindByClass("nut_vendingm")) do
			data[#data + 1] = {v:GetPos(), v:GetAngles(), v:getNetVar("stocks"), v:getNetVar("active")}
		end

		nut.data.set("vendingm", data)
	end

	function SCHEMA:saveDispensers()
		local data = {}

		for k, v in ipairs(ents.FindByClass("nut_dispenser")) do
			data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetDisabled() == true and true or nil}
		end

		nut.data.set("dispensers", data)
	end

	function SCHEMA:loadObjectives()
		self.objectives = nut.data.get("objectives", "", false, true)
	end

	function SCHEMA:loadVendingMachines()
		local data = nut.data.get("vendingm") or {}

		for k, v in ipairs(data) do
			local entity = ents.Create("nut_vendingm")
			entity:SetPos(v[1])
			entity:SetAngles(v[2])
			entity:Spawn()
			entity:setNetVar("stocks", v[3] or {})
			entity:setNetVar("active", v[4])
		end
	end

	function SCHEMA:loadDispensers()
		for k, v in ipairs(nut.data.get("dispensers") or {}) do
			local entity = ents.Create("nut_dispenser")
			entity:SetPos(v[1])
			entity:SetAngles(v[2])
			entity:Spawn()

			if (v[3]) then
				entity:SetDisabled(true)
			end
		end
	end
end

nut.chat.register("dispatch", {
	color = Color(192, 57, 43),
	onCanSay = function(client)
		if (!SCHEMA:isDispatch(client)) then
			client:notifyLocalized("notAllowed")

			return false
		end
	end,
	onChatAdd = function(speaker, text)
		chat.AddText(Color(192, 57, 43), L("icFormat", "Dispatch", text))
	end,
	prefix = {"/dispatch"}
})

--[[function SCHEMA:CanPlayerUseBusiness(client, uniqueID)
	if (client:IsAdmin()) then
		return true
	end
	return false
end]]

nut.chat.register("request", {
	color = Color(210, 77, 87),
	onChatAdd = function(speaker, text)
		chat.AddText(Color(210, 77, 87), text)
	end,
	onCanHear = function(speaker, listener)
		return listener:isCombine()
	end
})

nut.flag.add("y", "Access to the light blackmarket items.")
nut.flag.add("Y", "Access to the heavy blackmarket items.")
nut.flag.add("F", "Access to the heavy blackmarket items.")
nut.flag.add("M", "Access to the heavy blackmarket items.")

nut.currency.set("", "RU", "RU")