ITEM.name = "Административные документы"
ITEM.desc = ""
ITEM.price = 6900
ITEM.model = "models/stalker/item/handhelds/files1.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(204.95802307129, 168.94920349121, 124.21566009521),
	ang = Angle(25, 220, 0),
	fov = 6
}
ITEM.exRender = true

ITEM.functions.Use = {
	icon = "icon16/cup.png",
	onRun = function(item)
				--item.player:OpenURL("steam://connect/192.168.10.101:27015")	
				item.player:OpenURL("steam://connect/192.168.10.101:27017")				
		return false
	end,
}