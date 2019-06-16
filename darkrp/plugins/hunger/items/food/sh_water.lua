ITEM.name = "Водка «Немирофф» (привозная, 0,5 литра)" --Название предмета
ITEM.desc = "Военные флажки предназначены для питья воды небольшими глотками. Произведена и очищена медиками и учеными. Вода в сочетании с особым видом спирта кипятится при очень высокой температуре в целях очистки и дезинфекции. \n\nХАРАКТЕРИСТИКИ: \n-напиток \n-крепкий алкоголь \n\nРадиация -24 \nЖажда 37" --Его описание
ITEM.category = "Еда" --Ето не трогай плз
ITEM.price = 1746 --Цена
ITEM.thirst = 37
ITEM.exRender = true
ITEM.quantity = 2

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
			client:setNetVar("radioactive", client:getNetVar("radioactive", 0) - 6)
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
ITEM.model = "models/hardbass/butilka_vodka_rakiy.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-200, 0, 8),
	ang = Angle(0, -0, -44.705883026123),
	fov = 5
}