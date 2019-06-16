ITEM.name = "«Батарейка»"
ITEM.desc = "Редкий, довольно дорогой артефакт, образующийся в аномалиях электрического типа, немного повышает мышечный тонуc. Известно, что в состав этого артефакта входят электростатические элементы, однако в каких именно условиях он формируется, науке пока не известно. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +2 / сек"
ITEM.model = "models/predatorcz/stalker/artifacts/dummy_battery.mdl"
ITEM.price = 19752
ITEM.width = 1
ITEM.height = 1
ITEM.isAnomaly = true
ITEM.iconCam = {
pos = Vector(-1, 200, 6),
ang = Angle(0, 270, 0),
fov = 4
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	icon = "icon16/cup.png",
	onRun = function(item)
		local client = item.player
		if (IsValid(item.player) && item.player:Alive()) then
			if !item.player:getChar():getInv():hasItem("simkemp") then
				item.player:notify("Вам нужны СИМК (пустой).")
				return false
			end
			item.player:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			item.player:getChar():getInv():add("simk_batary")
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("simkemp"):getID()) 
		end
	end,

	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}