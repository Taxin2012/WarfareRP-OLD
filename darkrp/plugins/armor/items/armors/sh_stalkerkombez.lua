ITEM.name = "Комбинезон «Заря»"
ITEM.desc = "Производимый народными умельцами комбинезон сталкера представляет собой сочетание двухслойной прорезиненной ткани с плексигласовой прокладкой и встроенного бронежилета. Несмотря на то, что бронежилет пробивается даже пистолетной пулей, костюм очень распространён из-за дешевизны и широких возможностей. \n\nВНИМАНИЕ! \n\nПри разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-легкая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/stalker_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_stalk_02a_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 40753
ITEM.ric = 20  -- % шанс рикошета
ITEM.dmgsteal = 30 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(-5, 2, 200),
	ang = Angle(90, 0, 0),
	fov = 7.8
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