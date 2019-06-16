local PLUGIN = PLUGIN
PLUGIN.name = "PSY"
PLUGIN.author = "Spenser & Kek1ch"
PLUGIN.desc = "PSY System"

local playerMeta = FindMetaTable("Player")
local entityMeta = FindMetaTable("Entity")
--[[if (CLIENT) then
	nut.bar.add(function()
		return LocalPlayer():getNetVar("psy", 0) / 100
	end, Color(138, 43, 226), nil, "psy")	
end]]
function playerMeta:getPSY()
	return (self:getNetVar("psy")) or 0
end

function playerMeta:getPSYPercent()
	return math.Clamp(self:getPSY()/100, 0 ,1)
end

function playerMeta:addPSY(amount)
	local curPSY = self:getPSY()

	self:setNetVar("psy", 
		math.Clamp(math.min(curPSY) + amount, 0, 100)
	)
end

function playerMeta:setPSY(amount)
	
	self:setNetVar("psy", math.Clamp(amount, 0, 100))
end

if (CLIENT) then
	local color = Color(39, 174, 96)

function PLUGIN:RenderScreenspaceEffects()
	if (LocalPlayer():getChar()) then
		if (LocalPlayer():getPSY() > 45 and LocalPlayer():getPSY() < 75) then
			DrawMotionBlur(0.1, 0.3, 0.01)
		elseif(LocalPlayer():getPSY() > 75) then
			DrawMotionBlur(0.1, 0.7, 0.01)
		end
		if (LocalPlayer():getNetVar("psyE", true) == true and LocalPlayer():Health() > 0) then
					local color = {}
					color["$pp_colour_brightness"] = -0.1
					color["$pp_colour_contrast"] = 1.2
					color["$pp_colour_addr"] = 0.23
					color["$pp_colour_addg"] = 0.15
					color["$pp_colour_colour"] = 0.2
					color["$pp_colour_addb"] = 0.01
					color["$pp_colour_mulr"] = 0.01
					color["$pp_colour_mulg"] = 0.01
					color["$pp_colour_mulb"] = 0.01

					---DrawMotionBlur(0.1, 0.2, 0.3)
					DrawColorModify(color) 
		end
    end
end
else
	local PLUGIN = PLUGIN
	
	function PLUGIN:CharacterPreSave(character)
		local savedPSY = math.Clamp(character.player:getPSY(), 0, 100)
		character:setData("psy", savedPSY)
	end

	function PLUGIN:PlayerLoadedChar(client, character, lastChar)
		if (character:getData("psy")) then
			client:setNetVar("psy", character:getData("psy"))
		else
			client:setNetVar("psy", 0)
		end
	end

	function PLUGIN:PlayerDeath(client)
		client.resetPSY = true
	end

	function PLUGIN:PlayerSpawn(client)
		client:setNetVar("psyE", false)
		client:setNetVar("psy", 0)
	end

	local thinkTime = CurTime()
	local damageTime = CurTime()
	function PLUGIN:Think()
		if (thinkTime < CurTime()) then
			for k, v in ipairs(player.GetAll()) do
				if (v:getNetVar("psy", 0) == 100) then
					if v:Alive() then
						v:Kill()
						nut.log.add(client, "death", "psy")
					end
				elseif (v:getNetVar("psy", 0) > 45 and v:getNetVar("psy", 0) < 75) then
					v:SetHealth(v:Health() - 1)
				elseif (v:getNetVar("psy", 0) > 75) then
					v:SetHealth(v:Health() - 2)
				end
			end
			thinkTime = CurTime() + 1.5
		end
	end
	
end

nut.command.add("charsetpsy", {
	adminOnly = true,
	syntax = "<string character> <number psy>",
	onRun = function(client, arguments)
		local target = nut.util.findPlayer(arguments[1])
		local psy = tonumber(arguments[2])

		target:setPSY(psy)

		if client != target then
            client:notify("")
            target:notify("")
        end
	end
})