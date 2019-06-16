ITEM.name = "Нашивка «Ренегатов»"
ITEM.desc = "Немногочисленная группировка, состоящая исключительно из самых презренных личностей Зоны. Бандиты, мародеры, предатели и рецидивисты - бывшие члены других группировок, изменившие и предавшие свои взгляды. Этот сброд не имеет организованной структуры и лидера как такового. \n \nХАРАКТЕРИСТИКИ: \n-личная вещь \n-высокая ценность"
ITEM.category = "misc"
ITEM.price = 2202
ITEM.exRender = true
ITEM.model = "models/hardbass/tfw_badge_renegade.mdl"
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