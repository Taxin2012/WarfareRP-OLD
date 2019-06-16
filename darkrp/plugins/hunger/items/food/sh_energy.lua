ITEM.name = "Очищенная вода (произведено в Зоне, 1 литр)" --Название предмета
ITEM.desc = "Военные фляжки предназначены для питья воды небольшими глотками. Произведена и очищена медиками и учеными. \n\nХАРАКТЕРИСТИКИ: \n-напиток \n-здоровое питание \n\nРадиация -12 \nЖажда 70" --Его описание
ITEM.category = "Еда" --Ето не трогай плз
ITEM.price = 987 --Цена
ITEM.hunger = 0
ITEM.thirst = 10
ITEM.quantity = 3

ITEM.functions.use = { -- sorry, for name order.
	name = "употребить",
	tip = "useTip",
	icon = "icon16/cup.png",
	onRun = function(item)
	local client = item.player
			client:EmitSound( "interface/inv_drink_can2.ogg", 75, 200 )
			if item.hunger > 0 then client:restoreHunger(item.hunger) end
			if item.thirst > 0 then client:restoreThirst(item.thirst) end
			--if (IsValid(target) and target:IsPlayer() and target:Alive()) then
			item:setData("quantity", item:getData("quantity", item.quantity or 0) - 1)
			-- client:setNetVar("radioactive", client:getNetVar("radioactive", 0) - 2)
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
ITEM.model = "models/hardbass/flyaga.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-200, 0, 3.4000000953674),
	ang = Angle(0, -0, -23.529411315918),
	fov = 4
}
ITEM.exRender = true