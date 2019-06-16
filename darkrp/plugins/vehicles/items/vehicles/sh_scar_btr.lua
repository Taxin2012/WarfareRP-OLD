-- SCARS Slim
-- http://steamcommunity.com/sharedfiles/filedetails/?id=104483020
-- Made for example.

ITEM.name = "БТР-70"
ITEM.model = "models/key.mdl"
ITEM.physDesc = ""
ITEM.width = 1
ITEM.height = 1
ITEM.maxGas = 1000
ITEM.price = 598990
ITEM.category = "Vehicles"
ITEM.vehicleData = {
	type = TYPE_GENERIC,
	model = "models/_tails_ models/btr70/btr70.mdl",
	script = "scripts/vehicles/stalker/btr70.txt",
	name = ITEM.name,
	physDesc = ITEM.physDesc,
	maxGas = ITEM.maxGas,
	seats = {
		{
			pos = Vector(-30.0,-30.0,72.0),
			ang = Angle(0,90,0)
		},
		{
			pos = Vector(30.0,-30.0,72.0),
			ang = Angle(0,-90,0)
		},
		{
			pos = Vector(-30.0,-0.0,72.0),
			ang = Angle(0,90,0)
		},
		{
			pos = Vector(-30.0,30.0,72.0),
			ang = Angle(0,90,0)
		},
		{
			pos = Vector(-30.0,60.0,72.0),
			ang = Angle(0,90,0)
		},
		{
			pos = Vector(-30.0,-0.0,72.0),
			ang = Angle(0,-90,0)
		},
		{
			pos = Vector(30.0,30.0,72.0),
			ang = Angle(0,-90,0)
		},
		{
			pos = Vector(30.0,60.0,72.0),
			ang = Angle(0,-90,0)
		},
	}
}

ITEM.iconCam = {
	pos = Vector(0.10000000149012, 0.20000000298023, 200),
	ang = Angle(90, 0, -141.17646789551),
	fov = 2
}
ITEM.exRender = true
