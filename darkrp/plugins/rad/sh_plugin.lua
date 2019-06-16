local PLUGIN = PLUGIN
PLUGIN.name = "radioactive"
PLUGIN.author = "Spenser & Kek1ch"
PLUGIN.desc = "radioactive System"

local playerMeta = FindMetaTable("Player")
local entityMeta = FindMetaTable("Entity")
--[[if (CLIENT) then
	nut.bar.add(function()
		return LocalPlayer():getNetVar("radioactive", 0) / 100
	end, Color(18, 243, 216), nil, "radioactive")	
end]]
function playerMeta:getRAD()
	return (self:getNetVar("radioactive")) or 0
end

function playerMeta:getRADPercent()
	return math.Clamp(self:getRAD()/100, 0 ,1)
end

function playerMeta:addRAD(amount)
	local curRAD = self:getRAD()

	self:setNetVar("radioactive", math.Clamp(math.min(curRAD) + amount, 0, 100))
end

function playerMeta:setRAD(amount)
	
	self:setNetVar("radioactive", math.Clamp(amount, 0, 100))
end

if (CLIENT) then
else
	local PLUGIN = PLUGIN
	
	function PLUGIN:CharacterPreSave(character)
		local savedRAD = math.Clamp(character.player:getRAD(), 0, 100)
		character:setData("radioactive", savedRAD)
	end

	function PLUGIN:PlayerLoadedChar(client, character, lastChar)
		if (character:getData("radioactive")) then
			client:setNetVar("radioactive", character:getData("radioactive"))
		else
			client:setNetVar("radioactive", 0)
		end
	end

	function PLUGIN:PlayerDeath(client)
		client.resetRAD = true
	end

	function PLUGIN:PlayerSpawn(client)
		client:setNetVar("radioactiveE", false)
		client:getNetVar("radprotect", false)
		client:setNetVar("radioactive", 0)
		client:getNetVar("psiprotect", false)
	end

	local thinkTime = CurTime()
	local damageTime = CurTime()
	function PLUGIN:Think()
		if (thinkTime < CurTime()) then
			for k, v in ipairs(player.GetAll()) do
				if v:getNetVar("radioactive", 0) > 25 then
					if v:Alive() then
						v:TakeDamage(6,v,v:GetActiveWeapon())
						nut.log.add(client, "death", "radioactive")
					end
				end	
			end
			thinkTime = CurTime() + 5
		end
		
		--damage meme
		--[[if (damageTime < CurTime()) then
			for k, v in ipairs(player.GetAll()) do
			
				if (v:getNetVar("radioactive", 0) > 45 and v:getNetVar("radioactive", 0) < 75) then
					v:SetHealth(v:Health() - 1)
				elseif (v:getNetVar("radioactive", 0) > 75) then
					v:SetHealth(v:Health() - 2)
				end
			end
			damageTime = CurTime() + 3
		end]]
	end
end

nut.command.add("charsetrad", {
	adminOnly = true,
	syntax = "<string character> <number rad>",
	onRun = function(client, arguments)
		local target = nut.util.findPlayer(arguments[1])
		local rad = tonumber(arguments[2])

		target:setRAD(rad)

		if client != target then
            client:notify("")
            target:notify("")
        end
	end
})