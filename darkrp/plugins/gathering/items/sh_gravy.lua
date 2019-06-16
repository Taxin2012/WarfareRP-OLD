ITEM.name = "«Грави»"
ITEM.desc = "Артефакт образуется при длительном гравитационном воздействии на металлосодержащие вещества. Способен поддерживать антигравитационное поле. Многие сталкеры используют его так же, как и артефакт «Ночная звезда» – чтобы заметно уменьшить вес рюкзака. \n-артефакт \n\nРадиация +3 / сек"
ITEM.model = "models/predatorcz/stalker/artifacts/gravi.mdl"
ITEM.price = 40620
ITEM.width = 1
ITEM.height = 1
ITEM.isAnomaly = true

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
			item.player:getChar():getInv():add("simk_gravy")
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