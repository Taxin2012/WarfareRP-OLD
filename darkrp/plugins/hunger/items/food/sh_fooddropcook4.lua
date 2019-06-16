ITEM.name = "Мясо тушкана (произведено в Зоне)"
ITEM.desc = "Два маленьких зажаренных тушкана, приготовленные на гриле, приправленные солью и перцем Чили. Очень дешевая горячая и практичная пища, которая готовится в Зоне. Завернуто в толстую коричневую бумагу, чтобы жир не стекал. \n\nХАРАКТЕРИСТИКИ: \n-вредная пища \n-радиационное облучение: 6 \n\nНасыщенеие 18"
ITEM.price = 1014
ITEM.model = "models/hardbass/meat_tushkano.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(90.032051086426, 75.527206420898, 54.790908813477),
	ang = Angle(25, 220, -25.882352828979),
	fov = 3.346
}
ITEM.exRender = true
ITEM.hunger = 18
ITEM.thirst = 2
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