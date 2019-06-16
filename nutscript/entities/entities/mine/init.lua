AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
self:SetMoveType( MOVETYPE_NONE )
self:SetSolid( SOLID_NONE )
self:SetModel("models/hardbass/bomb_c4.mdl")
self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
self:SetTrigger( true )
self:SetNotSolid( true )
self:DrawShadow( false )
self:SetCollisionBounds( Vector( -100, -100, -100 ), Vector( 100, 100, 100 ) )
self:PhysicsInitBox( Vector( -100, -100, -100 ), Vector( 100, 100, 100 ) )
end


function ENT:Think()
local viewSphere = ents.FindInSphere( self:GetPos(), 1000 )
for i, v in pairs( viewSphere ) do
	if (v:IsPlayer()) then
		if (self:GetPos():Distance( v:GetPos() ) < 900) then
			for k, v in pairs( ents.FindInSphere( self:GetPos(), 25 ) ) do
				if !IsValid( v ) then continue end
				local all = v
				if (string.find( all:GetClass(), "prop" ) or all:IsPlayer() or all:IsNPC() or v:GetModel() == "models/hardbass/safe_container.mdl") then
					if (!self.next or self.next < CurTime()) then
						if (all:IsValid()) then
							self:EmitSound("ssk/weapons/mine_on.wav")
							self.next = CurTime() + 5
						end
					end
						if (all:IsPlayer() or all:IsNPC()) then
							local effectData = EffectData()
							effectData:SetStart( self:GetPos() )
							effectData:SetOrigin( self:GetPos() )
							effectData:SetScale(0.2)
							util.Effect("HelicopterMegaBomb", effectData, true, true)
							self:EmitSound("ssk/weapons/f1_explode.wav")
							if (all:IsPlayer()) then
								--[[local DMG = 0
								local hit_anom_power = 1.5
								local hit_fraction_ex = 1--client:GetNetVar("zaza_ex")
								DMG = hit_anom_power*hit_fraction_ex*100]]
								all:TakeDamage(80)
							end
						self:Remove()
						end
				end
			end
		else
			return
		end
	end
end
end

function ENT:UpdateTransmitState()
return TRANSMIT_ALWAYS 
end