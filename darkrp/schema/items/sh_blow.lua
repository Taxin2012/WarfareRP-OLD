ITEM.name = "Анабиотик (произведено в Зоне)"
ITEM.category = "Medical"
ITEM.desc = "Экспериментальный медицинский препарат, позволяет пережить Выброс. \n\nХАРАКТЕРИСТКИ: \n-медикамент \n-вызывает долгое помутнение сознание \n\nПозволяет пережить выброс"
ITEM.price = 3498
ITEM.functions.Use = {
	sound = "zona/stalkerrp/actions/interface/inv_pills.ogg",
	onRun = function(item)
		local client = item.player
		client:Freeze(true)
		client:GodEnable()
		client:ConCommand("say /actinjured")
		client:notify("Это займет 135 секунд...")
		timer.Create("frizitem"..client:UniqueID(),135,1,function()
			client:Freeze(false)
			client:GodDisable()
		end)
		local ply = item.player
		--[[ply:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 9, 9 )
		timer.Simple(54,function()
		ply:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 9, 9 )]]
		
		ply:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 2, 440 )
		timer.Simple(68,function()
		ply:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 2, 440 )
		end)
		--item.player:SetHealth(math.min(item.player:Health() + 50, 100))
	end
}
ITEM.exRender = true
ITEM.model = "models/stalker/item/medical/antibotic.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(185, 155.1947479248, 113.40000152588),
	ang = Angle(25, 220, 0),
	fov = 2
}