ITEM.name = "РПГ-7 (заказной)"
ITEM.desc = "Простота, прочность, низкая стоимость и эффективность РПГ-7 сделало его самым популярным безотказным противотанковым орудием в мире. В настоящее время он выпускаетсяв разных модификциях девятью странами и состоит на вооружении более 40 стран мира. \n\nБоеприпасы ОГ-7В"
ITEM.price = 60364
ITEM.class = ""
ITEM.weaponCategory = "1"
ITEM.category = "Оружие"
ITEM.model = "models/weapons/stalker_cop/w_rpg7.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(4, 200, 1),
	ang = Angle(0, 270, 0),
	fov = 21
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