ITEM.name = "Экзоскелет Генерала Шепарда"
ITEM.desc = "Военная броня созданная для разведки в единичном экземпляре. Имеет бронежилет со встроенными кевларовыми пластинами. Лицо защищено от прямых попаданий. Но не обеспечивает хорошую защиту от аномалий. \n\nХАРАКТЕРИСТИКИ: \n-личная броня \n-тяжелая защита \n-высокая ценность"
ITEM.model = 'models/spenser/ssk/outfit/specops2_outfit.mdl' --модель_вещи
ITEM.SetModel = 'models/player/cubanmerc_male.mdl' --модель_игрока
ITEM.width = 2
ITEM.height = 3
ITEM.price = 119000
ITEM.ric = 25  -- % шанс рикошета
ITEM.dmgsteal = 55 -- % поглощения урона
ITEM.iconCam = {
	pos = Vector(-3, 0, 200),
	ang = Angle(90, 0, -180),
	fov = 8
}
ITEM.exRender = true