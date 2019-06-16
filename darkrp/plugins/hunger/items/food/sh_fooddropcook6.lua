ITEM.name = "Сало плоти (произведено в Зоне)"
ITEM.desc = "Два ломтика сала и жирного бекона из мутировавших свиней, более известных, как плоти. Завернуто в толстую коричневую бумагу, чтобы жир не стекал. \n\nХАРАКТЕРИСТИКИ: \n-вредная пища \n-радиационное облучение: 15 м3в \n\nНасыщенеие 48"
ITEM.price = 997
ITEM.model = "models/spenser/ssk/item_misery/eda_0.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(57.60131072998, 48.336582183838, 37.03784942627),
	ang = Angle(25, 220, 0),
	fov = 5.221
}
ITEM.exRender = true
ITEM.hunger = 48
ITEM.thirst = 5
ITEM.functions.use = {
	onRun = function(item)
	local client = item.player
	if item.hunger > 0 then client:restoreHunger(item.hunger) end
	if item.thirst > 0 then client:restoreThirst(item.thirst) end
	client:EmitSound( "interface/inv_eat_paperwrap.ogg", 75, 200 )
	client:setNetVar("radioactive", client:getNetVar("radioactive", 0) + 14)
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