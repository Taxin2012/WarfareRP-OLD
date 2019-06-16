ITEM.name = "Экзоскелет «Чистого Неба»(заказной)"
ITEM.desc = "Модернизация обычного экзоскелета, созданная при участии ремесленников из группировки «Чистое небо». Применение более легких материалов позволило снизить массу самого костюма. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-тяжелая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/cs_exo_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_nebo_05_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 187620
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 55 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(1, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 11
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