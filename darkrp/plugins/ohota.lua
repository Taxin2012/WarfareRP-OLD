PLUGIN.name = "ohota"
PLUGIN.author = "Spenser"
PLUGIN.desc = ""
if (SERVER) then
	
function PLUGIN:KeyPress(client, key)
-----
if (client:getChar()) then
if (client:Alive()) then
------
local Hit = client:GetEyeTraceNoCursor()
local npc = Hit.Entity
if (key == IN_USE) then
if (npc:IsRagdoll()) then
--
if (npc:GetModel() == "models/spenser/ssk/new_izlom_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
if (client:getChar():getInv():hasItem("kithunt")) then
--if (math.random(1, 100) > 80) then
nut.item.spawn("food_ruchkasamodrochka10", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("food_ruchkasamodrochka10", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("food_ruchkasamodrochka10", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--
if (npc:GetModel() == "models/spenser/ssk/new_zombi_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
if (client:getChar():getInv():hasItem("kithunt")) then
--if (math.random(1, 100) > 80) then
nut.item.spawn("food_ruchkasamodrochka2", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("food_ruchkasamodrochka2", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("food_ruchkasamodrochka2", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
npc:EmitSound( Sound( "interface/inv_mutant_loot_animal.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--
--
if (npc:GetModel() == "models/spenser/ssk/new_tush_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
if (client:getChar():getInv():hasItem("kithunt")) then
--if (math.random(1, 100) > 80) then
nut.item.spawn("food_ruchkasamodrochka5", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("fooddrop4", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("fooddrop4", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
npc:EmitSound( Sound( "interface/inv_mutant_loot_animal.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--
if (npc:GetModel() == "models/spenser/ssk/new_snork_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
if (client:getChar():getInv():hasItem("kithunt")) then
--if (math.random(1, 100) > 80) then
nut.item.spawn("food_ruchkasamodrochka5", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("fooddrop7", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("fooddrop7", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
npc:EmitSound( Sound( "interface/inv_mutant_loot_animal.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--
if (npc:GetModel() == "models/spenser/ssk/new_psydog_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
if (client:getChar():getInv():hasItem("kithunt")) then
--if (math.random(1, 100) > 80) then
nut.item.spawn("food_ruchkasamodrochka4", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("fooddrop2", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("fooddrop2", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
npc:EmitSound( Sound( "interface/inv_mutant_loot_animal.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--
if (npc:GetModel() == "models/spenser/ssk/new_krovo_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
if (client:getChar():getInv():hasItem("kithunt")) then
--if (math.random(1, 100) > 80) then
nut.item.spawn("food_ruchkasamodrochka7", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("fooddrop3", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("fooddrop3", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
npc:EmitSound( Sound( "interface/inv_mutant_loot_animal.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--
if (npc:GetModel() == "models/spenser/ssk/new_plot_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
--if (client:getChar():getInv():hasItem("kithunt")) then
if (math.random(1, 100) > 80) then
nut.item.spawn("food_ruchkasamodrochka9", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("fooddrop6", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("fooddrop6", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
npc:EmitSound( Sound( "interface/inv_mutant_loot_animal.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--
if (npc:GetModel() == "models/spenser/ssk/new_dog_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
if (client:getChar():getInv():hasItem("kithunt")) then
--if (math.random(1, 100) > 80) then
nut.item.spawn("food_ruchkasamodrochka3", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("fooddrop5", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("fooddrop5", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
npc:EmitSound( Sound( "interface/inv_mutant_loot_animal.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--
if (npc:GetModel() == "models/spenser/ssk/new_boar_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
if (client:getChar():getInv():hasItem("kithunt")) then
--if (math.random(1, 100) > 80) then
nut.item.spawn("food_ruchkasamodrochka8", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("fooddrop1", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("fooddrop1", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
npc:EmitSound( Sound( "interface/inv_mutant_loot_animal.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--
if (npc:GetModel() == "models/spenser/ssk/new_boar_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
if (client:getChar():getInv():hasItem("kithunt")) then
--if (math.random(1, 100) > 80) then
nut.item.spawn("food_ruchkasamodrochka8", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("fooddrop1", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("fooddrop1", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
npc:EmitSound( Sound( "interface/inv_mutant_loot_animal.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--
if (npc:GetModel() == "models/spenser/ssk/new_chimer_spen.mdl" and client:GetActiveWeapon():GetClass() == "ssk_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
client:Freeze(true) 
npc:EmitSound("interface/inv_mutant_loot_animal.ogg") 
client:ConCommand("say /actrazdelka")
timer.Create("frizitem"..client:UniqueID(),5,1,function() 
client:Freeze(false) 
if (client:getChar():getInv():hasItem("kithunt")) then
--if (math.random(1, 100) > 80) then
nut.item.spawn("ruchkasamodrochka11", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("ruchkasamodrochka11", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("ruchkasamodrochka11", npc:GetPos() + Vector(0, 0, 8) )
--end
else
--if (math.random(1, 100) > 60) then
nut.item.spawn("ruchkasamodrochka11", npc:GetPos() + Vector(0, 0, 8) )
nut.item.spawn("ruchkasamodrochka11", npc:GetPos() + Vector(0, 0, 8) )
--end	
end
npc:Remove()
end) 
npc:EmitSound( Sound( "interface/inv_mutant_loot_animal.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
timer.Simple(1,function() 
client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
end) 
end
--


end
end
end
end

end
end 

