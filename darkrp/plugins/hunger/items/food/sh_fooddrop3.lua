ITEM.name = "Мясо кровососа"
ITEM.desc = "Мясо кровососа весьма вязкое и тягучее, поэтому непригодно для еды. Хотя кровососы и являются смертельными чудовищами, цена на их мясо не особо высока из-за ограниченного применения. \n\nВНИМАНИЕ: \n\nСталкерам рекомендуется воздержаться от употребления такого рода мяса. \n\nХАРАКТЕРИСТИКИ: \n-мясо мутанта «высокого происхождения» \n-возможно приготовить \n-ядовитая пища \n-радиационное облучение: +31 м3в \n\nНасыщенеие 41"
ITEM.model = "models/hardbass/raw_flesh.mdl"
ITEM.price = 542
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(86.599998474121, 73.197570800781, 53.877902984619),
	ang = Angle(25, 220, 0),
	fov = 4.3345276242623
}
ITEM.exRender = true
ITEM.hunger = 10
ITEM.thirst = 2
ITEM.functions.use = {
	onRun = function(item)
	local client = item.player
	if item.hunger > 0 then client:restoreHunger(item.hunger) end
	if item.thirst > 0 then client:restoreThirst(item.thirst) end
	client:EmitSound( "interface/inv_eat_paperwrap.ogg", 75, 200 )
	client:setNetVar("radioactive", client:getNetVar("radioactive", 0) + 40)
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