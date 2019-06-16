ITEM.name = "Мясо слепого пса"
ITEM.desc = "Мясо мутировавшей слепой собаки многие сталкеры используют как дешевую альтернативу наиболее популярному мясу кабана. Ученые уже достаточно много провели исследований над принесенными сталкерами образцами, поэтому спрос на такие куски мяса упал. \n\nВНИМАНИЕ: \n\nСталкерам рекомендуется воздержаться от употребления такого рода мяса животных и мутантов в Зоне в сыром виде, так как оно наверняка заражено трихинеллезом или бруцеллезом. \n \nХАРАКТЕРИСТИКИ: \n-мясо мутанта низкого происхождения \n-возможно приготовить \n-ядовитая пища \n-радиационное облучение: 17 \n\nНасыщение 17 ккал экв."
ITEM.model = Model("models/hardbass/raw_dog.mdl")
ITEM.price = 114
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