AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Пар"
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
	anompar(self)
		if (self:getNetVar("start") == false) then
			if (!self.Timer2 or self.Timer2 < CurTime()) then
				ParticleEffect("jarkassk_0", self:GetPos()-Vector(math.random(-5,5),math.random(-5,5),math.random(-10,0)), Angle(0,0,0), nil)
				self.Timer2 = CurTime() + 2.5
			end
		elseif (self:getNetVar("start") == true) then
			if (!self.Timer or self.Timer < CurTime()) then
				ParticleEffect("parssk", self:GetPos()-Vector(0,0,math.random(-20,0)), Angle(0,0,0), nil)
				self.Timer = CurTime() + 0.1
			end
		end
end


else

	function ENT:Draw()
		self:DrawModel()
	end

end

function anompar(ent)
  local self = ent
    if (self:getNetVar("start") == false) then
      if (!self.idle or self.idle < CurTime()) then
        self:EmitSound( "anomaly/steam_idle.wav" )
        self.idle = CurTime() + 8
      end
    end
    if (!self.hits or self.hits < CurTime()) then
      self:setNetVar("start", false)
    end
    ////////////////////////////
    for k, v in pairs( ents.FindInSphere( self:GetPos(), 120 ) ) do
    if (v:GetModel() == "models/weapons/ssk/spenser/w_ssk_bolt.mdl" or v:GetClass() == "nut_f1" or v:GetClass() == "nut_rgd" or v:GetClass() == "nut_item") then
      if (self:getNetVar("start") == false) then
        if (!self.hits or self.hits < CurTime()) then
          self:EmitSound("anomaly/steam_blowout.wav")
          self:setNetVar("start", true)
          local Light = ents.Create("light_dynamic")
          Light:SetKeyValue("_light", "190 190 190")
          Light:SetKeyValue("distance", "1300")
          Light:SetKeyValue("_cone", "0")
          Light:SetPos(self:GetPos())
          Light:SetParent(self)
          Light:Spawn()
          Light:Activate()
          Light:Fire("SetParentAttachment", "light", 0)
          Light:Fire("TurnOn", "", 0) 
          Light:Fire("TurnOff", "", 10)
          self.hits = CurTime() + 10
        end       
      end
    end
      if (v:GetPos():Distance(self:GetPos()) <= 75) then
        if (v:IsValid() and v:GetPhysicsObject():IsValid()) then
          if (v:IsPlayer() or v:IsNPC() or (string.find( v:GetClass(), "prop" )) and !v:IsRagdoll()) then
            if (!self.hit or self.hit < CurTime()) then
              v:TakeDamage(10)  
              self:EmitSound("anomaly/steam_hit.wav")
            if (!self.hits or self.hits < CurTime()) then
              self:EmitSound("anomaly/steam_blowout.wav")
              self:setNetVar("start", true)
              local Light = ents.Create("light_dynamic")
              Light:SetKeyValue("_light", "190 190 190")
              Light:SetKeyValue("distance", "1300")
              Light:SetKeyValue("_cone", "0")
              Light:SetPos(self:GetPos())
              Light:SetParent(self)
              Light:Spawn()
              Light:Activate()
              Light:Fire("SetParentAttachment", "light", 0)
              Light:Fire("TurnOn", "", 0) 
              Light:Fire("TurnOff", "", 10)
              self.hits = CurTime() + 10
            end
            self.hit = CurTime() + .5
          end
        end           
      end         
    end 
if (!self.id or self.id < CurTime()) then
  if (self:getNetVar("start") == false) then
    if (math.random(1, 100) > 80) then
      if (!self.hits or self.hits < CurTime()) then
        self:EmitSound("anomaly/steam_blowout.wav")
        self:setNetVar("start", true)
        local Light = ents.Create("light_dynamic")
        Light:SetKeyValue("_light", "190 190 190")
        Light:SetKeyValue("distance", "1300")
        Light:SetKeyValue("_cone", "0")
        Light:SetPos(self:GetPos())
        Light:SetParent(self)
        Light:Spawn()
        Light:Activate()
        Light:Fire("SetParentAttachment", "light", 0)
        Light:Fire("TurnOn", "", 0) 
        Light:Fire("TurnOff", "", 10)
        self.hits = CurTime() + 10    
      end
    end
  end
  self.id = CurTime() + math.random(10, 20)
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
  /// 
end       
end