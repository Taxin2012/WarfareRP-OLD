ITEM.name = "Нашивка «Военных»"
ITEM.desc = "Солдаты регулярных армейских частей. Охраняют подходы в закрытой территории Зоны, патрулируя периметр, расстреливая мутантов и отлавливая мародеров. Армейски спецназ - элитные подразделения. Как правило, высаживаются в Зоне для проведения спасательных операций. \n\nХАРАКТЕРИСТИКИ: \n-личная вещь \n-высокая ценнось"
ITEM.category = "misc"
ITEM.price = 2202
ITEM.exRender = true
ITEM.model = "models/hardbass/tfw_badge_military.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end