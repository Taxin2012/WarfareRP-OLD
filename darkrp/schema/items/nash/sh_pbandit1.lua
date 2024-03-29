﻿ITEM.name = "Нашивка «Бандитов»"
ITEM.desc = "Представители криминального мира, пришедшие в Зону по разным причинам: заработать на продаже артефактов, скрыться от закона, купить или продать оружие. В Зоне много подобного элемента уровнем от шпаны до серьезных уголовников. В большинстве объединяются в банды. Хотя единой бандитской организации в Зоне до сих пор нет. \n\nХАРАКТЕРИСТИКИ: \n-личная вещь \n-высокая ценность"
ITEM.category = "misc"
ITEM.price = 2202
ITEM.exRender = true
ITEM.model = "models/spenser/ssk/item_misery/badges.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0.25, 200),
	ang = Angle(90, 0, -180),
	fov = 0.8
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end