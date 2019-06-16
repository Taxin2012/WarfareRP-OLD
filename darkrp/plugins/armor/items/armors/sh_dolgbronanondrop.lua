ITEM.name = "ПСЗ-9д «Броня Долга»(заказной)"
ITEM.desc = "Ранняя модель комбинезона «Долга» — бронежилет спецназа серии ПС3-9, приспособленный для использования в условиях Зоны. Способен защитить от автоматной пули, но очень громоздок и почти не обеспечивает защиту от аномальных воздействий. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-усиленная бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/dolg_heavy_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_dolg_02_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 140000
ITEM.ric = 30  -- % шанс рикошета
ITEM.dmgsteal = 55 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(-2, 0, 200),
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