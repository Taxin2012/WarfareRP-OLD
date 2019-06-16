ITEM.name = "ОЦ-14-4А «Шторм» (заказной)"
ITEM.desc = "Опытный образец автоматно-гранатомётного комплекса, российская модификация стандартного «Гром-С14», созданная специально для действующих в Зоне спецподразделений. Отличается увеличенным размером магазина. \n\nБоеприпасы 9х39"
ITEM.price = 40488
ITEM.model = Model("models/weapons/w_stalker_oc14.mdl")
ITEM.class = "ssk_groza"
ITEM.weaponCategory = "1"
ITEM.category = "Оружие"
ITEM.height = 2
ITEM.width = 4
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(15, 200, 0.5),
	ang = Angle(0, 270, -2.3529412746429),
	fov = 9
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end