AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Ф1"
ENT.Author = "Spenser"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "STALKER"

if SERVER then
function ENT:Initialize()   
self.timeleft = CurTime() + 3
self.Owner = self:GetOwner()
self.Entity:SetModel("models/weapons/ssk/spenser/w_ssk_f1.mdl")
self.Entity:SetColor(Color(0,0,0,255))
self.Entity:PhysicsInit( SOLID_VPHYSICS )
self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
self.Entity:SetSolid( SOLID_VPHYSICS )
self.Entity:DrawShadow( false )
self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
self.InFlight = true
local phys = self.Entity:GetPhysicsObject()
if (phys:IsValid()) then
phys:Wake()
phys:SetMass(1)
end
end   

 function ENT:Think()
if CurTime() > self.timeleft then
self:Explosion()
end
self.Entity:NextThink( CurTime() )
end
 
function ENT:Explosion()
local pos = self.Entity:GetPos()
local exp = ents.Create("env_explosion")
exp:SetKeyValue("spawnflags",128)
exp:SetKeyValue("magnitude",75)
exp:SetPos(pos)
exp:Spawn()
exp:Fire("explode","",0)
local exp = ents.Create("env_physexplosion")
exp:SetKeyValue("magnitude",95)
exp:SetPos(pos)
exp:Spawn()
exp:Fire("explode","",0)
self.Entity:Remove()
self.Entity:EmitSound("ssk/weapons/grenade1.wav", 511)
end

end

if CLIENT then 
 function ENT:Draw()            
 self.Entity:DrawModel()       // Draw the model.   
 end
end

function ENT:PhysicsCollide(data, phys)
if data.Speed > 50 then
self.Entity:EmitSound("weapons/hegrenade/he_bounce-1.wav")
end
local impulse = -data.Speed * data.HitNormal * 0.1 + (data.OurOldVelocity * -0.6)
phys:ApplyForceCenter(impulse)
end


