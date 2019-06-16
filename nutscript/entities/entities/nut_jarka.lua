AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Жарка"
ENT.Author = "Spenser"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "STALKER"
ENT.RenderGroup 		= RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_c17/FurnitureDrawer001a_Shard01.mdl")
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
	jarkaanom(self)
		if (self:getNetVar("start") == false) then
			if (!self.Timer2 or self.Timer2 < CurTime()) then
				ParticleEffect("jarkassk_0", self:GetPos()-Vector(math.random(-5,5),math.random(-5,5),math.random(-10,0)), Angle(0,0,0), nil)
				self.Timer2 = CurTime() + 1.5
			end
		elseif (self:getNetVar("start") == true) then
			if (!self.Timer or self.Timer < CurTime()) then
				ParticleEffect("jarkassk_2", self:GetPos()-Vector(0,0,math.random(-20,0)), Angle(0,0,0), nil)
				ParticleEffect("jarkassk_2_0", self:GetPos()-Vector(0,0,-100), Angle(0,0,0), nil)
				self.Timer = CurTime() + 0.1
			end
		end
end


else

	function ENT:Draw()
		self:DrawModel()
	end

end

function jarkaanom(ent)
  local self = ent
    if (self:getNetVar("start") == false) then
      if (!self.idle or self.idle < CurTime()) then
        self:EmitSound( "anomaly/fire_idle.wav" )
        self.idle = CurTime() + 8
      end
    end
    if (!self.hits or self.hits < CurTime()) then
      self:setNetVar("start", false)
    end
    ////////////////////////////
    for k, v in pairs( ents.FindInSphere( self:GetPos(), 110 ) ) do
          //Труп//
        if (v:GetPos():Distance(self:GetPos()) <= 75) then
          if (v:IsRagdoll()) then
              if (v:GetModel() == "models/spenser/ssk/new_band_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_band_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_band_02a_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_band_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_band_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_band_05_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_dolg_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_dolg_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_dolg_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_dolg_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_ecolog_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_free_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_free_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_free_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_free_04_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_merc_01_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_merc_01a_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_merc_02_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_merc_03_spen.mdl" or
              v:GetModel() == "models/spenser/ssk/new_merc_04_spen.mdl" or
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
              v:GetModel() == "models/spenser/ssk/new_sviter_spen.mdl") then
              local rag = v
              if (!v:IsOnFire()) then
                v:Ignite(5) 
              end
              if (!self.hits or self.hits < CurTime()) then
                self:EmitSound("anomaly/zhar_blow.wav")
                self:setNetVar("start", true)
                self.hits = CurTime() + 12
              end
                if (!rag.ef or rag.ef < CurTime()) then
              timer.Simple(5, function()    
                local trup = ents.Create("prop_ragdoll")
                trup:SetPos(v:GetPos())
                trup:SetModel(Format("models/Humans/Charple0%d.mdl",math.random(1,4)))
                trup:Spawn()
                trup:Activate()
                trup:Ignite(math.random(5, 10))
                v:Remove()
              end)
                rag.ef = CurTime() + 5
              end
            end
          end
        end
          ///
    if (v:GetModel() == "models/weapons/ssk/spenser/w_ssk_bolt.mdl" or v:GetClass() == "nut_f1" or v:GetClass() == "nut_rgd") then
      if (self:getNetVar("start") == false) then
        if (!self.hits or self.hits < CurTime()) then
          self:EmitSound("anomaly/zhar_blow.wav")
          self:setNetVar("start", true)
          self.hits = CurTime() + 12
        end       
      end
      if (self:getNetVar("start") == true) then
      if (!v:IsOnFire()) then
        v:Ignite(math.random(3, 6)) 
      end
      end
    end
      if (v:GetPos():Distance(self:GetPos()) <= 75) then
          if (v:GetClass() == "ssk_dog" or v:GetClass() == "ssk_boar_s" or v:GetClass() == "ssk_boar_m" or v:GetClass() == "ssk_tush" or v:GetClass() == "ssk_flash_s" or v:GetClass() == "ssk_flash_m" or v:GetClass() == "ssk_krovo_m" or v:GetClass() == "ssk_krovo_s" or v:GetClass() == "ssk_krovo_e" or v:GetClass() == "ssk_snork" or v:GetClass() == "ssk_izlom" or v:GetClass() == "ssk_zombie" or v:GetClass() == "ssk_himera") then
            local all = v
              all:TakeDamage(all:Health())
              if (all:GetModel() == "models/spenser/ssk/new_dog_spen.mdl") then
                all:EmitSound( "mutants/ssk/dog/bdog_die_" .. math.random( 0, 2 ) .. ".mp3" )  
              elseif (all:GetModel() == "models/spenser/ssk/new_boar_spen.mdl") then
                all:EmitSound( "mutants/ssk/boar/boar_anomaly_2.mp3" )  
              elseif (all:GetClass() == "ssk_tush") then
                 all:EmitSound( "mutants/ssk/tushkano/tushkano_death_"..math.random( 0, 2 )..".mp3" )
              elseif (all:GetClass() == "ssk_flash") then
                all:EmitSound( "mutants/ssk/flesh/flesh_anomaly_death_0.mp3" )
              end
              all:Ignite(3)
            if (!self.hits or self.hits < CurTime()) then
              self:EmitSound("anomaly/zhar_blow.wav")
              self:setNetVar("start", true)
              self.hits = CurTime() + 12
            end
            self.hit = CurTime() + .5
          end
        if (v:IsValid() and v:GetPhysicsObject():IsValid()) then
          if (v:IsPlayer() or v:IsNPC() or (string.find( v:GetClass(), "prop" ) or v:GetClass() == "ssk_dog" or v:GetClass() == "ssk_boar_s" or v:GetClass() == "ssk_boar_m" or v:GetClass() == "ssk_tush" or v:GetClass() == "ssk_flash_s" or v:GetClass() == "ssk_flash_m" or v:GetClass() == "ssk_krovo_m" or v:GetClass() == "ssk_krovo_s" or v:GetClass() == "ssk_krovo_e" or v:GetClass() == "ssk_snork" or v:GetClass() == "ssk_izlom" or v:GetClass() == "ssk_zombie" or v:GetClass() == "ssk_himera") and !v:IsRagdoll()) then
            if (!self.hit or self.hit < CurTime()) then
            v:TakeDamage(3) 
            if (!v:IsOnFire()) then
              v:Ignite(math.random(3, 6)) 
            end
            if (!self.hits or self.hits < CurTime()) then
              self:EmitSound("anomaly/zhar_blow.wav")
              self:setNetVar("start", true)
              self.hits = CurTime() + 12
            end
            self.hit = CurTime() + .5
end
end           
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