ITEM.name = "Первенство «Следопыта»"
ITEM.desc = "Награда за достижение ранга. Выдается, если текущий ранг более 100. Для преобразования в капитал - необходимо использовать.\n\nХАРАКТЕРИСТИКИ: \n-выоская стоимость"
ITEM.price = 2000
ITEM.model = "models/hardbass/dev_money.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(3.7000000476837, -4.4000000953674, 200),
	ang = Angle(90, 0, -77.64705657959),
	fov = 1
}
ITEM.exRender = true
ITEM.functions.Use = {
	sound = "interface/inv_properties.ogg",
	icon = "icon16/cup.png",
	onRun = function(item)
		item.player:getChar():giveMoney(2000)
	end
}