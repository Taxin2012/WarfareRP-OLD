ITEM.name = "Экзоскелет «Свобода»(заказной)"
ITEM.desc = "Модернизация обычного экзоскелета. Применение более лёгких материалов позволило снизить массу самого костюма, а также повысить его износоустойчивость. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-тяжелая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/freedom_exo_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_free_04_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 187620
ITEM.ric = 30  -- % шанс рикошета
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