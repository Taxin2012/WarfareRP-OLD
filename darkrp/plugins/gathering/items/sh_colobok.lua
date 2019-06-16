ITEM.name = "«Колобок»"
ITEM.desc = "Колобок — артефакт, порождаемый химической аномалией «газировка». Довольно редкий артефакт, образующийся в зонах сильного химического загрязнения. Весьма ценится за способность подстегнуть организм так, чтобы тот в считанные минуты восстановился после травм любой степени тяжести. Учёные распространяют информацию о воздействии артефакта на генетический материал владельца; впрочем, подтверждения этому пока нет. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +3 / сек"
ITEM.model = "models/predatorcz/stalker/artifacts/fuzz kolobok.mdl"
ITEM.price = 32976
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
			item.player:getChar():getInv():add("simk_colobok")
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("simkemp"):getID()) 
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		item.player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		end
	end,

	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}