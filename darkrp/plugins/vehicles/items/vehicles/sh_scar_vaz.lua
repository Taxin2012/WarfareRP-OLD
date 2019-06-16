-- SCARS Slim
-- http://steamcommunity.com/sharedfiles/filedetails/?id=104483020
-- Made for example.

ITEM.name = "ВАЗ-2121"
ITEM.model = "models/key.mdl"
ITEM.physDesc = ""
ITEM.width = 1
ITEM.height = 1
ITEM.maxGas = 1000
ITEM.price = 219080
ITEM.category = "Vehicles"
ITEM.vehicleData = {
	type = TYPE_GENERIC,
	model = "models/TailS Models/DayZ/Niva/niva.mdl",
	script = "scripts/vehicles/lada/vaz/niva.txt",
	name = ITEM.name,
	physDesc = ITEM.physDesc,
	maxGas = ITEM.maxGas,
	seats = {
		{
			pos = Vector(18.7, -4.0, 25.0),
			ang = Angle(0, 0, 0)
		},
		{
			pos = Vector(-14.0, -45.0, 25.0),
			ang = Angle(0, 0, 0)
		},
		{
			pos = Vector(18.0, -45.0, 25.0),
			ang = Angle(0, 0, 0)
		},
	}
}

ITEM.iconCam = {
	pos = Vector(0.10000000149012, 0.20000000298023, 200),
	ang = Angle(90, 0, -141.17646789551),
	fov = 2
}
ITEM.exRender = true
