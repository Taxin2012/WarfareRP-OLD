ITEM.name = "Набор новичка"
ITEM.desc = "ПРИ АКТИВАЦИИ НЕОБХОДИМО ОСВОБОДИТЬ ИНВЕНТАРЬ! \n\nВключает в себя: \nDesert Eagle \nВеревку \nЛегкую броню \nТри пачки патрон .45acp \nИРП-Б \nАптечка первой помощи \n\nХАРАКТЕРИСТИКИ: \n-личная вещь \n-высокая ценность \n-не выпадает \n-нельзя выбросить"
ITEM.price = 6758
ITEM.model = "models/hardbass/grooming.mdl"
ITEM.width = 3
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-500, 386, 306),
	ang = Angle(25.882352828979, -37.647060394287, 0),
	fov = 3
}
ITEM.exRender = true

ITEM.functions.Use = {
	icon = "icon16/cup.png",
	--sound = "items/battery_pickup.wav",
	onRun = function(item)
	local client = item.player
		if (item.player:Team() == FACTION_LONER) then
			item.player:getChar():getInv():add("stalkerkombez")
		elseif (item.player:Team() == FACTION_RAIDERS) then
			item.player:getChar():getInv():add("banditplach")
		elseif (item.player:Team() == FACTION_MERCENARIES) then
			item.player:getChar():getInv():add("mercekombez")
		elseif (item.player:Team() == FACTION_MILITARY) then
			item.player:getChar():getInv():add("militaryberill")
		elseif (item.player:Team() == FACTION_FREEDOM) then
			item.player:getChar():getInv():add("freedomkombezveter")
		elseif (item.player:Team() == FACTION_DUTY) then
			item.player:getChar():getInv():add("dolgkombez")
		elseif (item.player:Team() == FACTION_SCIENTISTS) then
			item.player:getChar():getInv():add("stalkerkombez")
		elseif (item.player:Team() == FACTION_CLEARSKY) then
			item.player:getChar():getInv():add("clearskycs1")
		end
		item.player:getChar():getInv():add("mediumhealth")
		item.player:getChar():getInv():add("deagle")	
		item.player:getChar():getInv():add("45acp")	
		item.player:getChar():getInv():add("45acp")	
		item.player:getChar():getInv():add("45acp")	
		item.player:getChar():getInv():add("rusmre")
		item.player:getChar():getInv():add("tie")
		item.player:getChar():giveMoney(30000)
		item.player:EmitSound(LocalPlayer(), "interface/inv_properties.ogg")
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
	end
}

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end