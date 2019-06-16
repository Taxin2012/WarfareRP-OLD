AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.Type = "anim"
ENT.PrintName = "RADIO_MERC_NEW"
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
			rnd = math.random(1,2)
			local time
			if (rnd == 1) then
				time = 228
			elseif (rnd == 2) then
				time = 216
			end
			if (self.loopsound) then
				self.loopsound:Stop()
			end
			self.loopsound = CreateSound( self, "merc/cit_mers_music_mlr_"..rnd..".ogg")
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
