ITEM.name = "Maverick 88 Хищник (заказной)"
ITEM.desc = "Собранный на заказ помповый дробовик - бывшая собственность Звуробоя. Гладкоствольное помповое ружье Maverick 88 американского производства, представляет собой более дешевую версию помпового дробовика Mossberg 500. 18,5-дюймовый ствол позволяет хранить 5 патронов в трубчатом магазине и 1 в 3-дюймовой каморе. Этот дробовик черезвычайно популярен во всем мире благодаря выдающейся надежности и быстрой перезарядке. \n\nБоеприпасы 12x70"
ITEM.price = 43076
ITEM.class = "ssk_win"
ITEM.weaponCategory = "detector"
ITEM.category = "Оружие"
ITEM.exRender = true
ITEM.width = 5
ITEM.height = 1
ITEM.model = "models/weapons/ssk/spenser/w_ssk_win.mdl"
ITEM.iconCam = {
	pos = Vector(-16, 200, -0.10000000149012),
	ang = Angle(0, 270, 0),
	fov = 13
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end