ITEM.name = "Научная аптечка"
ITEM.category = "Medical"
ITEM.desc = "Медицинский набор, разработанный специально для научных сотрудников, которые работают в условиях Зоны. Содержит средства как для заживления механических травм, так и для предоствращения развития лучевой болезник \n\nХАРАКТЕРИСТИКИ: \n-высокая ценность \n-высококачественный препарат \n-медленное использование (полевой набор) \n\nВосст. здоровья 91"
ITEM.price = 3164
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
		item.player:SetHealth(math.min(item.player:Health() + 91, 100))
	end
}
ITEM.exRender = true

ITEM.model = "models/hardbass/dev_aptechka_mid.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(78.265655517578, 65.672676086426, 48.367980957031),
	ang = Angle(25, 220, 0),
	fov = 5
}
