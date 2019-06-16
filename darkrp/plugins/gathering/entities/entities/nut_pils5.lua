ENT.Type = "anim"
ENT.PrintName = "Черный ящик"
ENT.Author = "AleXXX_007"
ENT.Category = "Мусор"
ENT.Spawnable = true
ENT.AdminOnly = true

if (CLIENT) then
	function ENT:Draw()
		local mypos = self:GetPos()
		local dist = LocalPlayer():GetPos():Distance(mypos)

		if(dist < 5000) then
			self.Entity:DrawModel()
		end
	end
end

function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/z-o-m-b-i-e/st_item_box_01.mdl")	
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetNetworkedBool("Usable", true)
		self:SetPersistent(true)
		self:Fire("SetAnimation", "ACT_IDLE2", 0)
		self:Activate()

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end

function ENT:Use(activator)
	local tbl = {
		"100r",
		"50r",
		"10r"
	}
	local tbl2 = {
		"blackbox",
		"bone",
		"cigar"
	}
	if self:GetNetworkedBool("Usable") == true then
	self:EmitSound("interface/inv_iam_open.ogg")
		self:SetNetworkedBool("Usable", false)
		activator:setAction("Ведётся поиск вещей...", 4)
		activator:doStaredAction(self, 
		function()
			if activator:getChar():getInv():add(table.Random(tbl), 1) then
				activator:notify("Вы нашли что-то полезное")
				self:EmitSound("interface/inv_open.ogg")
			else
				activator:notify("Вам не хватает места в инвентаре")
			end
			if activator:getChar():getInv():add(table.Random(tbl2), 1) then
				activator:notify("Вы нашли что-то полезное")
				self:EmitSound("interface/inv_close.ogg")
			else
				activator:notify("Вам не хватает места в инвентаре")
			end
			timer.Simple(math.random(3600, 3601), function()
				self:SetNetworkedBool("Usable", true)
			end)
		end, 4, 
		function()
			self:SetNetworkedBool("Usable", true)
			if (IsValid(activator)) then
				activator:setAction()
			end
		end)
	else
		activator:notify("Здесь ничего нет")
	end
end
function ENT:OnRemove()
	self:SetNetworkedBool("Usable", true)
end