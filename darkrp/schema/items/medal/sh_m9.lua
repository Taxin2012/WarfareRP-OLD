ITEM.name = "Первенство «Зова Припяти»"
ITEM.desc = "Награда за достижение ранга. Выдается, если текущий ранг более 2000. Для преобразования в капитал - необходимо использовать.\n\nХАРАКТЕРИСТИКИ: \n-выоская стоимость"
ITEM.price = 40000
ITEM.model = "models/hardbass/dev_money3.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(4.9000000953674, -1.7400000095367, 200),
	ang = Angle(90, 0, -87.058822631836),
	fov = 1
}
ITEM.exRender = true
ITEM.functions.Use = {
	sound = "interface/inv_properties.ogg",
	icon = "icon16/cup.png",
	onRun = function(item)
		item.player:getChar():giveMoney(40000)
	end
}