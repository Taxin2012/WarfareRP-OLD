AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Tent"
ENT.Category = "NutScript"
ENT.Spawnable = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/z-o-m-b-i-e/st/army_base/st_palatka_01.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:Wake()
		end
	end

function ENT:Think()
	if (!self.timeheal or self.timeheal < CurTime()) then
		for k, v in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do --200 радиус
			if (v:IsPlayer() and v:Health() > 0) then
				v:SetHealth(v:Health() + 2)
			end
		end
		self.timeheal = CurTime() + 2
	end
end

end
