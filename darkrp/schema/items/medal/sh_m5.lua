ITEM.name = "Первенство «Мастера»"
ITEM.desc = "Награда за достижение ранга. Выдается, если текущий ранг более 1000. Для преобразования в капитал - необходимо использовать.\n\nХАРАКТЕРИСТИКИ: \n-выоская стоимость"
ITEM.price = 20000
ITEM.model = "models/hardbass/dev_money2.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(1.1499999761581, 5.4000000953674, 201),
	ang = Angle(90, 0, -101.17646789551),
	fov = 0.9
}
ITEM.exRender = true
ITEM.functions.Use = {
	sound = "interface/inv_properties.ogg",
	icon = "icon16/cup.png",
	onRun = function(item)
		item.player:getChar():giveMoney(20000)
	end
}