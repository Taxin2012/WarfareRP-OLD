ITEM.name = "«Компас»"
ITEM.desc = "Редкий артефакт - последний раз его находили много месяцев назад. Обладает способностью показывать разрывы в аномальных полях. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n-телепортирует на базу"
ITEM.model = "models/kali/miscstuff/stalker/artifacts/compass.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(98, 82.118995666504, 60),
	ang = Angle(25, 220, 0),
	fov = 4.3737564420635
}
ITEM.isAnomaly = true

ITEM.functions.Use = {
	icon = "icon16/cup.png",
	--sound = "items/battery_pickup.wav",
	onRun = function(item)
		if (item.player:Team() == FACTION_LONER) then
			item.player:SetPos(Vector(-7651.656250, 7518.173340, 24.031250))
		elseif (item.player:Team() == FACTION_RAIDERS) then
			item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
		elseif (item.player:Team() == FACTION_MERCENARIES) then
			item.player:SetPos(Vector(-13749.662109, 1331.838379, 174.524033)) 
		elseif (item.player:Team() == FACTION_GREH) then
			item.player:SetPos(Vector(6945.985352, 5866.790527, -236.968750)) 
		elseif (item.player:Team() == FACTION_MILITARY) then
			item.player:SetPos(Vector(11097.428711, 11854.366211, 8.031250)) 
		elseif (item.player:Team() == FACTION_SBU) then
			item.player:SetPos(Vector(11097.428711, 11854.366211, 8.031250)) 
		elseif (item.player:Team() == FACTION_PROZRENIE) then
			item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
		elseif (item.player:Team() == FACTION_FREEDOM) then
			item.player:SetPos(Vector(11857.136719, -5119.536621, 12.031250)) 
		elseif (item.player:Team() == FACTION_DUTY) then
			item.player:SetPos(Vector(-13890.032227, 13765.546875, 791.180237)) 
		elseif (item.player:Team() == FACTION_SCIENTISTS) then
			item.player:SetPos(Vector(-266.326263, -10377.387695, -991.968750)) 
		elseif (item.player:Team() == FACTION_HUNTER) then
			item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
		elseif (item.player:Team() == FACTION_WATCH) then
			item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
		elseif (item.player:Team() == FACTION_LASTDAY) then
			item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
		elseif (item.player:Team() == FACTION_CLEARSKY) then
			item.player:SetPos(Vector(10865.573242, -11511.036133, -247.968750)) 
		elseif (item.player:Team() == FACTION_MONOLIT) then
			item.player:SetPos(Vector(-9694.005859, -10503.429688, 0.031250)) 
		elseif (item.player:Team() == FACTION_MERCHANTS) then
			item.player:SetPos(Vector(-7651.656250, 7518.173340, 24.031250)) 
		end
	return false
end 
}
--LocalPlayer():SetPos(Vector(41.799427, -1857.167725, 0.031250)) 
--LocalPlayer():getChar():SetPos(Vector(41.799427, -1857.167725, 0.031250)) 
						--	local character = LocalPlayer():getChar()
						--	local inventory = character:getInv()
--[[if (inventory) then		
									local items = client:getChar():getInv():hasItem("agro_armysklad")
									if (!items) then
										client:getChar():getInv():remove(client:getChar():getInv():hasItem("agro_armysklad"):getID()) 
										item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
									end
								elseif (inventory) then		
									local items = client:getChar():getInv():hasItem("agro_svalka")
									if (!items) then
										client:getChar():getInv():remove(client:getChar():getInv():hasItem("agro_svalka"):getID()) 
										item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
									end
								elseif (inventory) then		
									local items = client:getChar():getInv():hasItem("armysklad_agro")
									if (!items) then
										client:getChar():getInv():remove(client:getChar():getInv():hasItem("armysklad_agro"):getID()) 
										item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
									end
								elseif (inventory) then		
									local items = client:getChar():getInv():hasItem("armysklad_bar")
									if (!items) then
										client:getChar():getInv():remove(client:getChar():getInv():hasItem("armysklad_bar"):getID()) 
										item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
									end
								elseif (inventory) then		
									local items = client:getChar():getInv():hasItem("bar_armysklad")
									if (!items) then
										client:getChar():getInv():remove(client:getChar():getInv():hasItem("bar_armysklad"):getID()) 
										item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
									end
								elseif (inventory) then		
									local items = client:getChar():getInv():hasItem("bar_svalka")
									if (!items) then
										client:getChar():getInv():remove(client:getChar():getInv():hasItem("bar_svalka"):getID()) 
										item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
									end
								elseif (inventory) then		
									local items = client:getChar():getInv():hasItem("svalka_agro")
									if (!items) then
										client:getChar():getInv():remove(client:getChar():getInv():hasItem("svalka_agro"):getID()) 
										item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
									end
								elseif (inventory) then		
									local items = client:getChar():getInv():hasItem("svalka_bar")
									if (!items) then
										client:getChar():getInv():remove(client:getChar():getInv():hasItem("svalka_bar"):getID()) 
										item.player:SetPos(Vector(958.973450, 12447.020508, 18.031250)) 
									end
								end]]
							
							--LocalPlayer():SetPos(Vector(41.799427, -1857.167725, 0.031250)) 