ITEM.name = "Аккумулятор"
ITEM.desc = "Источник электричества для автономного питания. Рабочее напряжение: 1.5V. Продолжительность работы: 300 секунд. \n\nХАРАКТЕРИСТИКИ: \n-электроника \n-используется для: работы фонарика"
ITEM.price = 1040
ITEM.permit = "misc"
ITEM.functions.Use = {
	onRun = function(item)
		local character = item.player:getChar()
		character:setData("flashlightzarad", 300) -- кол-во дающие батарейкой
	end
}
ITEM.model = "models/hardbass/battery.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(52, 43.692253112793, 33.293754577637),
	ang = Angle(25, 220, 0),
	fov = 3.5
}
