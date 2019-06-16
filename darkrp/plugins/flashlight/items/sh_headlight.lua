ITEM.name = "Налобный фонарик"
ITEM.desc = "Фонарь с креплением на голову. Пригодится сталкеру, которого ночь застала в дороге; с другой стороны, может привлечь чье-то нежелательное внимаение. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-умеренное потребление энергии"
ITEM.category = "misc"
ITEM.price = 5048
ITEM.exRender = true
ITEM.model = "models/hardbass/dev_torch_light.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(119.23235321045, 101.92781829834, 74.400001525879),
	ang = Angle(25, 220, 0),
	fov = 6
}

ITEM:hook("drop", function(item)
	if (item.player:FlashlightIsOn()) then
		item.player:Flashlight(false)
	end
end)

function ITEM:onTransfered()
	local client = self:getOwner()

	if (IsValid(client) and client:FlashlightIsOn()) then
		client:Flashlight(false)
	end
end