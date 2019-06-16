ITEM.name = "СВД «Рысь» (заказная)"
ITEM.desc = "Вариант снайперской винтовки СВД штучной сборки. Внешне не сильно отличается от старого образца, но в деле демонстрирует гораздо более внушительное соотношения точности и убойной силы. \n\nБоеприпасы 7,62х54"
ITEM.price = 81999
ITEM.class = "ssk_svd"
ITEM.weaponCategory = "1"
ITEM.category = "Оружие"
ITEM.exRender = true
ITEM.model = "models/weapons/ssk/spenser/w_ssk_svd.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-14, 200, 0),
	ang = Angle(0, 270, 0),
	fov = 14
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end