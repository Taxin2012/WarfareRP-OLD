ENT.Type = "anim"
ENT.PrintName = "Talker"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/mossman.mdl")
		self:SetUseType(SIMPLE_USE)
		self:SetMoveType(MOVETYPE_NONE)
		self:DrawShadow(true)
		self:SetSolid(SOLID_BBOX)
		self:PhysicsInit(SOLID_BBOX)

		self.messages = {}
		self.factions = {}
		self.classes = {}

		self:setNetVar("name", "John Doe")
		self:setNetVar("desc", "")

		self.receivers = {}

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end

	timer.Simple(1, function()
		if (IsValid(self)) then
			self:setAnim()
		end
	end)
end

function ENT:canAccess(client)
	if (client:IsAdmin()) then
		return true
	end

	local allowed = false
	local uniqueID = nut.faction.indices[client:Team()].uniqueID

	if (self.factions and table.Count(self.factions) > 0) then
		if (self.factions[uniqueID]) then
			allowed = true
		else
			return false
		end
	end

	if (allowed and self.classes and table.Count(self.classes) > 0) then
		local class = nut.class.list[client:getChar():getClass()]
		local uniqueID = class and class.uniqueID

		if (!self.classes[uniqueID]) then
			return false
		end
	end

	return true
end

function ENT:setAnim()
	for k, v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("idle") and v != "idlenoise") then
			return self:ResetSequence(k)
		end
	end

	self:ResetSequence(4)
end

if (CLIENT) then
	
	netstream.Hook("nut_Dialogue", function(data)
		if (IsValid(nut.gui.dialogue)) then
			nut.gui.dialogue:Remove()
			return
		end
		nut.gui.dialogue = vgui.Create("Nut_Dialogue")
		nut.gui.dialogue:Center()
		nut.gui.dialogue:SetEntity(data)
if LocalPlayer():IsAdmin() then
		if (IsValid(nut.gui.edialogue)) then
			nut.gui.dialogue:Remove()
			return
		end
		nut.gui.edialogue = vgui.Create("Nut_DialogueEditor")
		--nut.gui.edialogue:Center()
		nut.gui.edialogue:SetEntity(data)
end
	end)
	local TEXT_OFFSET = Vector(0, 0, 20)
	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	ENT.DrawEntityInfo = true

	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)) + TEXT_OFFSET)
		local x, y = position.x, position.y
		local desc = self.getNetVar(self, "desc")

		drawText(self.getNetVar(self, "name", "John Doe"), x, y, colorAlpha(Color(210, 180, 140)), 1, 1, "BigFontForWS", alpha * 0.65)

		if (desc) then
			drawText(desc, x, y + 16, colorAlpha(Color(210, 180, 140)), 1, 1, "BigFontForWS", alpha * 0.65)
		end
	end  --netstream.Start(activator, "nut_Dialogue", self)
else

	function ENT:Use(activator)
		local factionData = self:getNetVar("factiondata", {})
		if !factionData[nut.faction.indices[activator:Team()].uniqueID] and !activator:IsSuperAdmin() then
			activator:ChatPrint( self:getNetVar( "name", "John Doe" )..": I don't want talk with you." )
			return
		end
		if (self:GetModel() == "models/stalkertnb/beri_mili_officer.mdl") then
			if (!activator:IsAdmin()) then
				local items = activator:getChar():getInv():hasItem("chzo")
				if (activator:Team() == FACTION_LONER )
				or (activator:Team() == FACTION_FREEDOM )
				or (activator:Team() == FACTION_RAIDERS ) then
					if (items) then
						netstream.Start(activator, "nut_Dialogue", self)
					end
				else
					netstream.Start(activator, "nut_Dialogue", self)
				end
			else
				netstream.Start(activator, "nut_Dialogue", self)
			end
		else
			netstream.Start(activator, "nut_Dialogue", self)
			if (!self.usetime or self.usetime < CurTime()) then
			if (self:GetModel() == "models/spenser/ssk/item_misery/new_barman_2_spen.mdl") then
				self:EmitSound("stalker_sound/bar_barman_hello_"..math.random(1,5)..".wav")
			elseif (self:GetModel() == "models/spenser/ssk/item_misery/new_sahar_spen.mdl") then
				self:EmitSound("stalker_sound/yan_sakharov_meet_4.wav")
			--elseif (self:GetModel() == "models/spenser/ssk/item_misery/new_sahar_spen.mdl") then
			--	self:EmitSound("stalker_sound/yan_sakharov_meet_4.wav")
			end
			self.usetime = CurTime() + 2
		end
		end
	end

	netstream.Hook("nut_DialogueData", function( client, data )
		if (!client:IsSuperAdmin()) then
			return
		end
		local entity = data[1]
		local dialogue = data[2]
		local factionData = data[3]
		local classData = data[4]
		local name = data[5]
		local desc = data[6]
		local model = data[7]

		
		if (IsValid(entity)) then
			entity:setNetVar("dialogue", dialogue)
			entity:setNetVar("factiondata", factionData)
			entity:setNetVar("classdata", classData)
			entity:setNetVar("name", name)
			entity:setNetVar("desc", desc)
			entity:SetModel(model)
			entity:setAnim()

			client:notify("You have updated this talking npc's data.")
		end
	end)

end
