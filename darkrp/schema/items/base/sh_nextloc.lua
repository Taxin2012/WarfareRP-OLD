ITEM.name = "Синхронизатор"
ITEM.desc = "Синхронизирует игрока между локациями"
ITEM.price = 0
ITEM.model = "models/hardbass/notes_paper_1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2.3
}

ITEM.functions.Use = {
	name = "удалить",
	onRun = function(item)
		local client = item.player
		item.player:getChar():giveMoney(0)
	end
}