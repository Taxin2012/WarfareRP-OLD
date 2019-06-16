AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.Type = "anim"
ENT.PrintName = "RADIO_LIKVOD"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/z-o-m-b-i-e/st/el_tehnika/st_priemnik_gorizont_01.mdl") -- Сюда модель радио
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
			rnd = math.random(1,9)
			local time
			if (rnd == 1) then
				time = 300
			elseif (rnd == 2) then
				time = 300
			elseif (rnd == 3) then
				time = 300
			elseif (rnd == 4) then
				time = 300
			elseif (rnd == 5) then
				time = 300
			elseif (rnd == 6) then
				time = 300
			elseif (rnd == 7) then
				time = 300
			elseif (rnd == 8) then
				time = 300
			elseif (rnd == 9) then
				time = 300
			end
			if (self.loopsound) then
				self.loopsound:Stop()
			end
			self.loopsound = CreateSound( self, "radio/likvid_"..rnd..".ogg")
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
