ITEM.name = "Копченая колбаса (привозная)" --Название предмета
ITEM.desc = "Колбаса, изготовленная из говядины и свинины. Закопченная и упакованная в вакумную упаковку, они может храниться в течении длительного времени. Данная палка колбасы импортирована из России. Такие обычно пользуются спросом среди русской мафии за свой исключительный аромат и вкус. \n\nХАРАКТЕРИСТИКИ: \n-пища \n-здоровое питание \n\nНасыщение 50" --Его описание
ITEM.category = "Еда" --Ето не трогай плз
ITEM.model = Model("models/spenser/ssk/item_misery/kolbasa_2.mdl") --Нажимаешь ПКМ на предмет и копируешь(1 строчка), вставляешь сюда
ITEM.price = 1971 --Цена
ITEM.height = 1 --Сколько занимает предмет по ширине
ITEM.width = 1 --Сколько занимает предмет по вертикале
ITEM.hunger = 50
ITEM.thirst = 0
ITEM.iconCam = {
pos = Vector(89.520034790039, 71.858757019043, 53.137435913086),
ang = Angle(25, 220, 0),
fov = 3
}
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