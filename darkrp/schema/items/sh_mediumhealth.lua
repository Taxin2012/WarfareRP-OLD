ITEM.name = "Аптечка первой помощи"
ITEM.category = "Одноразовый медицинский комплект общего назначения. Удобен для оказания первой помощи при травмах, небольших ранах, химических и термических ожогах, а так же различного рода отравлениях. Восстанавливает 43 здоровья \n\nХАРАКТЕРИСТИКИ: \n-повсеместное применение \n-медленное испольщование (полевой набор)"
ITEM.price = 1140
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
		item.player:SetHealth(math.min(item.player:Health() + 43, 100))
	end
}
ITEM.exRender = true

ITEM.model = "models/hardbass/dev_aptechka_low.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(70.565055847168, 59.21110534668, 43.603393554688),
	ang = Angle(25, 220, 0),
	fov = 5
}
