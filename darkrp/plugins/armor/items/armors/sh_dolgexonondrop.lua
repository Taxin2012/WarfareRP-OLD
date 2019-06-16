ITEM.name = "Экзоскелет «Долга»(заказной)"
ITEM.desc = "Отечественная разработка одного из НИИ специально для группировки «Долг». Боевые функции преобладают, большая грузоподъемность. Большой вес костюма однако не исключает возможность бегать в нем. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-тяжелая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/stalker/outfit/dolg_exo.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_dolg_04_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 187620
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 55 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 180),
	fov = 12
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