include('shared.lua')

function ENT:Initialize()
	local trace = {}
	trace.start = self:GetPos()
	trace.endpos = trace.start + Vector( 0, 0, -500 )
	trace.filter = self
	local tr = util.TraceLine( trace )
	self.Normal = tr.HitNormal
	self.Timer = 0
	self.BurnTime = 0
	self.Size = 50
	self.Emitter = ParticleEmitter( self:GetPos() )
end

function ENT:Think()
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
if (dist < 550) then
	if (self:getNetVar("start") == false) then
		if (!self.idle or self.idle < CurTime()) then	
		/*		
			local particle = self.Emitter:Add( self:getNetVar("eff5")..math.random(1, 8), self:getNetVar("pos") )
			particle:SetVelocity( Vector( 0, 0, math.random( 15, 20 ) ) )
			particle:SetDieTime( 1.5 ) 
			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( 2 )
			particle:SetEndSize( 2 )
			particle:SetRoll( math.random( -360, 360 ) )
			particle:SetAirResistance( 1 )
			particle:SetThinkFunction( DustThink )
			particle:SetNextThink( CurTime() + 0.1 )
			particle.VortexPos = self:GetPos()
			*/
			self.idle = CurTime() + 0.25
		end
	elseif (self:getNetVar("start") == true) then
		if (!self.idle or self.idle < CurTime()) then
			/*
			local particle = self.Emitter:Add( self:getNetVar("eff5")..math.random(1, 8), self:getNetVar("pos2") )
			particle:SetVelocity( Vector( 0, 0, math.random( 65, 70 ) ) )
			particle:SetDieTime( 2.5 ) 
			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( 2 )
			particle:SetEndSize( 2 )
			particle:SetRoll( math.random( -360, 360 ) )
			particle:SetAirResistance( 1 )
			particle:SetThinkFunction( DustThink )
			particle:SetNextThink( CurTime() + 0.1 )
			particle.VortexPos = self:GetPos()
			*/
			self.idle = CurTime() + 0.1
		end
	end
	for k, v in pairs( ents.FindInSphere( self:GetPos(), 120 ) ) do	
			if (v:GetPos():Distance(self:GetPos()) <= 85) then
				if (string.find( v:GetClass(), "prop" ) or v:IsRagdoll() or v:GetModel() == "models/weapons/stalker_cop/w_bolt.mdl") then
					if (!self.hit or self.hit < CurTime()) then
							self:EmitSound(self:getNetVar("sound1"))		
							local particle = self.Emitter:Add( self:getNetVar("eff4"), v:GetPos() )	
							particle:SetVelocity( Vector( 0, 0, 5 ) )  
							particle:SetDieTime( 0.8 ) 
							particle:SetRoll( math.random( -360, 360 ) )
							particle:SetStartAlpha( 75 ) 
							particle:SetEndAlpha( 75 ) 
							particle:SetStartSize( math.random( 25, 35 )  ) 
							particle:SetEndSize( math.random( 45, 55 )  ) 
							local smoke = self.Emitter:Add( self:getNetVar("eff3"), v:GetPos() )
							smoke:SetVelocity( Vector( 0, 0, 0 ) )
							smoke:SetDieTime( math.Rand(0.5, 1) )
							smoke:SetStartAlpha( math.Rand(150, 200) )
							smoke:SetEndAlpha(0)
							smoke:SetStartSize( math.random(1, 2) )
							smoke:SetEndSize( math.random(2, 3) )
							smoke:SetStartLength( math.random(0, 3) )
							smoke:SetEndLength( math.random(3, 12) )
							smoke:SetColor(255,255,255)
							smoke:SetGravity( Vector( 0, 0, -50 ) )
							smoke:SetAirResistance(300)
							local particle = self.Emitter:Add( self:getNetVar("eff2"), v:GetPos()	)
							particle:SetVelocity( Vector( 0, 0, 0 ) ) 
							particle:SetLifeTime( 0 )  
							particle:SetDieTime( math.Rand( 0.5, 1 ) ) 
							particle:SetStartAlpha( 255 ) 
							particle:SetEndAlpha( 255 ) 
							particle:SetStartSize( math.random( 3, 5 ) ) 
							particle:SetEndSize( 0 ) 
							particle:SetAirResistance( 50 )
							particle:SetGravity( Vector( 0, 0, 0 ) )	
							self.hit = CurTime() + 3 
				end
			end
		end
		if (v:GetPos():Distance(self:GetPos()) <= 105) then
			if (v:IsPlayer()) then
					if (!self.hit or self.hit < CurTime()) then
							self:EmitSound(self:getNetVar("sound1"))		
							local particle = self.Emitter:Add( self:getNetVar("eff4"), v:GetPos() + Vector(0, 0, 40) )	
							particle:SetVelocity( Vector( 0, 0, 5 ) )  
							particle:SetDieTime( 0.5 ) 
							particle:SetRoll( math.random( -360, 360 ) )
							particle:SetStartAlpha( 85 ) 
							particle:SetEndAlpha( 85 ) 
							particle:SetStartSize( math.random( 28, 33 )  ) 
							particle:SetEndSize( math.random( 47, 53 )  ) 
							self.hit = CurTime() + 3 
						end	
					end
				end
			end
	if (self:getNetVar("start") == true) then
			local particle = self.Emitter:Add( self:getNetVar("eff4"), self:GetPos() + Vector( 0, 0, 270 ) )
			particle:SetVelocity( Vector( 0, 0, 5 ) )  
			particle:SetDieTime( 0.1 ) 
			particle:SetRoll( math.random( -360, 360 ) )
			particle:SetStartAlpha( 25 ) 
			particle:SetEndAlpha( 25 ) 
			particle:SetStartSize( 30 ) 
			particle:SetEndSize( 0 ) 
			particle:SetColor( 255, 255, 255 )
		end
		if (self:getNetVar("start3") == true) then
			local particle = self.Emitter:Add( self:getNetVar("eff4"), self:GetPos() + Vector( 0, 0, 270 ) )
			particle:SetVelocity( Vector( 0, 0, 5 ) )  
			particle:SetDieTime( 0.1 ) 
			particle:SetRoll( 90 )
			particle:SetStartAlpha( 30 ) 
			particle:SetEndAlpha( 30 ) 
			particle:SetStartSize( math.random( 160, 175 ) ) 
			particle:SetEndSize( 0 ) 
			particle:SetColor( 255, 255, 255 )
		end
	end
end

function ENT:OnRemove()
	if (self.Emitter) then
		self.Emitter:Finish()
	end
end

function DustThink( part )
	/*
	local dir = ( part.VortexPos - part:GetPos() ):GetNormal()
	local scale = math.Clamp( part.VortexPos:Distance( part:GetPos() ), 0, 500 ) / 500	
	if scale < 0.1 and not part.Scale then
			part.Scale = math.Rand( 0.8, 1.2 )	
	end	
	if part.Scale then	
		scale = part.Scale	
	end
	part:SetNextThink( CurTime() + 0.1 )
	part:SetGravity( dir * ( scale * 500 ) )
	*/
end

function ENT:Draw()

end
