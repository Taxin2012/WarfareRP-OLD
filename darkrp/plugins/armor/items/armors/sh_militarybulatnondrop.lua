ITEM.name = "Бронекостюм «Булат»(заказной)"
ITEM.desc = "Современный армейский бронекостюм для проведения штурмовых операций в зонах аномальной активности. Компоненты: тяжёлый бронежилет серии ПСЗ-12п, комбинезон аномальной защиты и компенсационный костюм. Предоставляет великолепную защиту от пуль и осколков и при этом удобен, почти не ограничивает подвижность носителя. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-усиленная бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/specops2_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_solder_02_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 77127
ITEM.ric = 30  -- % шанс рикошета
ITEM.dmgsteal = 50 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(2, 0, 200),
	ang = Angle(90, 0, -180),
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