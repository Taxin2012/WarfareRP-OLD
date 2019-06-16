ITEM.name = "Первенство «Опытного»"
ITEM.desc = "Награда за достижение ранга. Выдается, если текущий ранг более 500. Для преобразования в капитал - необходимо использовать.\n\nХАРАКТЕРИСТИКИ: \n-выоская стоимость"
ITEM.price = 10000
ITEM.model = "models/hardbass/dev_money1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(3.5999999046326, 2.7000000476837, 200),
	ang = Angle(90, 0, -84.705879211426),
	fov = 0.94
}
ITEM.exRender = true
ITEM.functions.Use = {
	sound = "interface/inv_properties.ogg",
	icon = "icon16/cup.png",
	onRun = function(item)
		item.player:getChar():giveMoney(10000)
	end
}