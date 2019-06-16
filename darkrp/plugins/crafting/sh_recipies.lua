local PLUGIN = PLUGIN

local RECIPE = {}
RECIPE.uid = "exo"
RECIPE.name = "Чертеж предмета - Тяжелая бронезащита"
RECIPE.category = "Бронезащита"
RECIPE.blueprint = "empty"
RECIPE.weight = 30800
RECIPE.desc = ""
RECIPE.noBlueprint = false
RECIPE.model = "models/hardbass/notes_paper_2.mdl"
RECIPE.width = 1
RECIPE.height = 1
RECIPE.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 3.3
}
RECIPE.exRender = true
RECIPE.items = {
	["trapk"] = 2,
	["armbr"] = 2,
	["kevlar"] = 1,
	["plate"] = 2,
	["dlarmor"] = 1,
	["dharmor"] = 2,
}
RECIPE.result = {
	["exo"] = 1,
}
RECIPES:Register( RECIPE )
 
local RECIPE = {}
RECIPE.uid = "sev"
RECIPE.name = "Чертеж предмета - Усиленная бронезащита"
RECIPE.category = "Бронезащита"
RECIPE.blueprint = "empty"
RECIPE.weight = 20800
RECIPE.desc = ""
RECIPE.noBlueprint = false
RECIPE.model = "models/hardbass/notes_paper_2.mdl"
RECIPE.width = 1
RECIPE.height = 1
RECIPE.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 3.3
}
RECIPE.exRender = true
RECIPE.items = {
	["trapk"] = 2,
	["armbr"] = 1,
	["kevlar"] = 1,
	["plate"] = 1,
	["dharmor"] = 1,
}
RECIPE.result = {
	["sev"] = 1,
}
RECIPES:Register( RECIPE ) 

local RECIPE = {}
RECIPE.uid = "zar"
RECIPE.name = "Чертеж предмета - Легкая бронезащита"
RECIPE.category = "Бронезащита"
RECIPE.blueprint = "empty"
RECIPE.weight = 10800
RECIPE.desc = ""
RECIPE.noBlueprint = false
RECIPE.model = "models/hardbass/notes_paper_2.mdl"
RECIPE.width = 1
RECIPE.height = 1
RECIPE.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 3.3
}
RECIPE.exRender = true
RECIPE.items = {
	["trapk"] = 3,
	["armbr"] = 1,
	["kevlar"] = 1,
	["dlarmor"] = 2,
}
RECIPE.result = {
	["zar"] = 1,
}
RECIPES:Register( RECIPE ) 

