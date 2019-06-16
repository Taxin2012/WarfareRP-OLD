ITEM.name = "Бандитский комбинезон (заказной)"
ITEM.desc = "Комбинезон бандитов, созданный для проведения штурмовых операций. Отличается лишь цветовым решением, характеристиками которые хуже чем у стандартного комбеза наёмников и отсутствием противогаза, идущего в комплекте комбинезоном наёмников. Был куплен партией у Наёмников как устаревший уже вариант их комбинезона при их непосредственном нейтралитете с Бандитами."
ITEM.model = 'models/spenser/ssk/outfit/bandit_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_band_02_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 89000
ITEM.ric = 20  -- % шанс рикошета
ITEM.dmgsteal = 45 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(-6, 0, 200),
	ang = Angle(90, 0, 180),
	fov = 7
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