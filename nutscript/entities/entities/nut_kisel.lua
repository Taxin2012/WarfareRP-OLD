AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Холодец"
ENT.Author = "Spenser"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "STALKER"
ENT.RenderGroup 		= RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_c17/FurnitureDrawer001a_Shard01.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetNoDraw(true)
		self:SetUseType(SIMPLE_USE)
		self:SetMoveType( MOVETYPE_NONE )
		self:DrawShadow( false )
		self:SetSolid( SOLID_NONE )
        self:SetMaterial("models/effects/vol_light001")
		self:setNetVar("start", false)
	end

function ENT:Think()
	kiselanom(self)
    if (!self.Timer or self.Timer < CurTime()) then
      local vPoint = self:GetPos()
      ParticleEffect("kiselssk_0", vPoint, Angle(0,0,0), nil)  
      self.Timer = CurTime() + 0.75
    end 
end


else

	function ENT:Draw()
		self:DrawModel()
	end

end

function kiselanom(ent)
  local self = ent
    if (!self.idlesound or self.idlesound < CurTime()) then
      self:EmitSound("anomaly/buzz_idle.wav")
      self.idlesound = CurTime() + 5
    end
    /////////////////////////
    for k, v in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do 
      if ( (v:IsPlayer() or v:IsNPC() or v:GetClass() == "ssk_dog" or v:GetClass() == "ssk_boar_s" or v:GetClass() == "ssk_boar_m" or v:GetClass() == "ssk_tush" or v:GetClass() == "ssk_flash_s" or v:GetClass() == "ssk_flash_m" or v:GetClass() == "ssk_krovo_m" or v:GetClass() == "ssk_krovo_s" or v:GetClass() == "ssk_krovo_e" or v:GetClass() == "ssk_snork" or v:GetClass() == "ssk_izlom" or v:GetClass() == "ssk_zombie" or v:GetClass() == "ssk_himera") and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 80 and v:Health() > 0 or ((v:GetModel() == "models/weapons/ssk/spenser/w_ssk_bolt.mdl" or v:GetClass() == "nut_f1" or v:GetClass() == "nut_rgd") and v:GetPos( ):Distance( self:GetPos( ) ) <= 70)) then
        if (!self.effect or self.effect < CurTime()) then
///
          if (v:GetClass() == "npc_mutant_bloodsucker" or v:GetClass() == "ssk_boar_s" or v:GetClass() == "ssk_boar_m" or v:GetClass() == "ssk_tush" or v:GetClass() == "ssk_flash_s" or v:GetClass() == "ssk_flash_m" or v:GetClass() == "ssk_krovo_m" or v:GetClass() == "ssk_krovo_s" or v:GetClass() == "ssk_krovo_e" or v:GetClass() == "ssk_snork" or v:GetClass() == "ssk_izlom" or v:GetClass() == "ssk_zombie" or v:GetClass() == "ssk_himera") then
            local all = v
              all:TakeDamage(all:Health())
              if (all:GetModel() == "models/spenser/ssk/new_renegat_01_spen.mdl") then
                all:EmitSound( "band/help_" .. math.random( 1, 7 ) .. ".wav" )  
              elseif (all:GetModel() == "models/spenser/ssk/new_boar_spen.mdl") then
                all:EmitSound( "mutants/ssk/boar/boar_anomaly_2.mp3" )  
              elseif (all:GetClass() == "ssk_tush") then
                 all:EmitSound( "mutants/ssk/tushkano/tushkano_death_"..math.random( 0, 2 )..".mp3" )
              elseif (all:GetClass() == "ssk_flash") then
                all:EmitSound( "mutants/ssk/flesh/flesh_anomaly_death_0.mp3" )
              end
          end
///
          v:TakeDamage(math.random(35, 45))
          local Light = ents.Create("light_dynamic")
          Light:SetKeyValue("_light", "0 255 0")
          Light:SetKeyValue("distance", "1065")
          Light:SetKeyValue("_cone", "0")
          Light:SetPos(self:GetPos())
          Light:SetParent(self)
          Light:Spawn()
          Light:Activate()
          Light:Fire("SetParentAttachment", "light", 0)
          Light:Fire("TurnOn", "", 0) 
          Light:Fire("Kill", "", 1.5) 
          self:EmitSound("anomaly/buzz_hit.wav")
          self.effect = CurTime() + 2.5
end         
end
      if (self:GetPos():Distance( v:GetPos() ) < 80) then
          v:setNetVar("him4", true)
          v:setNetVar("him3", false)
          v:setNetVar("him2", false)
          v:setNetVar("him1", false)
      elseif (self:GetPos():Distance( v:GetPos() ) < 100 and self:GetPos():Distance( v:GetPos() ) > 90) then
          v:setNetVar("him4", false)
          v:setNetVar("him3", true)
          v:setNetVar("him2", false)
          v:setNetVar("him1", false)
      elseif (self:GetPos():Distance( v:GetPos() ) < 110 and self:GetPos():Distance( v:GetPos() ) > 100) then
          v:setNetVar("him4", false)
          v:setNetVar("him3", true)
          v:setNetVar("him2", false)
          v:setNetVar("him1", false)
      elseif (self:GetPos():Distance( v:GetPos() ) < 120 and self:GetPos():Distance( v:GetPos() ) > 101) then
          v:setNetVar("him4", false)
          v:setNetVar("him3", false)
          v:setNetVar("him2", true)
          v:setNetVar("him1", false)
      elseif (self:GetPos():Distance( v:GetPos() ) < 130 and self:GetPos():Distance( v:GetPos() ) > 121) then
          v:setNetVar("him4", false)
          v:setNetVar("him3", false)
          v:setNetVar("him2", false)
          v:setNetVar("him1", true)
      elseif (self:GetPos():Distance( v:GetPos() ) > 140) then
          v:setNetVar("him4", false)
          v:setNetVar("him3", false)
          v:setNetVar("him2", false)
          v:setNetVar("him1", false)
      end

      if (v:IsPlayer()) then
        ///
        local client = v
        if (client:GetPos():Distance(self:GetPos()) <= 155 and client:GetPos():Distance(self:GetPos()) >= 141) then
          //
           if (client:Health() > 0) then
          if (!client.nextbip or client.nextbip < CurTime()) then
            client:EmitSound("pda/da-2_beep1.wav")
            client.nextbip = CurTime() + 0.5
          end
        end
          //
        elseif (client:GetPos():Distance(self:GetPos()) <= 140 and client:GetPos():Distance(self:GetPos()) >= 101) then
          //
           if (client:Health() > 0) then
          if (!client.nextbip2 or client.nextbip2 < CurTime()) then
            client:EmitSound("pda/da-2_beep1.wav")
            client.nextbip2 = CurTime() + 0.25
          end
        end
          //
        elseif (client:GetPos():Distance(self:GetPos()) <= 100) then
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
///