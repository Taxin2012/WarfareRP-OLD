ITEM.name = "Тушенка из говядины «Абакан» (привозная)" --Название предмета
ITEM.desc = "Тушенка - это общее название из тушеного мяса, производимая в Советском Союзе и других странах Варшавского договора. Ирония заключается в том, что идея такого продукта пришла в Россию во время Второй мировой войны в форме помощи от Соединенных Штатов. \n\nХАРАКТЕРИСТИКИ: \n-пища \n-здоровое питание \n-для употребления нужен: Нож \n\nНасыщение 80" --Его описание
ITEM.category = "Еда" --Ето не трогай плз
ITEM.model = Model("models/spenser/ssk/item_misery/konserva_2.mdl") --Нажимаешь ПКМ на предмет и копируешь(1 строчка), вставляешь сюда
ITEM.price = 2769 --Цена
ITEM.height = 1 --Сколько занимает предмет по ширине
ITEM.width = 1 --Сколько занимает предмет по вертикале
ITEM.hunger = 80
ITEM.thirst = 10
ITEM.iconCam = {
pos = Vector(52.069759368896, 43.727516174316, 33.789016723633),
ang = Angle(25, 220, 0),
fov = 4.2
}
ITEM.exRender = true
ITEM.functions.use = {
	onRun = function(item)
	
	local client = item.player
	if !item.player:getChar():getInv():hasItem("knife") then
		item.player:notify("Вам нужен Нож для открытия консервов.")
		return false
	end
	if item.hunger > 0 then client:restoreHunger(item.hunger) end
	if item.thirst > 0 then client:restoreThirst(item.thirst) end
	client:EmitSound( "interface/inv_eat_can.ogg", 75, 200 )
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
	name = "Употребить"
}
ITEM.empty = false