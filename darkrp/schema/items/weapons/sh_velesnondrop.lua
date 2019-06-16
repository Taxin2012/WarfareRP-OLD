ITEM.name = "Детектор «Велес» (заказной)"
ITEM.desc = "Современный детектор аномалий, определяющий точное месторасположение почти всех известных науке артефактов. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-не требует подзарядки"
ITEM.price = 16074
ITEM.class = "detector_veles"
ITEM.weaponCategory = "detector"
ITEM.category = "Оружие"
ITEM.exRender = true
ITEM.model = "models/kali/miscstuff/stalker/detector_veles.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(79.699996948242, 115, 128),
	ang = Angle(42.352939605713, -124.70587921143, -56.470588684082),
	fov = 2.4
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end