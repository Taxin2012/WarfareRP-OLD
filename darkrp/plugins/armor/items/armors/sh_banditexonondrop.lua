ITEM.name = "Экзоскелет «Бандитов»(Не выпадает)"
ITEM.desc = "Модернизация обычного экзоскелета. Создан при участии ремесленников из группировки «Бандиты». Применение более лёгких материалов позволило снизить массу самого костюма. Благодаря новой системе передвижения, удалось достичь возможности бега."
ITEM.model = 'models/spenser/ssk/outfit/exo_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_band_05_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 127620
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