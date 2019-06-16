ITEM.name = "Синхронизатор со Свалки в Бар"
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

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end