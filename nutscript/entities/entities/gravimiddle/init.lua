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
	local SpawnPos = tr.HitPos + tr.HitNormal * 20
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

	function ENT:Think()
		anomgravimid(self)
	end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS 
end

function anomgravimid(ent)
  local self = ent
  self:setNetVar("eff1", "effects/leaves")
  self:setNetVar("eff3", "effects/pfx_anomaly3")
  self:setNetVar("eff2", "effects/pfx_anomaly1")
  self:setNetVar("eff4", "effects/pfx_anomaly1")
   self:setNetVar("eff5", "effects/pfx_anomaly2")
    self:setNetVar("sound1", "anomaly/gravi_hit.wav")
    local vec = Vector(  math.random( -25, 25 ),  math.random( -25, 25 ), math.random( 15, 35 ) )
    self:setNetVar("vec", vec)
      local vec = VectorRand()
      vec.z = -0.1  
      local newpos = self:GetPos() + vec * 55
      self:setNetVar("pos", newpos)
      local vec = VectorRand()
      vec.z = -0.1  
      local newpos2 = self:GetPos()+Vector(0,0,60) + vec * 400 
      self:setNetVar("pos2", newpos2)
    ////////Звуки спокойствия Аномалии//////
    if (self:getNetVar("start") == false) then
      if (!self.idle or self.idle < CurTime()) then
        self:EmitSound( Format("anomaly/gravi_idle%d.wav", math.random(1, 2)))
        self.idle = CurTime() + 4
      end
      if (!self.idleEF or self.idleEF < CurTime()) then
        ParticleEffect("gravyanomssk_1", self:GetPos()+Vector(math.random( -5, 5 ),math.random( -5, 5 ),math.random( -20, -10 )), Angle(0,0,0), nil) 
        self.idleEF = CurTime() + 2.5
      end
      if (!self.idleEF2 or self.idleEF2 < CurTime()) then
        ParticleEffect("leavesssk_r_1", self:GetPos()+Vector(math.random( -5, 5 ),math.random( -5, 5 ),math.random( -5, 0 )), Angle(0,0,0), nil) 
        self.idleEF2 = CurTime() + 4.5
      end
    end
    ///////////////////////////////////////
    ////////////Начало/////////////
    for k, v in pairs( ents.FindInSphere( self:GetPos(), 160 ) ) do 
      /////////////////УРОН И ЭФФЕКТЫ ИГРОКУ/////////////
      if (v:IsPlayer() and v:Health() > 0 or v:IsNPC() or v:GetClass() == "ssk_dog" or v:GetClass() == "ssk_boar_s" or v:GetClass() == "ssk_boar_m" or v:GetClass() == "ssk_tush" or v:GetClass() == "ssk_flash_s" or v:GetClass() == "ssk_flash_m" or v:GetClass() == "ssk_krovo_m" or v:GetClass() == "ssk_krovo_s" or v:GetClass() == "ssk_krovo_e" or v:GetClass() == "ssk_snork" or v:GetClass() == "ssk_izlom" or v:GetClass() == "ssk_zombie" or v:GetClass() == "ssk_himera" or v:GetClass() == "ssk_krovo_m" or v:GetClass() == "ssk_krovo_s" or v:GetClass() == "ssk_krovo_e" or v:GetClass() == "ssk_snork" or v:GetClass() == "ssk_izlom" or v:GetClass() == "ssk_zombie" or v:GetClass() == "ssk_himera") then
        if (v:GetPos():Distance(self:GetPos()) >= 120) then v:setNetVar("gravi", false) end     
        if (v:GetPos():Distance(self:GetPos()) <= 115) then
           if (v:GetClass() == "npc_mutant_bloodsucker" or v:GetClass() == "npc_mutant_dog" or v:GetClass() == "ssk_boar_m" or v:GetClass() == "ssk_tush" or v:GetClass() == "ssk_flash_s" or v:GetClass() == "ssk_flash_m" or v:GetClass() == "ssk_krovo_m" or v:GetClass() == "ssk_krovo_s" or v:GetClass() == "ssk_krovo_e" or v:GetClass() == "ssk_snork" or v:GetClass() == "ssk_izlom" or v:GetClass() == "ssk_zombie" or v:GetClass() == "ssk_himera") then
            local all = v
              local rag = ents.Create("prop_ragdoll")
              rag:SetPos(all:GetPos())
              rag:SetModel(all:GetModel())
              rag:Spawn()
              rag:Activate()
              if (all:GetModel() == "models/stalkermodels/animals/stalker_big.mdl") then
                all:EmitSound( "mutants/ssk/dog/bdog_die_" .. math.random( 0, 2 ) .. ".mp3" )  
              elseif (all:GetModel() == "models/wick/stalker/zombied/wick_anim_test2.mdl") then
                all:EmitSound( "mono/help_" .. math.random( 1, 9 ) .. ".wav" )  
              elseif (all:GetClass() == "ssk_tush") then
                 all:EmitSound( "mutants/ssk/tushkano/tushkano_death_"..math.random( 0, 2 )..".mp3" )
              elseif (all:GetModel() == "models/spenser/ssk/new_flesh_spen.mdl") then
                all:EmitSound( "mutants/ssk/flesh/flesh_anomaly_death_0.mp3" )
              end
              all:Remove()
          end
          if (v:IsPlayer()) then
            v:setNetVar("gravi", true)
          end
          ////Гравитация///
          local vel = ( self:GetPos() - v:GetPos() ):GetNormal()
          local scale = math.Clamp( ( 100 - v:GetPos():Distance( self:GetPos() ) ) / 100, 0.2, 1.0 )
          v:SetVelocity( vel * ( scale * 590 ) )
          /////////Эффекты/////
        //////////Вкл. Анамалия////////////
    if (!self.surge or self.surge < CurTime()) then
      self:EmitSound("anomaly/gravi_start.wav")
      self:setNetVar("start", true)
       ParticleEffect("gravyanomssk_1_s", self:GetPos(), Angle(0,0,0), nil) 
       ParticleEffect("leavesssk_r_4_s", self:GetPos(), Angle(0,0,0), nil) 
      timer.Simple(2.15, function()
        self:setNetVar("start3", true)
      end)
      timer.Simple(2.3, function()
          ////////Урон//////
        if (v:IsValid() and v:GetPos():Distance(self:GetPos()) <= 120 and v:Health() > 0) then
          if (v:IsPlayer()) then
            v:TakeDamage(math.random(35, 45)) -- Player Damage
          elseif (v:IsNPC()) then
            v:TakeDamage(v:Health())-- NPC Dead
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
      Light:Fire("TurnOn", "", 1) 
      Light:Fire("TurnOff", "", 1.4)  
          self:setNetVar("start", false)
          self:setNetVar("start3", false)
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
        self.surge = CurTime() + 2.3
    end 
        //////////////////////////////////
        end
      end
      ///////////Если проп//////////
      if (v:IsValid() and v:GetPhysicsObject():IsValid() and (!self.hit or self.hit < CurTime())) then
        if (string.find( v:GetClass(), "prop" )) then
          if (v:GetPos():Distance(self:GetPos()) <= 120) then 
              if (!v:IsRagdoll()) then
              local dir = ( self:GetPos() - v:GetPos() + Vector(0, 0, 50) ):GetNormal()
              local force = 270
              local distance = dir:Length()
              local maxdistance = 160 
              local ratio = math.Clamp( (1 - (distance/maxdistance)), 0, 1 )
              local vForce = -1*dir * (force * ratio)
              local phys = v:GetPhysicsObject()
              if (!v:IsRagdoll()) then
                phys:ApplyForceCenter( -dir * phys:GetMass() * 740 )
              end
              self.hit = CurTime() + 1 
            end
          end
        end
      end
      ////////Вращение если рэгдолл///////////
    if (v:GetPos():Distance(self:GetPos()) <= 110) then
      if (v:IsValid() and v:GetPhysicsObject():IsValid() and v:IsRagdoll()) then
        local vel = ( self:GetPos()+Vector(0, 0, 10)*2 - v:GetPos() ):GetNormal()
        local phys = v:GetPhysicsObject()
        phys:ApplyForceCenter( vel * ( phys:GetMass() * 1050 ) )
      /////////////////
      ////////////////
    if (!self.surge or self.surge < CurTime()) then
      self:EmitSound("anomaly/gravi_start.wav")
      self:setNetVar("start", true)
      timer.Simple(2.15, function()
        self:setNetVar("start3", true)
      end)
      timer.Simple(2.3, function() -- Таймер
        if (v:IsValid() and v:IsRagdoll() and v:GetPos():Distance(self:GetPos()) <= 120) then
      //////////Кровь от тела//////
        local vPoint = v:GetPos() + Vector(math.random(-10,10),math.random(-10,10),math.random(0,5))
        ParticleEffect("Blood_splashssk", vPoint, Angle(0,0,0), nil)
        ParticleEffect("Blood_goressk", vPoint, Angle(0,0,0), nil)
      ////////////////////////
      /////На земле кровь/////
      util.Decal( "blood", v:GetPos() + Vector(-math.random(1,10),-math.random(1,10),-1), v:GetPos() - Vector(math.random(1,10),math.random(1,10),50))
      util.Decal( "blood", v:GetPos() + Vector(-math.random(15,25),-math.random(15,25),-1), v:GetPos() - Vector(math.random(15,25),math.random(15,25),50))
      util.Decal( "blood", v:GetPos() + Vector(-math.random(25,35),-math.random(25,35),-1), v:GetPos() - Vector(math.random(25,35),math.random(25,35),50))
      util.Decal( "blood", v:GetPos() + Vector(-math.random(25,35),-math.random(25,35),-1), v:GetPos() - Vector(math.random(25,35),math.random(25,35),50))
      util.Decal( "blood", v:GetPos() + Vector(math.random(1,10),math.random(1,10),-1), v:GetPos() - Vector(math.random(1,10),math.random(1,10),50))
      util.Decal( "blood", v:GetPos() + Vector(math.random(15,25),math.random(15,25),-1), v:GetPos() - Vector(-math.random(15,25),-math.random(15,25),50))
      util.Decal( "blood", v:GetPos() + Vector(math.random(25,35),math.random(25,35),-1), v:GetPos() - Vector(-math.random(25,35),-math.random(25,35),50))
      util.Decal( "blood", v:GetPos() + Vector(math.random(25,35),math.random(25,35),-1), v:GetPos() - Vector(-math.random(25,35),-math.random(25,35),50))
      util.Decal( "blood", v:GetPos() + Vector(-math.random(1,10),-math.random(1,10),-1), v:GetPos() - Vector(math.random(1,10),math.random(1,10),50))
      util.Decal( "blood", v:GetPos() + Vector(-math.random(15,25),-math.random(15,25),-1), v:GetPos() - Vector(math.random(15,25),math.random(15,25),50))
      util.Decal( "blood", v:GetPos() + Vector(-math.random(25,35),-math.random(25,35),-1), v:GetPos() - Vector(math.random(25,35),math.random(25,35),50))
      util.Decal( "blood", v:GetPos() + Vector(-math.random(25,35),-math.random(25,35),-1), v:GetPos() - Vector(math.random(25,35),math.random(25,35),50))
      util.Decal( "blood", v:GetPos() + Vector(math.random(1,10),math.random(1,10),-1), v:GetPos() - Vector(math.random(1,10),math.random(1,10),50))
      util.Decal( "blood", v:GetPos() + Vector(math.random(15,25),math.random(15,25),-1), v:GetPos() - Vector(-math.random(15,25),-math.random(15,25),50))
      util.Decal( "blood", v:GetPos() + Vector(math.random(25,35),math.random(25,35),-1), v:GetPos() - Vector(-math.random(25,35),-math.random(25,35),50))
      util.Decal( "blood", v:GetPos() + Vector(math.random(25,35),math.random(25,35),-1), v:GetPos() - Vector(-math.random(25,35),-math.random(25,35),50))
      //////////////|
      ///Удаление///|
          v:Remove() ///|
          //////////////|
          ////КОсТИ!/////
              if (v:GetModel() == "models/spenser/ssk/new_band_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_band_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_band_02a_spen.mdl" or
			  v:GetModel() == "models/wick/stalker/zombied/wick_anim_test2.mdl" or
              v:GetModel() == "models/spenser/ssk/new_band_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_band_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_band_05_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_dolg_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_dolg_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_dolg_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_dolg_04_spen.mdl" or
               v:GetModel() == "models/spenser/ssk/new_zombi_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_ecolog_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_snork_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_izlom_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_free_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_free_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_free_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_free_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_merc_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_merc_01a_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_ecolog_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_merc_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_merc_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_merc_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_free_05_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_mono_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_mono_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_mono_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_mono_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_nebo_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_nebo_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_nebo_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_nebo_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_nebo_05_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_solder_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_solder_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_solder_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_solder_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_solder_05_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_stalk_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_stalk_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_stalk_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_stalk_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_stalk_05_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_zomb_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_zomb_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_zomb_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_zomb_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_zomb_05_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_krovo_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_sviter_spen.mdl") then
          if (math.random(1, 10) < 9) then
          local bone1 = ents.Create("prop_physics")
          bone1:SetPos(v:GetPos())
          bone1:SetModel("models/bone_stalk1.mdl")
          bone1:Spawn()
          bone1:Activate()
          timer.Simple(10,function ()
          bone1:Remove()
          end)
        end
        if (math.random(1, 10) < 9) then
          local bone2 = ents.Create("prop_physics")
          bone2:SetPos(v:GetPos())
          bone2:SetModel("models/bone_stalk2.mdl")
          bone2:Spawn()
          bone2:Activate()
          timer.Simple(10,function ()
          bone2:Remove()
          end)
        end
        if (math.random(1, 10) < 9) then
          local bone3 = ents.Create("prop_physics")
          bone3:SetPos(v:GetPos())
          bone3:SetModel("models/bone_stalk3.mdl")
          bone3:Spawn()
          bone3:Activate()
          timer.Simple(10,function ()
          bone3:Remove()
          end)
        end    
        if (math.random(1, 10) < 9) then             
          local bone4 = ents.Create("prop_physics")
          bone4:SetPos(v:GetPos())
          bone4:SetModel("models/bone_stalk4.mdl")
          bone4:Spawn()
          bone4:Activate()
          timer.Simple(10,function ()
          bone4:Remove()
          end)
        end   
        if (math.random(1, 10) < 9) then             
          local bone5 = ents.Create("prop_physics")
          bone5:SetPos(v:GetPos())
          bone5:SetModel("models/bone_stalk5.mdl")
          bone5:Spawn()
          bone5:Activate()
          timer.Simple(10,function ()
          bone5:Remove()
          end)
        end  
        if (math.random(1, 10) < 9) then               
          local bone6 = ents.Create("prop_physics")
          bone6:SetPos(v:GetPos())
          bone6:SetModel("models/bone_stalk6.mdl")
          bone6:Spawn()
          bone6:Activate()
          timer.Simple(10,function ()
          bone6:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone7 = ents.Create("prop_physics")
          bone7:SetPos(v:GetPos())
          bone7:SetModel("models/bone_stalk7.mdl")
          bone7:Spawn()
          bone7:Activate()
          timer.Simple(10,function ()
          bone7:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone8 = ents.Create("prop_physics")
          bone8:SetPos(v:GetPos())
          bone8:SetModel("models/bone_stalk8.mdl")
          bone8:Spawn()
          bone8:Activate()
          timer.Simple(10,function ()
          bone8:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone9 = ents.Create("prop_physics")
          bone9:SetPos(v:GetPos())
          bone9:SetModel("models/bone_stalk9.mdl")
          bone9:Spawn()
          bone9:Activate()
          timer.Simple(10,function ()
          bone9:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone10 = ents.Create("prop_physics")
          bone10:SetPos(v:GetPos())
          bone10:SetModel("models/bone_stalk10.mdl")
          bone10:Spawn()
          bone10:Activate()
          timer.Simple(10,function ()
          bone10:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone11 = ents.Create("prop_physics")
          bone11:SetPos(v:GetPos())
          bone11:SetModel("models/bone_stalk11.mdl")
          bone11:Spawn()
          bone11:Activate()
          timer.Simple(10,function ()
          bone11:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone12 = ents.Create("prop_physics")
          bone12:SetPos(v:GetPos())
          bone12:SetModel("models/bone_stalk12.mdl")
          bone12:Spawn()
          bone12:Activate()
          timer.Simple(10,function ()
          bone12:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone13 = ents.Create("prop_physics")
          bone13:SetPos(v:GetPos())
          bone13:SetModel("models/bone_stalk13.mdl")
          bone13:Spawn()
          bone13:Activate()
          timer.Simple(10,function ()
          bone13:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone14 = ents.Create("prop_physics")
          bone14:SetPos(v:GetPos())
          bone14:SetModel("models/bone_stalk14.mdl")
          bone14:Spawn()
          bone14:Activate()
          timer.Simple(10,function ()
          bone14:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone15 = ents.Create("prop_physics")
          bone15:SetPos(v:GetPos())
          bone15:SetModel("models/bone_stalk15.mdl")
          bone15:Spawn()
          bone15:Activate()
          timer.Simple(10,function ()
          bone15:Remove()
          end)
        end 
        if (math.random(1, 10) < 8) then
          local bone18 = ents.Create("prop_physics")
          bone18:SetPos(v:GetPos())
          bone18:SetModel("models/bone_stalk18.mdl")
          bone18:Spawn()
          bone18:Activate()
          timer.Simple(10,function ()
          bone18:Remove()
          end)
        end  
        if (math.random(1, 10) < 8) then
          local bone19 = ents.Create("prop_physics")
          bone19:SetPos(v:GetPos())
          bone19:SetModel("models/bone_stalk19.mdl")
          bone19:Spawn()
          bone19:Activate()
          timer.Simple(10,function ()
          bone19:Remove()
          end)
        end
      elseif (v:GetModel() == "models/spenser/ssk/new_dog_spen.mdl" or v:GetModel() == "models/spenser/ssk/new_psydog_spen.mdl") then
          if (math.random(1, 10) < 9) then
          local bone1 = ents.Create("prop_physics")
          bone1:SetPos(v:GetPos())
          bone1:SetModel("models/bone_dog1.mdl")
          bone1:Spawn()
          bone1:Activate()
          timer.Simple(10,function ()
          bone1:Remove()
          end)
        end
        if (math.random(1, 10) < 9) then
          local bone2 = ents.Create("prop_physics")
          bone2:SetPos(v:GetPos())
          bone2:SetModel("models/bone_dog2.mdl")
          bone2:Spawn()
          bone2:Activate()
          timer.Simple(10,function ()
          bone2:Remove()
          end)
        end
        if (math.random(1, 10) < 9) then
          local bone3 = ents.Create("prop_physics")
          bone3:SetPos(v:GetPos())
          bone3:SetModel("models/bone_dog3.mdl")
          bone3:Spawn()
          bone3:Activate()
          timer.Simple(10,function ()
          bone3:Remove()
          end)
        end    
        if (math.random(1, 10) < 9) then             
          local bone4 = ents.Create("prop_physics")
          bone4:SetPos(v:GetPos())
          bone4:SetModel("models/bone_dog4.mdl")
          bone4:Spawn()
          bone4:Activate()
          timer.Simple(10,function ()
          bone4:Remove()
          end)
        end   
        if (math.random(1, 10) < 9) then             
          local bone5 = ents.Create("prop_physics")
          bone5:SetPos(v:GetPos())
          bone5:SetModel("models/bone_dog5.mdl")
          bone5:Spawn()
          bone5:Activate()
          timer.Simple(10,function ()
          bone5:Remove()
          end)
        end  
        if (math.random(1, 10) < 9) then               
          local bone6 = ents.Create("prop_physics")
          bone6:SetPos(v:GetPos())
          bone6:SetModel("models/bone_dog6.mdl")
          bone6:Spawn()
          bone6:Activate()
          timer.Simple(10,function ()
          bone6:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone7 = ents.Create("prop_physics")
          bone7:SetPos(v:GetPos())
          bone7:SetModel("models/bone_dog7.mdl")
          bone7:Spawn()
          bone7:Activate()
          timer.Simple(10,function ()
          bone7:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone8 = ents.Create("prop_physics")
          bone8:SetPos(v:GetPos())
          bone8:SetModel("models/bone_dog8.mdl")
          bone8:Spawn()
          bone8:Activate()
          timer.Simple(10,function ()
          bone8:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone10 = ents.Create("prop_physics")
          bone10:SetPos(v:GetPos())
          bone10:SetModel("models/bone_dog10.mdl")
          bone10:Spawn()
          bone10:Activate()
          timer.Simple(10,function ()
          bone10:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone11 = ents.Create("prop_physics")
          bone11:SetPos(v:GetPos())
          bone11:SetModel("models/bone_dog11.mdl")
          bone11:Spawn()
          bone11:Activate()
          timer.Simple(10,function ()
          bone11:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone12 = ents.Create("prop_physics")
          bone12:SetPos(v:GetPos())
          bone12:SetModel("models/bone_dog12.mdl")
          bone12:Spawn()
          bone12:Activate()
          timer.Simple(10,function ()
          bone12:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone13 = ents.Create("prop_physics")
          bone13:SetPos(v:GetPos())
          bone13:SetModel("models/bone_dog13.mdl")
          bone13:Spawn()
          bone13:Activate()
          timer.Simple(10,function ()
          bone13:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone14 = ents.Create("prop_physics")
          bone14:SetPos(v:GetPos())
          bone14:SetModel("models/bone_dog14.mdl")
          bone14:Spawn()
          bone14:Activate()
          timer.Simple(10,function ()
          bone14:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone15 = ents.Create("prop_physics")
          bone15:SetPos(v:GetPos())
          bone15:SetModel("models/bone_dog15.mdl")
          bone15:Spawn()
          bone15:Activate()
          timer.Simple(10,function ()
          bone15:Remove()
          end)
        end 
        if (math.random(1, 10) < 8) then
          local bone18 = ents.Create("prop_physics")
          bone18:SetPos(v:GetPos())
          bone18:SetModel("models/bone_dog18.mdl")
          bone18:Spawn()
          bone18:Activate()
          timer.Simple(10,function ()
          bone18:Remove()
          end)
        end  
        if (math.random(1, 10) < 8) then
          local bone19 = ents.Create("prop_physics")
          bone19:SetPos(v:GetPos())
          bone19:SetModel("models/bone_dog19.mdl")
          bone19:Spawn()
          bone19:Activate()
          timer.Simple(10,function ()
          bone19:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone20 = ents.Create("prop_physics")
          bone20:SetPos(v:GetPos())
          bone20:SetModel("models/bone_dog20.mdl")
          bone20:Spawn()
          bone20:Activate()
          timer.Simple(10,function ()
          bone20:Remove()
          end)
        end
        if (math.random(1, 10) < 8) then
          local bone17 = ents.Create("prop_physics")
          bone17:SetPos(v:GetPos())
          bone17:SetModel("models/bone_dog17.mdl")
          bone17:Spawn()
          bone17:Activate()
          timer.Simple(10,function ()
          bone17:Remove()
          end)
        end
      end
          /////////////
          ///Звук мяса///
          self:EmitSound("anomaly/boby_dead.wav")

          //////////////
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
      Light:Fire("TurnOn", "", 1) 
      Light:Fire("TurnOff", "", 1.4)  
          self:setNetVar("start", false)
      self:setNetVar("start3", false)
      local pos = self:GetPos() + Vector( 0, 0, 7)
      local effectdata = EffectData()
            effectdata:SetStart( self:GetPos() + Vector( 0, 0, 7 )) 
            effectdata:SetOrigin( self:GetPos() + Vector( 0, 0, 7 ))
      effectdata:SetScale( 260 )
      effectdata:SetRadius( 1 )
      effectdata:SetMagnitude( 1 )
            util.Effect( "ThumperDust", effectdata ) 
            ////////////////////////////////////////
      end)
    self.surge = CurTime() + 2.3
  end 
  end
  end
      if (v:IsPlayer()) then
        ///
        local client = v
        if (client:GetPos():Distance(self:GetPos()) <= 160 and client:GetPos():Distance(self:GetPos()) >= 101) then
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