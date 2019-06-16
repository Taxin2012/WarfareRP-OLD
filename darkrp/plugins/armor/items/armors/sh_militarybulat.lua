ITEM.name = "Бронекостюм «Булат»"
ITEM.desc = "Современный армейский бронекостюм для проведения штурмовых операций в зонах аномальной активности. Компоненты: тяжёлый бронежилет серии ПСЗ-12п, комбинезон аномальной защиты и компенсационный костюм. Предоставляет великолепную защиту от пуль и осколков и при этом удобен, почти не ограничивает подвижность носителя. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-усиленная бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.SetModel = 'models/spenser/ssk/new_solder_02_spen.mdl' --модель_игрока
ITEM.model = 'models/stalker/outfit/mili_heavy.mdl'
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(2, 0, 200),
	ang = Angle(90, 0, -180),
	fov = 8
}
ITEM.exRender = true
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 50 -- % поглощения урона
ITEM.price = 77127

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