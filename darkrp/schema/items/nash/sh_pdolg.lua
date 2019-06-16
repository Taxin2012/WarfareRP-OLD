ITEM.name = "Нашивка «Долга»"
ITEM.desc = "Явно военизированная группировка, отличающаяся строгой дисциплиной: ее члены живут фактически по уставу. Только представители «Долга» не торгуют уникальными порождениями Зоны с внешним миром: по слухам, все найденные этими людьми артефакты сдаются ученым. \n\nХАРАКТЕРИСТИКИ: \n-личная вещь \n-высокая ценность"
ITEM.category = "misc"
ITEM.price = 2202
ITEM.exRender = true
ITEM.model = "models/hardbass/tfw_badge_dolg.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 1.7
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end