ITEM.name = "Бинт"
ITEM.desc = "Аспетический бинт для остановки кровотечения и предотвращения попадания в рану инфекции. При обычном кровотечении позволяет перевязать рану, при артериальном - перетянуть артерию. \n\nХАРАКТЕРИСТИКИ: \n-изделие первой помощи"
ITEM.category = "Medical"
ITEM.desc = ""
ITEM.model = "models/medic/bandage.mdl"
ITEM.price = 520
ITEM.functions.Use = {
	sound = "interface/inv_bandage_2p9.ogg",
	onRun = function(item)
		local client = item.player
		client:Freeze(true)
		timer.Create("frizitem"..client:UniqueID(),5,1,function()
			client:Freeze(false)
		end)
		local ply = item.player
		ply:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		ply:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		item.player:SetHealth(math.min(item.player:Health() + 12, 100))
	end
}