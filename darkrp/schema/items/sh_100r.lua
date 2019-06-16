ITEM.name = "100 Рублей"
ITEM.desc = "Российские рубли, обычно хранят в кошельке, неотъемлемая часть торговлю. \n\nХАРАКТЕРИСТИКИ: \n-высокая ценность \n-для использования нужен кошелек"
ITEM.price = 100
ITEM.model = "models/hardbass/money_100.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 3
}
ITEM.exRender = true

ITEM.functions.Use = {
	icon = "icon16/cup.png",
	onRun = function(item)
		if (IsValid(item.player) && item.player:Alive()) then
			if !item.player:getChar():getInv():hasItem("kowelek") then
				item.player:notify("У вас нет кошелька!")
				return false
			end
			
			if (math.random(1,10) >= 5) then
				local cough = {
					"interface/money_1.ogg",
					"interface/money_2.ogg",
					"interface/money_2.ogg",
					"interface/money_1.ogg"
				}
				item.player:EmitSound(cough[math.random(1,#cough)], 50, 100)
			end;
			--sound = "interface/money_"..math.random(1, 2)..".ogg",
			item.player:getChar():giveMoney(100)
		end
	end,
	
	-- Вызывается когда проп лежит на земле, чтобы не вылезал подпункт - закурить
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}