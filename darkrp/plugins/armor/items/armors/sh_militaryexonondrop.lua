ITEM.name = "Экзоскелет «Военных»(заказной)"
ITEM.desc = "Модернизация обычного экзоскелета. Создан в одном из оборонных украинских НИИ специально для Военных. Применение более тяжёлых и жёстких материалов позволило повысить массу самого костюма в счёт улучшения, и усиления характеристик самого костюма. Благодаря новой системе передвижения, удалось достичь возможности бега. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-тяжелая бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/exo_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_solder_06_spen.mdl' --модель_игрока
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