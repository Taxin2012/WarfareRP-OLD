ITEM.name = "РГ-6 (заказной)"
ITEM.desc = "Гранатомет револьверного тип используется для повышения огневой мощи пехоты в условиях городского боя. Применялся в некоторых локальных конфликтах, например в Чечне. Камеры барабана переднего заряжания, образованы шестью нарезными стволами, идентичными используемым в подствольных гранатометах. \n\nБоеприпасы ВОГ-25"
ITEM.price = 51072
ITEM.class = ""
ITEM.weaponCategory = "1"
ITEM.category = "Оружие"
ITEM.model = "models/weapons/w_stalker_rg6.mdl"
ITEM.width = 4
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(7.8000001907349, 200, 0),
	ang = Angle(0, 270, 0),
	fov = 9.4
}
ITEM.exRender = true
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end