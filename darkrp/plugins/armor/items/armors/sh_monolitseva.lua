ITEM.name = "Научный комбинезон «Монолита»"
ITEM.desc = "Научный комбинезон «Монолита» — бронекостюм с замкнутой системой дыхания, принадлежащий бойцам группировки «Монолит». \n\nХАРАКТЕРИСТИКИ: \n-легкая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.SetModel = 'models/spenser/ssk/new_mono_03_spen.mdl' --модель_игрока
ITEM.price = 69000
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 45 -- % поглощения урона
ITEM.model = "models/spenser/ssk/outfit/monolith_scientific_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 7
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
			item.player:getChar():getInv():add("armbr")
			item.player:getChar():getInv():add("dharmor")
			item.player:getChar():getInv():add("plate")
			item.player:getChar():getInv():add("kevlar")
		end
	end,
	
	-- Вызывается когда проп лежит на земле, чтобы не вылезал подпункт - закурить
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}