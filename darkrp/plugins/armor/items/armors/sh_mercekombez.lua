ITEM.name = "Комбинезон наёмника"
ITEM.desc = "Комбинезон сталкера из группировки наёмники. За основу взяты образцы экипировки спецназа западных армий. За счёт специальной обработки ткани усилена устойчивость брони при физическом смещении пластин. По защитным характеристикам немного превосходит армейские бронежилеты серии ПСЗ-7. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-легкая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/merc_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_merc_01a_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 57000
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 45 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(-12, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 6.2
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