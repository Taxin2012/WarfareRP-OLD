ITEM.name = "Ручной фонарь"
ITEM.desc = "Для бойцов старой школы, очень прочный фонарь и, судя по потертостям, довольно-таки старый. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-требует подзарядку"
ITEM.model = "models/spenser/ssk/item_misery/flashlight_2.mdl"
ITEM.price = 2806
ITEM.permit = "misc"
ITEM.exRender = true

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

ITEM.iconCam = {
pos = Vector(94.19319152832, 79.052810668945, 59.12255859375),
ang = Angle(25, 220, 0),
fov = 4.3616951044045
}
