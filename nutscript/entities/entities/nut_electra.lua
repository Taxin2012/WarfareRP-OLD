AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Электра"
ENT.Author = "Spenser"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "STALKER"
ENT.RenderGroup 		= RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		--self:SetModel("models/props_c17/FurnitureDrawer001a_Shard01.mdl")
		----
		self.Entity:SetModel( "models/props_junk/watermelon01.mdl" ) 
		self.Entity:SetColor( Color( 0, 63, 0, 255 ) )
		self.Entity:SetMaterial( "models/effects/vol_light001" )
	---
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetNoDraw(true)
		self:SetMoveType( MOVETYPE_NONE )
		self:DrawShadow( false )
		self:SetSolid( SOLID_NONE )
        self:SetMaterial("models/effects/vol_light001")
		self:setNetVar("start", false)
	end

function ENT:Think()
	nutelectraanom(self)
    if (!self.Timer or self.Timer < CurTime()) then
      local vPoint = self:GetPos() + Vector(math.random(-50,50),math.random(-50,50),math.random(0,5))
      ParticleEffect("polter_electrossk_full", vPoint, Angle(0,0,0), nil)  
      self.Timer = CurTime() + math.random( 1, 2 )
    end 
end

function ENT:DrawBeams( ent1, ent2, pos )
	local target = ents.Create( "info_target" )
	target:SetPos( ent1:LocalToWorld( ent1:OBBCenter() ) )
	target:SetParent( ent1 )
	target:SetName( tostring( ent1 )..math.random(1,900) )
	target:Spawn()
	target:Activate()
	local target2 = ents.Create( "info_target" )
	if pos then
		target2:SetPos( pos )
		target2:SetName( tostring( pos ) )
	else
		target2:SetPos( ent2:LocalToWorld( ent2:OBBCenter() ) )
		target2:SetParent( ent2 )
		target2:SetName( tostring( ent2 )..math.random(1,900) )
	end
	target2:Spawn()
	target2:Activate()
	local laser = ents.Create( "env_beam" )
	laser:SetPos( ent1:GetPos() )
	laser:SetKeyValue( "spawnflags", "1" )
	laser:SetKeyValue( "rendercolor", "65 105 225" )
	laser:SetKeyValue( "texture", "sprites/laserbeam.spr" )
	laser:SetKeyValue( "TextureScroll", "1" )
	laser:SetKeyValue( "damage", "0" )
	laser:SetKeyValue( "renderfx", "6" )
	laser:SetKeyValue( "NoiseAmplitude", ""..math.random(30,70) )
	laser:SetKeyValue( "BoltWidth", "1" )
	laser:SetKeyValue( "TouchType", "0" )
	laser:SetKeyValue( "LightningStart", target:GetName() )
	laser:SetKeyValue( "LightningEnd", target2:GetName() )
	laser:SetOwner( self:GetOwner() )
	laser:Spawn()
	laser:Activate()
	laser:Fire( "kill", "", 0.2 )
	target:Fire( "kill", "", 0.2 )
	target2:Fire( "kill", "", 0.2 )
end 

else

	function ENT:Draw()
		self:DrawModel()
	end

end

function nutelectraanom(ent)
  local self = ent
  
  /*
    local tesla = ents.Create( "point_tesla" )
    tesla:SetPos( self:GetPos()+Vector(math.random(-25,25),math.random(-25,25), math.random(15, 25)) )
    tesla:SetKeyValue("targetname", "electroanom" ) 
    tesla:SetKeyValue("m_flRadius", "20" )
    tesla:SetKeyValue("m_SourceEntityName", "electroanom" )
    tesla:SetKeyValue("m_Color", "100 149 237" )
    tesla:SetKeyValue("beamcount_min", "1" )
    tesla:SetKeyValue("beamcount_max", "2" ) 
    tesla:SetKeyValue("texture", "sprites/laser.vmt" )
    tesla:SetKeyValue("thick_min", "1" )
    tesla:SetKeyValue("thick_max", "3" )
    tesla:SetKeyValue("lifetime_min", "0.3" )
    tesla:SetKeyValue("lifetime_max", "0.5" )
    tesla:SetKeyValue("interval_min", "0" )
    tesla:SetKeyValue("interval_max", "1.5" )
    tesla:Spawn()
    tesla:Activate()
    tesla:SetParent(self)
    tesla:SetOwner(self)
    tesla:Fire("turnon", "", 0)
    tesla:Fire("turnoff", "", 1)
    tesla:Fire("kill", "", 1)
    */
    if (!self.idlesound or self.idlesound < CurTime()) then
      self:EmitSound("anomaly/electra_idle1.wav")
      self.idlesound = CurTime() + 5
    end 
    for k, v in pairs( ents.FindInSphere( self:GetPos(), 120 ) ) do 
    if (v:IsRagdoll()) then
      if (v:IsValid()) then
      local ragdoll = v
      local effect = EffectData()
      effect:SetOrigin(ragdoll:GetPos())
      effect:SetStart(ragdoll:GetPos())
      effect:SetMagnitude(3)
      effect:SetEntity(ragdoll)
      util.Effect("teslaHitBoxes",effect)
      timer.Create( "zapper", 0.2, 14, function()
    local effect2 = EffectData()
      effect2:SetOrigin(ragdoll:GetPos())
      effect2:SetStart(ragdoll:GetPos())
      effect2:SetMagnitude(3)
      effect2:SetEntity(ragdoll)
      util.Effect("teslaHitBoxes",effect2)
    end)
      ragdoll:Fire("StartRagdollBoogie","",0)
    end
      //
    end
    ////Болт
    if ((v:GetModel() == "models/weapons/ssk/spenser/w_ssk_bolt.mdl" or v:GetClass() == "nut_f1" or v:GetClass() == "nut_rgd") and v:GetPos( ):Distance( self:GetPos( ) ) <= 100) then
      local bolt = v
        if (!bolt.effe or bolt.effe < CurTime()) then
          self:EmitSound("anomaly/electra_blast1.wav")
          bolt:EmitSound("anomaly/electra_hit.wav")
          /////////////////
          local tesla = ents.Create( "point_tesla" )
          tesla:SetPos( self:GetPos()+Vector(0,0,10) )
          tesla:SetKeyValue("targetname", "electroanom" ) 
          tesla:SetKeyValue("m_flRadius", "605" )
          tesla:SetKeyValue("m_SourceEntityName", "electroanom" )
          tesla:SetKeyValue("m_Color", "100 149 237" )
          tesla:SetKeyValue("beamcount_min", "40" )
          tesla:SetKeyValue("beamcount_max", "45" ) 
          tesla:SetKeyValue("texture", "sprites/laser.vmt" )
          tesla:SetKeyValue("thick_min", "35" )
          tesla:SetKeyValue("thick_max", "36" )
          tesla:SetKeyValue("lifetime_min", "0.5" )
          tesla:SetKeyValue("lifetime_max", "0.8" )
          tesla:SetKeyValue("interval_min", "0" )
          tesla:SetKeyValue("interval_max", "0.7" )
          tesla:Spawn()
          tesla:Activate()
          tesla:SetParent(self)
          tesla:SetOwner(self)
          tesla:Fire("turnon", "", 0)
          tesla:Fire("turnoff", "", 1)
          tesla:Fire("kill", "", 1)
          local Light = ents.Create("light_dynamic")
          Light:SetKeyValue("_light", "100 149 237")
          Light:SetKeyValue("distance", "700")
          Light:SetKeyValue("_cone", "0")
          Light:SetPos(self:GetPos())
          Light:SetParent(self)
          Light:Spawn()
          Light:Activate()
          Light:Fire("TurnOn", "", 0) 
          Light:Fire("turnoff", "", 1.5)
          Light:Fire("kill", "", 2)
          ////////////////
          v:TakeDamage(math.random(10, 35))
          local vec = VectorRand() 
          local trace = {}
          trace.start = v:GetPos()
          trace.endpos = trace.start + Vector(0, 0, 50) * 500
          trace.filter = self
          tr = util.TraceLine( trace )
          self:DrawBeams( self, self, tr.HitPos )
          local effect = EffectData()
          effect:SetOrigin( tr.HitPos )
          util.Effect( "electric_zap", effect )
          bolt.effe = CurTime() + 3
      end
  end
      if (v:IsPlayer() and v:Health() > 0 and v:GetPos( ):Distance( self:GetPos( ) ) <= 100) then
        local client = v
        if (!client.effe or client.effe < CurTime()) then
       //

     //
          client:setNetVar("drunk", client:getNetVar("drunk", 0) + 1)
          timer.Simple(7,function ()
            client:setNetVar("drunk", client:getNetVar("drunk", 0) - 0.2)
            timer.Simple(7,function ()
              client:setNetVar("drunk", client:getNetVar("drunk", 0) - 0.2)
              timer.Simple(7,function ()
                client:setNetVar("drunk", client:getNetVar("drunk", 0) - 0.2)
                timer.Simple(7,function ()
                   client:setNetVar("drunk", client:getNetVar("drunk", 0) - 0.2)
                  timer.Simple(7,function ()
                     client:setNetVar("drunk", client:getNetVar("drunk", 0) - 0.2)
                     end)
                   end)
                end)
              end)
          end)
          client:ViewPunch( Angle( math.random(-200,200), math.random(-200,200), math.random(-200,200)) )
          client:ScreenFade( SCREENFADE.OUT, Color( 255, 0, 0, 255 ), 1, 0 )
          self:EmitSound("anomaly/electra_blast1.wav")
          client:EmitSound("anomaly/electra_hit.wav")
          /////////////////
          local tesla = ents.Create( "point_tesla" )
          tesla:SetPos( self:GetPos()+Vector(0,0,10) )
          tesla:SetKeyValue("targetname", "electroanom" ) 
          tesla:SetKeyValue("m_flRadius", "605" )
          tesla:SetKeyValue("m_SourceEntityName", "electroanom" )
          tesla:SetKeyValue("m_Color", "100 149 237" )
          tesla:SetKeyValue("beamcount_min", "40" )
          tesla:SetKeyValue("beamcount_max", "45" ) 
          tesla:SetKeyValue("texture", "sprites/laser.vmt" )
          tesla:SetKeyValue("thick_min", "35" )
          tesla:SetKeyValue("thick_max", "36" )
          tesla:SetKeyValue("lifetime_min", "0.5" )
          tesla:SetKeyValue("lifetime_max", "0.8" )
          tesla:SetKeyValue("interval_min", "0" )
          tesla:SetKeyValue("interval_max", "0.7" )
          tesla:Spawn()
          tesla:Activate()
          tesla:SetParent(self)
          tesla:SetOwner(self)
          tesla:Fire("turnon", "", 0)
          tesla:Fire("turnoff", "", 1)
          tesla:Fire("kill", "", 1)
          local Light = ents.Create("light_dynamic")
          Light:SetKeyValue("_light", "100 149 237")
          Light:SetKeyValue("distance", "700")
          Light:SetKeyValue("_cone", "0")
          Light:SetPos(self:GetPos())
          Light:SetParent(self)
          Light:Spawn()
          Light:Activate()
          Light:Fire("TurnOn", "", 0) 
          Light:Fire("turnoff", "", 1.5)
          Light:Fire("kill", "", 2)
          ////////////////
          client:TakeDamage(math.random(40, 50))
          local vec = VectorRand() 
          local trace = {}
          trace.start = client:GetPos()
          trace.endpos = trace.start + Vector(0, 0, 50) * 500
          trace.filter = self
          tr = util.TraceLine( trace )
          self:DrawBeams( self, self, tr.HitPos )
          local effect = EffectData()
          effect:SetOrigin( tr.HitPos )
          util.Effect( "electric_zap", effect )
          client.effe = CurTime() + 2
        end
      end
      if (v:IsPlayer()) then
        ///
        local client = v
        if (client:GetPos():Distance(self:GetPos()) <= 120 and client:GetPos():Distance(self:GetPos()) >= 101) then
          //
           if (client:Health() > 0) then
          if (!client.nextbip or client.nextbip < CurTime()) then
              client:EmitSound("pda/da-2_beep1.wav")
             client.nextbip = CurTime() + 0.5
           end
          end
          //
        elseif (client:GetPos():Distance(self:GetPos()) <= 100 and client:GetPos():Distance(self:GetPos()) >= 81) then
          //
           if (client:Health() > 0) then
          if (!client.nextbip2 or client.nextbip2 < CurTime()) then
            client:EmitSound("pda/da-2_beep1.wav")
            client.nextbip2 = CurTime() + 0.25
            end
          end
          //
        elseif (client:GetPos():Distance(self:GetPos()) <= 80) then
          //
           if (client:Health() > 0) then
          if (!client.nextbip3 or client.nextbip3 < CurTime()) then
            client:EmitSound("pda/da-2_beep1.wav")
            client.nextbip3 = CurTime() + 0.03
          end
          end
          //
        end
        ///
      end
      ///
    end
end