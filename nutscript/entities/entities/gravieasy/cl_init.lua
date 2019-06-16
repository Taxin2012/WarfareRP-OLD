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
		if (!self.idle or self.idle < CurTime()) then
			/*
			local vec = VectorRand()
			vec.z = -0.1	
			local newpos = self:GetPos()+Vector(0,0,60) + vec * 700	
			local particle = self.Emitter:Add( self:getNetVar("eff1")..math.random(1, 8), newpos )
			particle:SetVelocity( self:getNetVar("vec") )
			particle:SetDieTime( math.random( 6, 9 ) )
			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( 2 )
			particle:SetEndSize( 2 )
			particle:SetRoll( math.random( -360, 360 ) )
			particle:SetAirResistance( math.random( 0, 10 ) )
			particle:SetThinkFunction( DustThink )
			particle:SetNextThink( CurTime() + 0.1 )
			particle.VortexPos = self:GetPos()
			*/
			
			self.idle = CurTime() + 3
		end
	for k, v in pairs( ents.FindInSphere( self:GetPos(), 80 ) ) do	
			if (v:GetPos():Distance(self:GetPos()) <= 80) then
				if (string.find( v:GetClass(), "prop" ) or v:IsRagdoll() or v:GetModel() == "models/weapons/stalker_cop/w_bolt.mdl") then
					if (!self.hit or self.hit < CurTime()) then
							self:EmitSound(self:getNetVar("sound1"))		
							local particle = self.Emitter:Add( self:getNetVar("eff2"), v:GetPos() )	
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
							local particle = self.Emitter:Add( self:getNetVar("eff4"), v:GetPos()	)
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
		if (v:GetPos():Distance(self:GetPos()) <= 80) then
			if (v:IsPlayer()) then
					if (!self.hit or self.hit < CurTime()) then
							self:EmitSound(self:getNetVar("sound1"))		
							local particle = self.Emitter:Add( self:getNetVar("eff2"), v:GetPos() + Vector(0, 0, 40) )	
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
		if (self:getNetVar("start3") == true) then
			/*
			local particle = self.Emitter:Add( self:getNetVar("eff5"), self:GetPos() + Vector( 0, 0, 5 ) )
			particle:SetVelocity( Vector( 0, 0, 5 ) )  
			particle:SetDieTime( 0.1 ) 
			particle:SetRoll( 90 )
			particle:SetStartAlpha( 20 ) 
			particle:SetEndAlpha( 20 ) 
			particle:SetStartSize( math.random( 50, 65 ) ) 
			particle:SetEndSize( 0 ) 
			particle:SetColor( 255, 255, 255 )
			*/
		end
	end
end

function ENT:OnRemove()
	if (self.Emitter) then
		self.Emitter:Finish()
	end
end

function DustThink( part )
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
end

function ENT:Draw()

end
