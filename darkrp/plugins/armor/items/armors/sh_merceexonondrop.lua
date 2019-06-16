ITEM.name = "Экзоскелет «Наёмника»(заказной)"
ITEM.desc = "Экспериментальный образец военного экзоскелета западного производства. Данный экзоскелет относится к третьему поколению. Используется наёмниками. Упор сделан на боевое применение, аномальная устойчивость низкая. Режим бега активирован. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-тяжелая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/merk_exo_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_merc_03_spen.mdl' --модель_игрока
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