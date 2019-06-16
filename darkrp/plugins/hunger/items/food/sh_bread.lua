ITEM.name = "Свежий хлеб (привозной)" --Название предмета
ITEM.desc = "Свежий хлеб, испеченной женой Шустрого, которая живет за пределами Зоны Отчуждения. Это было первое дело Шустрого, до того как его бизнес расширился. В настоящее время он снабжает бармена этим хлебом, а не продает его сам, как было раньше. \n\nХАРАКТЕРИСТИКИ \n-пища \n-здоровое питание \n\nНасыщение 35" --Его описание
ITEM.category = "Еда" --Ето не трогай плз
ITEM.model = Model("models/stalker/item/food/bread.mdl") --Нажимаешь ПКМ на предмет и копируешь(1 строчка), вставляешь сюда
ITEM.price = 1146 --Цена
ITEM.height = 1 --Сколько занимает предмет по ширине
ITEM.width = 1 --Сколько занимает предмет по вертикале
ITEM.hunger = 35
ITEM.thirst = 0
ITEM.exRender = true
ITEM.functions.use = {
	onRun = function(item)
	local client = item.player
	if item.hunger > 0 then client:restoreHunger(item.hunger) end
	if item.thirst > 0 then client:restoreThirst(item.thirst) end
	client:EmitSound( "interface/inv_eat_paperwrap.ogg", 75, 200 )
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		return true
	end,
	onCanRun = function(item)
		return (!item.empty)
	end,
	icon = "icon16/cup.png",
	name = "употребить"
}
ITEM.empty = false
ITEM.iconCam = {
ang = Angle(25, 220, 0),
fov = 2,
pos = Vector(183, 155, 112)
}