ITEM.name = "Свободовский «Берилл-5М»(заказной)"
ITEM.desc = "Бронекостюм, который является переделкой «Берилл-5М» мастерами «Свободы». От последнего отличается немного большей противоаномальной защитой и встроенным контейнером для артефактов. Однако его противоаномальная защита хуже, чем у ЧН-3а и такие же свойства брони и система прокачки. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-усиленная бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.model = 'models/spenser/ssk/outfit/svoboda_heavy_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/spenser/ssk/new_free_03_spen.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 150000
ITEM.ric = 30  -- % шанс рикошета
ITEM.dmgsteal = 50 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(-3, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 7.5
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