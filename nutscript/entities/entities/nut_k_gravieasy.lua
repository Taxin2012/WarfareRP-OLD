AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Трамлин"
ENT.Author = "Spenser"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Костыли"
ENT.RenderGroup = RENDERGROUP_BOTH

if (SERVER) then
function ENT:Initialize()
self:SetModel("models/z-o-m-b-i-e/st/box/st_box_metall_01.mdl")
self:PhysicsInit(SOLID_VPHYSICS)
self:SetMoveType(MOVETYPE_VPHYSICS)
self:SetUseType(SIMPLE_USE)
local physicsObject = self:GetPhysicsObject()

if (IsValid(physicsObject)) then
physicsObject:Wake()
end
end

function ENT:Think()
timer.Simple(10, function()
if (!IsValid(self)) then
return 
end
---
--function ENT:OnTakeDamage(damageInfo)
local pos = self:GetPos()
local ang = self:GetAngles()
---------------------------

local electra = ents.Create("gravieasy")
electra:SetPos(pos)
electra:SetAngles(ang)
electra:SetModel("models/props_junk/watermelon01.mdl")
electra:Spawn()
electra:Activate()
------Убери, это для исчезновения Аномалии
--[[timer.Simple(10,function ()
if (electra:IsValid()) then
SafeRemoveEntity(electra)
end
end)]]
-------------Удаление
SafeRemoveEntity(self) -- или self:Remove()
-----------------------------------
--end
---
end)
end

else

function ENT:Draw()
self:DrawModel()
end


end
