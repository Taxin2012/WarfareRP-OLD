ITEM.name = "Комбенизон ренегатов"
ITEM.desc = "Современная модель комбинезона «Ренегатов». Больше подходит новобранцам из сталкеров, которые привыкли к относительно лёгким костюмам. Обеспечивает хорошую защиту от аномального воздействия и при этом способен остановить пистолетную пулю и некоторые автоматные пули. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-усиленная бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.SetModel = 'models/spenser/ssk/new_renegat_02_spen.mdl' --модель_игрока
ITEM.price = 47544
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 35 -- % поглощения урона
ITEM.model = "models/stalker/outfit/bandit2.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(3, -0.20000000298023, 200),
	ang = Angle(90, 0, -180),
	fov = 5.7
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
