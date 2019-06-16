AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

	function ENT:Initialize()
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self:SetTrigger( true )
	self:SetNotSolid( true )
	self:DrawShadow( false )	
	self:SetCollisionBounds( Vector( -100, -100, -100 ), Vector( 100, 100, 100 ) )
	self:PhysicsInitBox( Vector( -100, -100, -100 ), Vector( 100, 100, 100 ) )
	self:setNetVar("start", false)
	self:setNetVar("start2", false)
	self:setNetVar("start3", false)
	self:setNetVar("start5",false)
	end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	if ( !ply:IsSuperAdmin() ) then 
	//
	local effectData = EffectData()
	
	effectData:SetStart( ply:GetPos() )
	effectData:SetOrigin( ply:GetPos() )
	effectData:SetScale(1)
	
	util.Effect("Explosion", effectData, true, true)
	
	ply:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav")
	//
	ply:TakeDamage(1000000000000000) 
	return
	end
	local SpawnPos = tr.HitPos + tr.HitNormal * 55
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

	function ENT:Think()
		anomgravieasy(self)
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS 
end

function anomgravieasy(ent)
  local self = ent
  ///
  self:setNetVar("eff1", "effects/leaves")
  self:setNetVar("eff2", "effects/pfx_anomaly3")
  self:setNetVar("eff3", "effects/spark")
  self:setNetVar("eff4", "effects/pfx_anomaly1")
   self:setNetVar("eff5", "effects/pfx_anomaly2")
   self:setNetVar("sound1", "anomaly/gravi_hit.wav")
   local vec = Vector(  math.random( -25, 25 ),  math.random( -25, 25 ), math.random( 15, 35 ) )
  self:setNetVar("vec", vec) 
    ////////Звуки спокойствия Аномалии//////
    if (self:getNetVar("start") == false) then
      if (!self.idle or self.idle < CurTime()) then
        self.idle = CurTime() + 4
      end
      if (!self.idleEF or self.idleEF < CurTime()) then
        ParticleEffect("gravyanomssk_0", self:GetPos()+Vector(math.random( -5, 5 ),math.random( -5, 5 ),math.random( -20, -10 )), Angle(0,0,0), nil) 
        self.idleEF = CurTime() + 1.6
      end
      if (!self.idleEF2 or self.idleEF2 < CurTime()) then
        ParticleEffect("leavesssk_r_1", self:GetPos()+Vector(math.random( -5, 5 ),math.random( -5, 5 ),math.random( -50, -40 )), Angle(0,0,0), nil) 
        self.idleEF2 = CurTime() + 4
      end
    end
    ///////////////////////////////////////
    ////////////Начало/////////////
    for k, v in pairs( ents.FindInSphere( self:GetPos(), 120 ) ) do 
      /////////////////УРОН И ЭФФЕКТЫ ИГРОКУ/////////////
  if (v:IsPlayer() and v:Health() > 0 or v:IsNPC() or v:GetClass() == "ssk_dog" or v:GetClass() == "ssk_boar_s" or v:GetClass() == "ssk_boar_m" or v:GetClass() == "ssk_tush" or v:GetClass() == "ssk_flash_s" or v:GetClass() == "ssk_flash_m" or v:GetClass() == "ssk_krovo_m" or v:GetClass() == "ssk_krovo_s" or v:GetClass() == "ssk_krovo_e" or v:GetClass() == "ssk_snork" or v:GetClass() == "ssk_izlom" or v:GetClass() == "ssk_zombie" or v:GetClass() == "ssk_himera") then    
    if (v:GetPos():Distance(self:GetPos()) <= 80) then
        //////////Вкл. Анамалия////////////
    if (!self.surge or self.surge < CurTime()) then
      self:EmitSound("anomaly/anomaly_gravy_blast1.wav")
      self:setNetVar("start3", true)
      timer.Simple(0.15, function()
          ////////Урон//////
        if (v:Health() > 0 and v:IsPlayer()) then
            v:TakeDamage(25)
          v:setNetVar("drunk", v:getNetVar("drunk", 0) + 1)
          timer.Simple(7,function ()
            v:setNetVar("drunk", v:getNetVar("drunk", 0) - 0.2)
            timer.Simple(7,function ()
              v:setNetVar("drunk", v:getNetVar("drunk", 0) - 0.2)
              timer.Simple(7,function ()
                v:setNetVar("drunk", v:getNetVar("drunk", 0) - 0.2)
                timer.Simple(7,function ()
                   v:setNetVar("drunk", v:getNetVar("drunk", 0) - 0.2)
                  timer.Simple(7,function ()
                     v:setNetVar("drunk", v:getNetVar("drunk", 0) - 0.2)
                     end)
                   end)
                end)
              end)
          end)
          v:ViewPunch( Angle( math.random(-200,200), math.random(-200,200), math.random(-200,200)) )
          v:ScreenFade( SCREENFADE.IN, Color( 255, 0, 0, 200 ), 0.8, 0 )
        end
          if (v:GetClass() == "ssk_dog" or v:GetClass() == "ssk_boar_s" or v:GetClass() == "ssk_boar_m" or v:GetClass() == "ssk_tush" or v:GetClass() == "ssk_flash_s" or v:GetClass() == "ssk_flash_m" or v:GetClass() == "ssk_krovo_m" or v:GetClass() == "ssk_krovo_s" or v:GetClass() == "ssk_krovo_e" or v:GetClass() == "ssk_snork" or v:GetClass() == "ssk_izlom" or v:GetClass() == "ssk_zombie" or v:GetClass() == "ssk_himera") then
            local all = v
              all:TakeDamage(all:Health())
              if (all:GetModel() == "models/spenser/ssk/new_dog_spen.mdl") then
                all:EmitSound( "mutants/ssk/dog/bdog_die_" .. math.random( 0, 2 ) .. ".mp3" )  
              elseif (all:GetModel() == "models/spenser/ssk/new_boar_spen.mdl") then
                all:EmitSound( "mutants/ssk/boar/boar_anomaly_2.mp3" )  
              elseif (all:GetClass() == "ssk_tush") then
                 all:EmitSound( "mutants/ssk/tushkano/tushkano_death_"..math.random( 0, 2 )..".mp3" )
              elseif (all:GetModel() == "models/spenser/ssk/new_flesh_spen.mdl") then
                all:EmitSound( "mutants/ssk/flesh/flesh_anomaly_death_0.mp3" )
              end
          end
        //////Пыль и свет после удара/////
      local Light = ents.Create("light_dynamic")
      Light:SetKeyValue("_light", "255 255 255")
      Light:SetKeyValue("distance", "900")
      Light:SetKeyValue("_cone", "0")
      Light:SetPos(self:GetPos())
      Light:SetParent(self)
      Light:Spawn()
      Light:Activate()
      Light:Fire("TurnOn", "", 0) 
      Light:Fire("TurnOff", "", 0.5) 
      self:setNetVar("start5",true)
          self:setNetVar("start3", false)
          timer.Simple(1.5, function()
            self:setNetVar("start5",false)
          end)
      local pos = self:GetPos() + Vector( 0, 0, 13)
      local effectdata = EffectData()
            effectdata:SetStart( self:GetPos() + Vector( 0, 0, 10 )) 
            effectdata:SetOrigin( self:GetPos() + Vector( 0, 0, 10 ))
      effectdata:SetScale( 690 )
      effectdata:SetRadius( 0.3 )
      effectdata:SetMagnitude( 0.3 )
            util.Effect( "ThumperDust", effectdata ) 
            ////////////////////////////////////////
        end)
        self.surge = CurTime() + 2
      end 
    end
  end
      if (v:IsValid() and v:GetPhysicsObject():IsValid() and (!self.hit or self.hit < CurTime())) then
        if (string.find( v:GetClass(), "prop" )) then
          if (v:GetPos():Distance(self:GetPos()) <= 80) then
              if (!v:IsRagdoll()) then
              local dir = ( self:GetPos() - v:GetPos() + Vector(0, 0, 50) ):GetNormal()
              local force = 295
              local distance = dir:Length()
              local maxdistance = 100
              local ratio = math.Clamp( (1 - (distance/maxdistance)), 0, 1 )
              local vForce = -1*dir * (force * ratio)
              local phys = v:GetPhysicsObject()
              if (!v:IsRagdoll()) then
                phys:ApplyForceCenter( -dir * phys:GetMass() * 850 )
              end
              end
              self.hit = CurTime() + 1 
      ////////////////////////////////////////////
      end
      end
      end
      if (v:IsPlayer()) then
        ///
        local client = v
        if (client:GetPos():Distance(self:GetPos()) <= 120 and client:GetPos():Distance(self:GetPos()) >= 91) then
          //
           if (client:Health() > 0) then
          if (!client.nextbip or client.nextbip < CurTime()) then
            client:EmitSound("pda/da-2_beep1.wav")
            client.nextbip = CurTime() + 0.45
          end
        end
          //
        elseif (client:GetPos():Distance(self:GetPos()) <= 90 and client:GetPos():Distance(self:GetPos()) >= 81) then
          //
           if (client:Health() > 0) then
          if (!client.nextbip2 or client.nextbip2 < CurTime()) then
            client:EmitSound("pda/da-2_beep1.wav")
            client.nextbip2 = CurTime() + 0.2
          end
        end
          //
        elseif (client:GetPos():Distance(self:GetPos()) <= 80) then
          //
           if (client:Health() > 0) then
          if (!client.nextbip3 or client.nextbip3 < CurTime()) then
            client:EmitSound("pda/da-2_beep1.wav")
            client.nextbip3 = CurTime() + 0.05
          end
        end
          //
        end
        ///
      end
      ///
  end
end