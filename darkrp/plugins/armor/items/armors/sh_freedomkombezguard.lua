ITEM.name = "Комбинезон «Страж свободы»"
ITEM.desc = "Производимый ремесленниками группировки «Свобода» усиленный комбинезон сталкера. Средний армейский бронежилет плюс накладные усиливающие циркониевые элементы дают неплохую защиту от автоматных пуль и осколков на различных дистанциях. Материал костюма состоит из двух слоев: специально обработанной кожи и ткани с асбестовой нитью. Дает совсем малую защиту от различных аномальных воздействий и радиации. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-легкая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/svoboda_heavy_suit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_free_02a_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 69000
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 35 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(-8, 0, 200),
	ang = Angle(90, 0, -180),
	fov = 6
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
			item.player:getChar():getInv():add("dlarmor")
			item.player:getChar():getInv():add("dlarmor")
			item.player:getChar():getInv():add("kevlar")
		end
	end,
	
	-- Вызывается когда проп лежит на земле, чтобы не вылезал подпункт - закурить
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}