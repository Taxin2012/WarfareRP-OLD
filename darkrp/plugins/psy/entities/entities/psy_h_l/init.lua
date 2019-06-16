AddCSLuaFile( "shared.lua" )
include('shared.lua')
local range = 2048
local psyamount = 50
function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:OnRemove()
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" ) --Set its model.
	//self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_NONE ) 	-- Toolbox
	self.Entity:SetKeyValue("rendercolor", "150 255 150")
	self.Entity:SetKeyValue("renderamt", "0")
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	self.Entity:SetPersistent(true)
        local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end
local delayTime = CurTime()


function ENT:Think()
	if !delayTime or delayTime < CurTime() then
		for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 2560 )  ) do
			if v:IsPlayer() and v:IsValid() then
				if !v:getChar() then return end
				if v:Team() == FACTION_MONOLIT or v:Team() == FACTION_GREH then return end
				if (v:getNetVar("psihelem", 0) == 1) then return end
				--if (v:getChar():getInv():hasItem("psihelem")) then return end
				if v:GetPos( ):Distance( self:GetPos( ) ) <= range then
						if (v:Health() > 0) then
							v:addPSY(5)
						end	
				if (!v.timepsys or v.timepsys < CurTime()) then
					v:EmitSound("interface/psysoundlul.mp3") --звук ПСИ
					v.timepsys = CurTime() + 16 --Цифра время звука пси
				end						
				elseif v:GetPos( ):Distance( self:GetPos( ) ) <= range + 256 then
					v:setNetVar("psyE", false)
				end
				----
			end
		end
		delayTime = CurTime() + .75
	end
end

function ENT:Use( activator, caller, type, value )
end

function ENT:KeyValue( key, value )
end

function ENT:OnTakeDamage( dmginfo )
end

function ENT:StartTouch( entity )
end

function ENT:EndTouch( entity )
end

function ENT:Touch( entity )
end


---------------[[AddCSLuaFile( "cl_init.lua" )
--[[AddCSLuaFile( "shared.lua" )
include('shared.lua')

local delayTime = 0
local range = 1024
local psyamount = 6

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:OnRemove()
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" ) --Set its model.
	//self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_NONE ) 	-- Toolbox
	self.Entity:SetKeyValue("rendercolor", "150 255 150")
	self.Entity:SetKeyValue("renderamt", "0")
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	self.Entity:SetPersistent(true)
        local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Think()
	if !delayTime or delayTime < CurTime() then
		for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 2560 )  ) do
			if v:IsPlayer() and v:IsValid() then
				if !v:getChar() then return end
				if v:Team() == FACTION_MONOLIT or v:Team() == FACTION_GREH then return end
				local items = v:getChar():getInv():hasItem("psihelem")
				if v:GetPos( ):Distance( self:GetPos( ) ) <= range then
						if (v:Health() > 0) then
							v:addPSY(5)
						end	
						if !items then
						local TEMP_TargetDamage = DamageInfo()
								
							TEMP_TargetDamage:SetDamage(psyamount)
							TEMP_TargetDamage:SetInflictor(self)
							TEMP_TargetDamage:SetDamageType(DMG_GENERIC)
							TEMP_TargetDamage:SetAttacker(self)

							v:TakeDamageInfo(TEMP_TargetDamage)
						end
				if (!v.timepsys or v.timepsys < CurTime()) then
					v:EmitSound("interface/psysoundlul.mp3") --звук ПСИ
					v.timepsys = CurTime() + 16 --Цифра время звука пси
				end						
				elseif v:GetPos( ):Distance( self:GetPos( ) ) <= range + 256 then
					v:setNetVar("psyE", false)
				end
				----
			end
		end
		delayTime = CurTime() + .75
	end
end

function ENT:Use( activator, caller, type, value )
end

function ENT:KeyValue( key, value )
end

function ENT:OnTakeDamage( dmginfo )
end

function ENT:StartTouch( entity )
end

function ENT:EndTouch( entity )
end

function ENT:Touch( entity )
end
]]