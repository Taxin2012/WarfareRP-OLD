ITEM.name = "Канистра (8 литров)"
ITEM.model = "models/z-o-m-b-i-e/st/balon/st_kanistra_01.mdl"
ITEM.desc = "Большая, наполовину пустая металлическая канистра с 95-м бензином. Канистры поставлялись в зону в больших количествах следом за украиноской военной техникой. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-топливо для приготовления пищи \n-используется для: заправки машин"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1609
ITEM.iconCam = {
pos = Vector(-200, 0, 12),
ang = Angle(0, -0, 0),
fov = 8
}
ITEM.exRender = true
ITEM.kerosinAmount = 8

ITEM:hook("use", function(item)
	item.player:EmitSound("items/battery_pickup.wav")
end)

ITEM.functions._use = { 
	name = "Заправить",
	tip = "useTip",
	icon = "icon16/world.png",
	onRun = function(item)
		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)
		local ent = trace.Entity

		if (ent and IsValid(ent) and ent.spawnedVehicle) then
			local percent = 0
			ent:fillGas(1000)
			percent = (ent:getNetVar("gas") / ent.maxGas)*100

			client:notify(L("vehicleGasFilled", client, percent))

			return true
		else
			client:notify(L("vehicleGasLook", client))
		end

		return false
	end,
	onCanRun = function(item)
		return (!item:getData("spawned"))
	end
}