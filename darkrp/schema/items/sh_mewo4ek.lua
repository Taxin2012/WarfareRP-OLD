ITEM.name = "Мешочек с деньгами"
ITEM.desc = "Для преобразования в капитал - необходимо использовать. \n\nХАРАКТЕРИСТИКИ: \n-высокая ценность"
ITEM.price = 1000
ITEM.model = "models/hardbass/money_meshochek.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 200, 1.5),
	ang = Angle(0, 270, 32.941177368164),
	fov = 4
}
ITEM.exRender = true

ITEM.functions.Use = {
	icon = "icon16/cup.png",
	onRun = function(item)
		if (IsValid(item.player) && item.player:Alive()) then
			
			--sound = "interface/money_"..math.random(1, 2)..".ogg",
			item.player:getChar():giveMoney(math.random(150, 22000))
			item.player:EmitSound("interface/inv_properties.ogg")
		end
	end,
	
	-- Вызывается когда проп лежит на земле, чтобы не вылезал подпункт - закурить
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}