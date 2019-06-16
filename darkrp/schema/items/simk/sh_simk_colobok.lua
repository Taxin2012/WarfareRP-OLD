ITEM.name = "СИМК с «Колобком»"
ITEM.desc = "«Колобок» — артефакт, порождаемый химической аномалией «газировка». Довольно редкий артефакт, образующийся в зонах сильного химического загрязнения. Весьма ценится за способность подстегнуть организм так, чтобы тот в считанные минуты восстановился после травм любой степени тяжести. Учёные распространяют информацию о воздействии артефакта на генетический материал владельца; впрочем, подтверждения этому пока нет. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-высокая ценность \n-не требует подзарядки \n-максимальная вместимость - 1 \n-состояние: заполнен (содержит артефакт «Колобок»)"
ITEM.category = "misc"
ITEM.price = 35976
ITEM.exRender = true
ITEM.model = "models/hardbass/lead_box_closed.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(188.89260864258, 158.1778717041, 123.99795532227),
	ang = Angle(25, 220, 0),
	fov = 3.5
}

ITEM.functions.Use = {
	name = "использовать",
	icon = "icon16/cup.png",
	onRun = function(item)
	local client = item.player
		if (IsValid(item.player) && item.player:Alive()) then
			item.player:EmitSound( Sound( "interface/inv_iam_open.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			item.player:getChar():getInv():add("colobok")
			item.player:getChar():getInv():add("simkemp")
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		end
	end,
	
	-- Вызывается когда проп лежит на земле, чтобы не вылезал подпункт - закурить
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}