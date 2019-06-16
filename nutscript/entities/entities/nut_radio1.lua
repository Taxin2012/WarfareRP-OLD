AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.Type = "anim"
ENT.PrintName = "RADIO1"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/z-o-m-b-i-e/st/technica/st_radiola_01.mdl") -- Сюда модель радио
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
			rnd = math.random(1,11)
			local time
			if (rnd == 1) then
				time = 259
			elseif (rnd == 2) then
				time = 246
			elseif (rnd == 3) then
				time = 255
			elseif (rnd == 4) then
				time = 262
			elseif (rnd == 5) then
				time = 466
			elseif (rnd == 6) then
				time = 232
			elseif (rnd == 7) then
				time = 262
			elseif (rnd == 8) then
				time = 258
			elseif (rnd == 9) then
				time = 260
			elseif (rnd == 10) then
				time = 237
			elseif (rnd == 11) then
				time = 261
			end
			if (self.loopsound) then
				self.loopsound:Stop()
			end
			self.loopsound = CreateSound( self, "radio/radiomix_"..rnd..".ogg")
			self.loopsound:ChangeVolume(0.55, 0)
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
