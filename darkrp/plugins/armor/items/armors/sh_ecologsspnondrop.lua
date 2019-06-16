ITEM.name = "Комбинезон ССП-99М(Не выпадает)"
ITEM.desc = "Высококачественный модифицированный комбинезон ССП-99. Добавлена защита торса от пулевого и осколочного повреждения. Предназначен для экипировки охраны научных экспедиций. Эффективная защита от радиации и биологических аномалий. Стоек к химически-агрессивным средам и другим вредным для организма воздействиям. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-усиленная бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/scientist_suit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_ecolog_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 76415
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 45 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(-9, 0, 200),
	ang = Angle(90, 0, -180),
	fov = 6
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