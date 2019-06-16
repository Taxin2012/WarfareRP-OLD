ITEM.name = "Бронежилет ЧН-3a (заказной)"
ITEM.desc = "Штатная экипировка штурмовых отрядов «Чистого неба». Бронежилет способен остановить пистолетную пулю, а встроеный противогаз и брезентовый комбинезон с особой пропиткой обеспечивает хорошую защиту от аномальных воздействий. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-тяжелая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/cs_heavy_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_nebo_04_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 64860
ITEM.ric = 30  -- % шанс рикошета
ITEM.dmgsteal = 50 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(-1, 2, 200),
	ang = Angle(90, 0, 0),
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