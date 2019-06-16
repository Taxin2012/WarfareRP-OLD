ITEM.name = "Экзоскелет «Бандитов»"
ITEM.desc = "Модернизация обычного экзоскелета. Создан при участии ремесленников из группировки «Бандиты». Применение более лёгких материалов позволило снизить массу самого костюма. Благодаря новой системе передвижения, удалось достичь возможности бега. \n\nВНИМАНИЕ! \n\nПри разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-тяжелая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/exo_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_band_05_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 127620
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 55 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 12
}
ITEM.exRender = true

--[[ITEM.functions.duse = { --экза
name = "Разобрать",
sound = "interface/money_"..math.random(1, 2)..".ogg",
icon = "icon16/cup.png", 
onRun = function(item) 
	if (item.player:getChar():getInv():hasItem("cw_extrema_ratio_official")) then
		if (item.player:getChar():getInv():hasItem("crowboar")) then
			item.player:getChar():getInv():add("trapk")
			item.player:getChar():getInv():add("trapk")
			item.player:getChar():getInv():add("armbr")
			item.player:getChar():getInv():add("armbr")
			item.player:getChar():getInv():add("dharmor")
			item.player:getChar():getInv():add("dharmor")
			item.player:getChar():getInv():add("dlarmor")
			item.player:getChar():getInv():add("plate")
			item.player:getChar():getInv():add("plate")
			item.player:getChar():getInv():add("kevlar")
		end
	end
	return false
end
}]]

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
			item.player:getChar():getInv():add("armbr")
			item.player:getChar():getInv():add("armbr")
			item.player:getChar():getInv():add("dharmor")
			item.player:getChar():getInv():add("dharmor")
			item.player:getChar():getInv():add("dlarmor")
			item.player:getChar():getInv():add("plate")
			item.player:getChar():getInv():add("plate")
			item.player:getChar():getInv():add("kevlar")
		end
	end,
	
	-- Вызывается когда проп лежит на земле, чтобы не вылезал подпункт - закурить
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

--[[ITEM.functions.duse = { --сева
name = "Разобрать",
sound = "interface/money_"..math.random(1, 2)..".ogg",
icon = "icon16/cup.png", 
onRun = function(item) 
	if (item.player:getChar():getInv():hasItem("cw_extrema_ratio_official")) then
		if (item.player:getChar():getInv():hasItem("crowboar")) then
			item.player:getChar():getInv():add("trapk")
			item.player:getChar():getInv():add("trapk")
			item.player:getChar():getInv():add("armbr")
			item.player:getChar():getInv():add("dharmor")
			item.player:getChar():getInv():add("plate")
			item.player:getChar():getInv():add("kevlar")
		end
	end
	return false
end
}]]

--[[ITEM.functions.duse = { --заря
name = "Разобрать",
sound = "interface/money_"..math.random(1, 2)..".ogg",
icon = "icon16/cup.png", 
onRun = function(item) 
	if (item.player:getChar():getInv():hasItem("cw_extrema_ratio_official")) then
		if (item.player:getChar():getInv():hasItem("crowboar")) then
			item.player:getChar():getInv():add("trapk")
			item.player:getChar():getInv():add("trapk")
			item.player:getChar():getInv():add("trapk")
			item.player:getChar():getInv():add("armbr")
			item.player:getChar():getInv():add("dlarmor")
			item.player:getChar():getInv():add("dlarmor")
			item.player:getChar():getInv():add("kevlar")
		end
	end
	return false
end
}
]]
