ITEM.name = "Армейская аптечка"
ITEM.desc = "Специализированный медицинский набор для оказания первой помощи при ранениях на поле боя. В набор входят средства для ускорения свертывания крови на основе Менадиона, обезболивающие, антибиотики и стимуляторы иммунитета. Восстанавливает 73% здоровья. \n\nХАРАКТЕРИСТИКИ: \n-военное изделие \n-медленно использовангие (полевой набор)"
ITEM.category = "Medical"
ITEM.price = 1836
ITEM.functions.Use = {
	sound = "interface/inv_bandage_3p7.ogg",
	onRun = function(item)
		local client = item.player
		client:Freeze(true)
		timer.Create("frizitem"..client:UniqueID(),5,1,function()
			client:Freeze(false)
		end)
		local ply = item.player
		ply:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		ply:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		item.player:SetHealth(math.min(item.player:Health() + 73, 100))
	end
}
ITEM.exRender = true
ITEM.model = "models/hardbass/dev_aptechka_high.mdl"
ITEM.iconCam = {
	pos = Vector(95.379379272461, 80.032791137695, 58.957210540771),
	ang = Angle(25, 220, 0),
	fov = 4.9
}
