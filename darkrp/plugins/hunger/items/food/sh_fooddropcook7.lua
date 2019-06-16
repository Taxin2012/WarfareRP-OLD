ITEM.name = "Жаренная рука снорка (произведено в Зоне)"
ITEM.desc = "Прожаренная рука снорка. Охотники полагают, что подобная пища придает им сил для дальнейшей охоты, учитывая тот факт, что в мясо снорков содержатся различные состовляющие, способствующие делать столь высокие прыжки. Не стоит забывать, что поедание снорков - самый настоящик каннибализм. \n\nХАРАКТЕРИСТИКИ: \n-вредная пища \n-радиационное облучение: 15 м3в \n\nНасыщенеие 34"
ITEM.price = 948
ITEM.model = "models/hardbass/snork_food.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(88.48819732666, 73.956817626953, 54.9993019104),
	ang = Angle(25, 220, 0),
	fov = 3.6
}
ITEM.exRender = true
ITEM.hunger = 34
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