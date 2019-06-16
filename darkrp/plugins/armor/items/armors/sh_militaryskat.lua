﻿ITEM.name = "Бронекостюм «СКАТ-9М»"
ITEM.desc = "Армейский бронекостюм СКАТ-9М создан для проведения штурмовых операций в зонах активности аномалий. В составе: тяжёлый армейский бронекостюм серии ПСЗ-12п, встроенный компенсационный костюм, шлем Сфера M12. Предоставляет великолепную защиту от пулевого и осколочного попадания. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-тяжелая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/specops2_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_solder_04b_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 77127
ITEM.ric = 30  -- % шанс рикошета
ITEM.dmgsteal = 55 -- % поглощения урона
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(-3, 0, 200),
	ang = Angle(90, 0, -180),
	fov = 8
}
ITEM.exRender = true

ITEM.functions.duse = {
	name = "Разобрать",
	icon = "icon16/cup.png",
	onRun = function(item)
		if (IsValid(item.player) && item.player:Alive()) then
			if !item.player:getChar():getInv():hasItem("crowboar") then
				item.player:notify("У вас нет лома!")
				return false
			end
			
			if (math.random(1,10) >= 5) then
				local cough = {
					"interface/crowbreak.ogg",
					"interface/crowbreak.ogg",
					"interface/crowbreak.ogg",
					"interface/crowbreak.ogg"
				}
				item.player:EmitSound(cough[math.random(1,#cough)], 50, 100)
			end;
			--sound = "interface/money_"..math.random(1, 2)..".ogg",
			item.player:getChar():getInv():add("trapk")
			item.player:getChar():getInv():add("trapk")
			item.player:getChar():getInv():add("trapk")
			item.player:getChar():getInv():add("armbr")
			item.player:getChar():getInv():add("dharmor")
			item.player:getChar():getInv():add("dharmor")
			item.player:getChar():getInv():add("kevlar")
		end
	end,
	
	-- Вызывается когда проп лежит на земле, чтобы не вылезал подпункт - закурить
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}