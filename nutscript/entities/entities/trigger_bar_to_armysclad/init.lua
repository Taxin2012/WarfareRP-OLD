AddCSLuaFile( "shared.lua" )
include('shared.lua')
local range = 2048
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
				if v:GetPos( ):Distance( self:GetPos( ) ) <= range then
							local character = v:getChar()
							if (character) then		
								netstream.Start(v, "receiveNote3", v) --с бара на армейские склады
								if  !v:getChar():getInv():hasItem("bar_armysklad") then
								v:getChar():getInv():add("bar_armysklad")
							end
						end
			end
		end
		delayTime = CurTime() + 5
	end
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
