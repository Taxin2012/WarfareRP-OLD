ITEM.name = "«Выверт»"
ITEM.desc = "Артефакт причудливой формы, возникающий в местах повышенной гравитационной активности. Представляет собой своего рода губку, поглощающую радиоактивные элементы. В равной степени успешно защищает своего носителя от воздействия как наведённой радиации, так и уже попавших в организм радиоактивных частиц. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +4 / сек"
ITEM.model = "models/predatorcz/stalker/artifacts/vyvert.mdl"
ITEM.price = 16825
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
			item.player:getChar():getInv():add("simk_vyvert")
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("simkemp"):getID()) 
			item.player:Freeze(true)
		timer.Create("frizitem"..item.player:UniqueID(),5,1,function()
			item.player:Freeze(false)
		end)
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