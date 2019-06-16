ITEM.name = "Плеер"
ITEM.desc = "Особый сталкерский плеер, с поддержкой пользовательской музыки, предназначен специально для Зоны. Работает на встроенной частице артефакта «Батарейка». Широкой популярности у сталкеров не приобрёл, но когда нет гитары, сойдёт и он.  \n\nХАРАКТЕРИСТИКИ: \n-повсеместное применение \n-используется для: прослушивания музыки \n-используется как: инструмент для разборки (многоразовый) \n-не требует подзарядки"
ITEM.price = 3271
ITEM.model = "models/hardbass/mp3_player.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 11.764705657959),
	fov = 2.9411764705882
}
ITEM.exRender = true

--[[ITEM.functions.Write = {
	tip = "useTip",
	icon = "icon16/font.png",
	onRun = function(item)	
	local canwrite = true
	local client = item.player
		netstream.Start(client, "receiveNote1", item:getID(), item:getData("text", ""), canwrite)	
		client:EmitSound("hgn/crussaria/items/itm_book_open.wav")
		return false
	end,
	onCanRun = function(item)
	end,
}]]