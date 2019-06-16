ITEM.name = "Сумка СМВ"
ITEM.desc = "Представляет собой набор медицинского оборудования и лекарственных препаратов, предназначенных для оказания первой медицинской помощи. \nХАРАКТЕРИСТИКИ: \n-высокая ценность"
ITEM.category = "misc"
ITEM.price = 13212
ITEM.exRender = true
ITEM.model = "models/hardbass/medkit.mdl"
ITEM.width = 3
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(205, 172.51559448242, 128),
	ang = Angle(25, 220, -7.0588235855103),
	fov = 4
}

ITEM.functions.Use = {
	icon = "icon16/cup.png",
	--sound = "items/battery_pickup.wav",
	onRun = function(item)
		item.player:getChar():getInv():add("bighealth")	
		item.player:getChar():getInv():add("bighealth")	
		item.player:getChar():getInv():add("bighealth")	
		item.player:getChar():getInv():add("bint")	
		item.player:getChar():getInv():add("bint")
		item.player:getChar():getInv():add("mediumhealth")	
		item.player:getChar():getInv():add("mediumhealth")	
		item.player:getChar():getInv():add("mediumhealth")	
		item.player:getChar():getInv():add("blow")	
	end
}