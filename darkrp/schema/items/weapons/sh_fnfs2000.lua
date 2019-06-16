ITEM.name = "FN FS2000 (заказной)"
ITEM.desc = "Бельгийский автоматно-гранатомётный комплекс, выполненный в компоновке «булл-пап». Оснащён компьютеризованным прицелом и подствольным гранатомётом. Встречается только у ветеранов и мастеров в экзоскелетах. \n\nБоеприпасы 5.56х45"
ITEM.price = 45112
ITEM.model = Model("models/weapons/w_stalker_f2000.mdl")
ITEM.class = "ssk_fn2000"
ITEM.weaponCategory = "1"
ITEM.category = "Оружие"
ITEM.height = 2
ITEM.width = 4
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(13, 200, 1),
	ang = Angle(0, 270, 0),
	fov = 10
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end