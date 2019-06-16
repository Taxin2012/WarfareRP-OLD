ITEM.name = "Гаусс-винтовка «Изделие 62» (заказной)"
ITEM.desc = "Сверхточное высокотхнологическое оружие, известное как «Изделие №62», было разработано конструкторами секретных лабараторий внутри Зоны. Принцип его действия основан на разгоне пули системной электромагнитов; пуля при этом способна развивать сверхточность, что обеспечивает колоссальную пробивную способность при почти полном отсутствии отдачи. Для обеспечения достаточной энергоемкости аккумуляторов используются частицы некоторых артефактов. \n\nБоеприпасы Аккумуляторы"
ITEM.price = 459504
ITEM.class = "ssk_gauss"
ITEM.weaponCategory = "1"
ITEM.category = "Оружие"
ITEM.model = "models/weapons/stalker_cop/w_gauss.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-10.5, 201, 2),
	ang = Angle(0, 270, 0),
	fov = 18
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