﻿ITEM.name = "«Лунный свет»"
ITEM.desc = "Уникальный артефакт электростатической природы. Демонстрирует способность к резонансу под воздействием пси-волн. Со временем сталкеры научились подстраивать артефакт таким образом, чтобы тот резонировал в противофазе, тем самым полностью или в значительной степени нейтрализуя пси-излучение. Радиоактивен. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +2 / сек"
ITEM.model = "models/predatorcz/stalker/artifacts/electra_moonlight.mdl"
ITEM.price = 13536
ITEM.width = 1
ITEM.height = 1
ITEM.isAnomaly = true
ITEM.iconCam = {
pos = Vector(193.10929870605, 161.98397827148, 123.09382629395),
ang = Angle(25, 220, 0),
fov = 3
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
			item.player:getChar():getInv():add("simk_moonlight")
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