ITEM.name = "Чай Бороды (произведено в Зоне, 1 литр)" --Название предмета
ITEM.desc = "Популярный среди сталкеров горячий чай Бороды, настоянный на съедобных сушенных грибах в кипяченной воде (поговаривают, что не радиоактивной) с добавлением сахара. Сталкеры. которые могут позволить покупать данный напиток, часто берут его с собой в длительные ходки по Зоне. Это довольно хороший и относительно здоровый способ оставаться на ногах, когда устанешь или когда пережидаешь холодные темные ночи. \n\nХАРАКТЕРИСТИКИ \n-напиток \n-здоровое питание \n\nРадиация -13 м3d / сек \nНасыщение 226 ккал экв." --Его описание
ITEM.model = Model("models/misery/drinks/tea_bottle.mdl ") --Нажимаешь ПКМ на предмет и копируешь(1 строчка), вставляешь сюда
ITEM.price = 6709 --Цена
ITEM.height = 2 --Сколько занимает предмет по ширине
ITEM.width = 1 --Сколько занимает предмет по вертикале
ITEM.thirst = 90
ITEM.hunger = 10
ITEM.quantity = 3

ITEM.functions.use = { -- sorry, for name order.
	name = "употребить",
	tip = "useTip",
	icon = "icon16/cup.png",
	onRun = function(item)
	local client = item.player
			client:EmitSound( "interface/inv_drink_tea.ogg", 75, 200 )
			if item.hunger > 0 then client:restoreHunger(item.hunger) end
			if item.thirst > 0 then client:restoreThirst(item.thirst) end
			--if (IsValid(target) and target:IsPlayer() and target:Alive()) then
			item:setData("quantity", item:getData("quantity", item.quantity or 0) - 1)
			client:setNetVar("radioactive", client:getNetVar("radioactive", 0) - 5)
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
			
			if item:getData("quantity") < 1 then
				--item.player:notify("Вы израсходовали все аптечки")
				return true
			end
		--end
		return false;
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
ITEM.empty = true
ITEM.iconCam = {
ang = Angle(25, 220, 0),
fov = 3,
pos = Vector(113.4, 95.2, 74.3)
}
ITEM.exRender = true