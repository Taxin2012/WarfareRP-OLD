ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName		= "psy - Heavy - Large"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= "Irradiates players moderately"
ENT.Category 		= "PSY"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

/*---------------------------------------------------------
   Name: OnRemove
   Desc: Called just before entity is deleted
---------------------------------------------------------*/
function ENT:OnRemove()
end

function ENT:PhysicsUpdate()
end

function ENT:PhysicsCollide(data,phys)

end
