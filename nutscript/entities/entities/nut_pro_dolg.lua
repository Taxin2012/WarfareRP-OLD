AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.Type = "anim"
ENT.PrintName = "PRO_DOLG"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/z-o-m-b-i-e/st_loudspeaker.mdl") -- Сюда модель радио
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
		
	end

	
	function ENT:Think()
		local rnd
		if (!self.thinktime or self.thinktime < CurTime()) then
			rnd = math.random(1,7)
			local time = 90
			if (self.loopsound) then
				self.loopsound:Stop()
			end
			self.loopsound = CreateSound( self, "stalker_sound/mega_duty_propaganda_"..rnd..".wav")
			self.loopsound:Play()
			self.thinktime = CurTime() + time
		end
	end

function ENT:OnRemove()
	if (self.loopsound) then
		self.loopsound:Stop()
	end
end

end
