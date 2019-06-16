ITEM.name = "СИМК с «Вспышкой»"
ITEM.desc = "«Вспышка» — артефакт, образующийся в местах, насыщенных электромагнитным полем. Не так редок, но и не так распространён. Имеет удивительное свойство поглощать электрический ток, перенаправляя разряды с организма на себя. «Заряженные» Вспышки в быту используют в качестве «маленьких электростанций».Образуется в аномалиях типа «электра». \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-высокая ценность \n-не требует подзарядки \n-максимальная вместимость - 1 \n-состояние: заполнен (содержит артефакт «Вспышка»)"
ITEM.category = "misc"
ITEM.price = 11964
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
			item.player:getChar():getInv():add("flash")
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