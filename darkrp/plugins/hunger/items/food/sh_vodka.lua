ITEM.name = "Водка Столичная (Привозная, 0.75 листра)" --Название предмета
ITEM.desc = "Обожаемый русскими напиток, да и многими другими людьми во всем мире. Это русская водка довольно высокого качества. \n-крепкий алкоголь \n-высококачественное изделие \n\nЖажда 60" --Его описание
ITEM.category = "Еда" --Ето не трогай плз
ITEM.model = Model("models/misery/drinks/flask_vodka.mdl ") --Нажимаешь ПКМ на предмет и копируешь(1 строчка), вставляешь сюда
ITEM.price = 3994 --Цена
ITEM.height = 1 --Сколько занимает предмет по ширине
ITEM.width = 1 --Сколько занимает предмет по вертикале
ITEM.thirst = 60
ITEM.hunger = 0
ITEM.quantity = 3
ITEM.exRender = true
ITEM.iconCam = {
ang = Angle(25, 220, 0),
fov = 4.3,
pos = Vector(81.1, 68, 50.1)
}

ITEM.functions.use = { -- sorry, for name order.
	name = "употребить",
	tip = "useTip",
	icon = "icon16/cup.png",
	onRun = function(item)
	local client = item.player
			client:EmitSound( "interface/inv_drink_flask.ogg", 75, 200 )
			if item.hunger > 0 then client:restoreHunger(item.hunger) end
			if item.thirst > 0 then client:restoreThirst(item.thirst) end
			--if (IsValid(target) and target:IsPlayer() and target:Alive()) then
			item:setData("quantity", item:getData("quantity", item.quantity or 0) - 1)
			client:setNetVar("radioactive", client:getNetVar("radioactive", 0) - 9)
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
fov = 4.67,
pos = Vector(176.2, 147.8, 108.8)
}