ITEM.name = "Нашивка «Свободы»"
ITEM.desc = "Анархисьы и сорвиголовы, объявившие себя борцами за свободу на территории Зоны, поэтому постоянно конфликтующие с армейскими подразделениями, военными сталкерами и группиовкой «Долг». \n\nХАРАКТЕРИСТИКИ: \n-личная вещь\n-высокая ценность"
ITEM.category = "misc"
ITEM.price = 2202
ITEM.exRender = true
ITEM.model = "models/hardbass/tfw_badge_freedom.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 1.7
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end