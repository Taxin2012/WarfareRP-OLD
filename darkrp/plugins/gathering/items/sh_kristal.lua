ITEM.name = "«Кристалл»"
ITEM.desc = "Получается при попадании тяжелого металла в аномалию «Жарка». Этот артефакт замечательно выводит радиацию. Такой артефакт высоко ценится сталкерами, и мало где его можно добыть. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +2 / сек"
ITEM.model = "models/predatorcz/stalker/artifacts/crystal.mdl"
ITEM.price = 16728
ITEM.width = 1
ITEM.height = 1
ITEM.isAnomaly = true
ITEM.iconCam = {
pos = Vector(175, 147, 113),
ang = Angle(25, 220, 0),
fov = 4.6703654082599
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	icon = "icon16/cup.png",
	onRun = function(item)
		local client = item.player
		if (IsValid(item.player) && item.player:Alive()) then
			if !item.player:getChar():getInv():hasItem("simkemp") then
				item.player:notify("Вам нужны СИМК (пустой).")
				return false
			end
			item.player:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			item.player:getChar():getInv():add("simk_kristal")
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("simkemp"):getID()) 
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		end
	end,

	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}