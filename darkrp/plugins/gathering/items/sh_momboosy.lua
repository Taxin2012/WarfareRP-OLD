ITEM.name = "«Мамины бусы»"
ITEM.desc = "Артефакт кристаллизуется в аномальных зонах с высокой термальной активностью. Активно поглощает избыточное тепло, при этом оставаясь прохладным на ощупь. Многое в этом артефакте остаётся полной загадкой для учёных. Впрочем, точно установлено, что излучение, возникающее при пульсации утолщений «Маминых бус», ускоряет протекание метаболических процессов в организме. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +3 / сек"
ITEM.model = "models/predatorcz/stalker/artifacts/dummy_glassbeads.mdl"
ITEM.price = 33048
ITEM.width = 1
ITEM.height = 1
ITEM.isAnomaly = true
ITEM.iconCam = {
pos = Vector(182.3424987793, 152.55667114258, 114.61862945557),
ang = Angle(25, 220, 0),
fov = 4.7003422456651
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	icon = "icon16/cup.png",
	onRun = function(item)
		local client = item.player
		if (IsValid(item.player) && item.player:Alive()) then
			if !item.player:getChar():getInv():hasItem("simkemp") then
				item.player:notify("Вам нужны СИМК (пустой).")
				return false
			end
			item.player:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			item.player:getChar():getInv():add("simk_momboosy")
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("simkemp"):getID()) 
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		end
	end,

	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}