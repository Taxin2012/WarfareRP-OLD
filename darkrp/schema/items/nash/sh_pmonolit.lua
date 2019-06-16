ITEM.name = "Нашивка «Монолита»"
ITEM.desc = "Группировка, скорее напоминающая религиозную секту. Ее члены верят, что в центре Зоны покоится эволюционный кристалл неземного происхождения - Монолит. \n\nХАРАКТЕРИСТИКИ: \n-личная вещь \n-высокая ценность"
ITEM.category = "misc"
ITEM.price = 2202
ITEM.exRender = true
ITEM.model = "models/hardbass/tfw_badge_monolith.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end