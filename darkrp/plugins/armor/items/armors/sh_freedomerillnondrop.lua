ITEM.name = "Комбинезон наёмника(заказной)"
ITEM.desc = "Комбинезон сталкера из группировки наёмники. За основу взяты образцы экипировки спецназа западных армий. За счёт специальной обработки ткани усилена устойчивость брони при физическом смещении пластин. По защитным характеристикам немного превосходит армейские бронежилеты серии ПСЗ-7. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-усиленная бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/merc_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_merc_01a_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 57000
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 45 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(-13, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 8
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