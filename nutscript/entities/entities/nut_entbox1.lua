AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "DEREV YAWIK"
ENT.Author = "Spenser"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "STALKER"
ENT.RenderGroup = RENDERGROUP_BOTH

if (SERVER) then
function ENT:Initialize()
self:SetModel("models/z-o-m-b-i-e/st/box/st_box_wood_01.mdl")
self:PhysicsInit(SOLID_VPHYSICS)
self:SetMoveType(MOVETYPE_VPHYSICS)
self:SetUseType(SIMPLE_USE)
self.RESP = false
local physicsObject = self:GetPhysicsObject()

if (IsValid(physicsObject)) then
physicsObject:Wake()
end
end

function ENT:OnTakeDamage(damageInfo)
local pos = self:GetPos()
local ang = self:GetAngles()
local attacker = damageInfo:GetAttacker()
local inflictor = damageInfo:GetInflictor()
local damage = damageInfo:GetDamage()
local force = damageInfo:GetDamageForce()
local Pos = damageInfo:GetDamagePosition()
--if (damageInfo:IsBulletDamage()) then
local damagePosition = damageInfo:GetDamagePosition()
local effectData = EffectData()
effectData:SetStart(damagePosition)
effectData:SetOrigin(damagePosition)
effectData:SetScale(10)
util.Effect("GlassImpact", effectData, true, true)
local ent = ents.Create("prop_physics")
ent:SetPos(self:GetPos())
ent:SetAngles(self:GetAngles())
ent:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_wood_01_1.mdl")
local ent2 = ents.Create("prop_physics")
ent2:SetPos(self:GetPos())
ent2:SetAngles(self:GetAngles())
ent2:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_wood_01_4.mdl")
ent2:Spawn()
ent:Spawn()
ent2:Activate()
ent:Activate()
timer.Simple(1,function ()
if (ent2:IsValid()) then
SafeRemoveEntity( ent2 )
end

timer.Simple(1400,function()
local ent33 = ents.Create("nut_entbox1")
ent33:SetPos(pos)
ent33:SetAngles(ang)
ent33:SetModel("models/z-o-m-b-i-e/st/box/st_box_wood_01.mdl")
ent33:Spawn()
ent33:Activate()
end)
if (ent:IsValid()) then
ent:Remove()
end
end)
local loot = 0
local items = {
"bint",
"mediumhealth",
"9x18",
"9x19",
"12x70",
"45acp",
"545x39",
"bone",
"trapk",
"tinderbox",
"drug",
"glue",
"helmetrepait",
"instument",
"instument2",
"instument3",
"solvent",
"swkit1",
"swkit2",
"mirror",
"swkit3",
"sex",
"shovel",
"swiss",
"twomatras",
"armbr",
"boots",
"geigerbrok",
"brodyagalox",
"crowboar",
"dlarmor",
"dharmor",
"kevlar",
"plate",
"plate",
"aksu",
"pm",
"toz",
"obrez",
"mp5",
"cigar"
}
local RandomItem = table.Random(items)
local pos = ent:GetPos()+Vector(0,0,2)
if (loot < 3) then
if (math.random(1, 2) == 2) then
local RandomItem = table.Random(items)
nut.item.spawn(RandomItem, pos)
loot = loot + 1
end
end
if (loot < 3) then
if (math.random(1, 2) == 2) then
local RandomItem = table.Random(items)
nut.item.spawn(RandomItem, pos)
loot = loot + 1
end
end
loot = 0
self:Remove()
--end
end


else

function ENT:Draw()
self:DrawModel()
end


end
