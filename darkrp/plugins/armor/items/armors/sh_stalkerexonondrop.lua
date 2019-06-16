﻿ITEM.name = "Экзоскелет(заказной)"
ITEM.desc = "Экспериментальный образец военного экзоскелета. В серийное производство не пошёл ввиду чрезвычайно высокой себестоимости и некоторых огрехов в проектировании. Несмотря на это, из-за возможности значительно увеличивать мобильность носителя пользуется спросом и потому негласно выпускается малыми партиями за пределами Украины. \n\nВНИМАНИЕ! \n\nПри разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-тяжелая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/exo_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_stalk_04_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 187620
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 55 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
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

