ITEM.name = "Мясо псевдособаки (произведено в Зоне)"
ITEM.desc = "Порция жаренных отбивных из мяса псевдособаки. Хорошие пищевые свойства из-за плотной мышечной ткани животного. \n\nХАРАКТЕРИСТИКИ: \n-мясо мутанта «низкого происхождения» \n-ядовитая пища \n-радиационное облучение: 177 м3в \n\nНасыщенеие 40"
ITEM.price = 1227
ITEM.model = "models/spenser/ssk/item_misery/eda_0.mdl"
ITEM.hunger = 40
ITEM.thirst = 5
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(57.60131072998, 48.336582183838, 37.03784942627),
	ang = Angle(25, 220, 0),
	fov = 5.221
}
ITEM.exRender = true
ITEM.functions.use = {
	onRun = function(item)
	local client = item.player
	if item.hunger > 0 then client:restoreHunger(item.hunger) end
	if item.thirst > 0 then client:restoreThirst(item.thirst) end
	client:EmitSound( "interface/inv_eat_paperwrap.ogg", 75, 200 )
	client:setNetVar("radioactive", client:getNetVar("radioactive", 0) + 14)
		client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
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
