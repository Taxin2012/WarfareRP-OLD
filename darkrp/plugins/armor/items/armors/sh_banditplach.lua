ITEM.name = "Черный кожаный плащ"
ITEM.desc = "Обычный плащ из чёрной кожи. Заметной защиты носителю не обеспечивает. Разве что не даст замёрзнуть ночью и смягчит укус слепого пса. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-тяжелая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.SetModel = 'models/spenser/ssk/new_band_04_spen.mdl' --модель_игрока
ITEM.price = 12697
ITEM.ric = 15  -- % шанс рикошета
ITEM.dmgsteal = 20 -- % поглощения урона
ITEM.model = "models/spenser/ssk/outfit/novice_outfit.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-2, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 8.4
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