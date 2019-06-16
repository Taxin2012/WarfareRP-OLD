PLUGIN.name = "Storage"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Provides the ability to store items."

PLUGIN.definitions = PLUGIN.definitions or {}
STORAGE_DEFINITIONS = PLUGIN.definitions

nut.util.include("sh_definitions.lua")

for k, v in pairs(PLUGIN.definitions) do
	if (v.name and v.width and v.height) then
		nut.item.registerInv("st"..v.name, v.width, v.height)
	else
		ErrorNoHalt("[NutScript] Storage for '"..k.."' is missing all inventory information!\n")
		PLUGIN.definitions[k] = nil
	end
end

nut.config.add("saveStorage", true, "Whether or not storages will save after a server restart.", nil, {
	category = "Storage"
})

if (SERVER) then
	function PLUGIN:PlayerSpawnedProp(client, model, entity)
		local data = STORAGE_DEFINITIONS[model:lower()]

		if (data) then
			if (hook.Run("CanPlayerSpawnStorage", client, model, entity) == false) then return end
			
			local storage = ents.Create("nut_storage")
			storage:SetPos(entity:GetPos())
			storage:SetAngles(entity:GetAngles())
			storage:Spawn()
			storage:SetModel(model)
			storage:SetSolid(SOLID_VPHYSICS)
			storage:PhysicsInit(SOLID_VPHYSICS)

			nut.item.newInv(0, "st"..data.name, function(inventory)
				inventory.vars.isStorage = true
				if (IsValid(storage)) then
					storage:setInventory(inventory)
				end
			end)

			self:saveStorage()
			entity:Remove()
		end
	end

	function PLUGIN:CanSaveStorage(entity, inventory)
		return nut.config.get("saveStorage", true)
	end

	function PLUGIN:saveStorage()
  	local data = {}

  	for k, v in ipairs(ents.FindByClass("nut_storage")) do
  		if (hook.Run("CanSaveStorage", v, v:getInv()) != false) then
  			if (v:getInv()) then
  				data[#data + 1] = {v:GetPos(), v:GetAngles(), v:getNetVar("id"), v:GetModel(), v.password}
			end
		else
			local index = v:getNetVar("id")
			nut.db.query("DELETE FROM nut_items WHERE _invID = "..index)
			nut.db.query("DELETE FROM nut_inventories WHERE _invID = "..index)
  		end
  	end

  	self:setData(data)
  end

	function PLUGIN:SaveData()
		self:saveStorage()
	end

	function PLUGIN:StorageItemRemoved(entity, inventory)
		self:saveStorage()
	end

	function PLUGIN:StorageCanTransfer(inventory, client, oldX, oldY, x, y, newInvID)
		local inventory2 = nut.item.inventories[newInvID]

		print(inventory2)
	end

	function PLUGIN:LoadData()
		local data = self:getData()

		if (data) then
			for k, v in ipairs(data) do
				local data2 = self.definitions[v[4]:lower()]

				if (data2) then
					local storage = ents.Create("nut_storage")
					storage:SetPos(v[1])
					storage:SetAngles(v[2])
					storage:Spawn()
					storage:SetModel(v[4])
					storage:SetSolid(SOLID_VPHYSICS)
					storage:PhysicsInit(SOLID_VPHYSICS)	

					if (v[5]) then
						storage.password = v[5]
						storage:setNetVar("locked", true)
					end
					
					nut.item.restoreInv(v[3], data2.width, data2.height, function(inventory)
						inventory.vars.isStorage = true
						
						if (IsValid(storage)) then
							storage:setInventory(inventory)
						end
					end)

					local physObject = storage:GetPhysicsObject()

					if (physObject) then
						physObject:EnableMotion()
					end
				end
			end
		end
	end

	netstream.Hook("invExit", function(client)
		local entity = client.nutBagEntity

		if (IsValid(entity)) then
			entity.receivers[client] = nil
		end

		client.nutBagEntity = nil
	end)

	netstream.Hook("invLock", function(client, entity, password)
		local dist = entity:GetPos():Distance(client:GetPos())

		if (dist < 128 and password) then
			if (entity.password and entity.password == password) then
				entity:OpenInv(client)
			else
				client:notifyLocalized("wrongPassword")
			end
		end
	end)
else
	local PLUGIN = PLUGIN

	netstream.Hook("invLock", function(entity)
		Derma_StringRequest(
			L("storPassWrite"),
			L("storPassWrite"),
			"",
			function(val)
				netstream.Start("invLock", entity, val)
			end
		)
	end)

	netstream.Hook("invOpen", function(entity, index)
		local inventory = nut.item.inventories[index]

		if (IsValid(entity) and inventory and inventory.slots) then
			local data = PLUGIN.definitions[entity:GetModel():lower()]

			if (data) then	
				nut.gui.inv1 = vgui.Create("nutInventory")
				nut.gui.inv1:ShowCloseButton(false)
				nut.gui.inv1:storageBackGround()
				nut.gui.inv1:backGround()
				nut.gui.inv1:closeButton()

				if ScrW() == 1920 then -- Screen fix
					nut.gui.inv1:SetPos(1243, 135)
				elseif ScrW() == 1600 and ScrH() == 1024 then
					nut.gui.inv1:SetPos(1033, 125)	
				elseif ScrW() == 1600 and ScrH() == 900 then
					nut.gui.inv1:SetPos(1033, 105)
				elseif ScrW() == 1440 then	
					nut.gui.inv1:SetPos(930, 105)	
				elseif ScrW() == 1280 and ScrH() == 720 then
					nut.gui.inv1:SetPos(827, 80)
				else 
					nut.gui.inv1:SetPos(827, 125)
				end	

				local inventory2 = LocalPlayer():getChar():getInv()

				if (inventory2) then
					nut.gui.inv1:setInventory(inventory2)
				end

				nut.gui.storage = vgui.Create("nutInventory")
				nut.gui.storage:ShowCloseButton(false)
				nut.gui.storage:SetTitle("")
				nut.gui.storage:setInventory(inventory)
				if ScrW() == 1920 then -- Screen fix
					nut.gui.storage:SetPos(220, 190)
				elseif ScrW() == 1600 and ScrH() == 1024 then
					nut.gui.storage:SetPos(187, 180)	
				elseif ScrW() == 1600 and ScrH() == 900 then
					nut.gui.storage:SetPos(187, 145)
				elseif ScrW() == 1440 then	
					nut.gui.storage:SetPos(168, 142)	
				elseif ScrW() == 1280 and ScrH() == 720 then
					nut.gui.storage:SetPos(147, 115)
				else 
					nut.gui.storage:SetPos(147, 180)
				end		

				nut.gui["inv"..index] = nut.gui.storage
			end
		end
	end)
end

nut.command.add("storagelock", {
	adminOnly = true,
	syntax = "[string password]",
	onRun = function(client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid()) then
			local password = table.concat(arguments, " ")

			if (password != "") then
				ent:setNetVar("locked", true)
				ent.password = password
				client:notifyLocalized("storPass", password)
			else
				ent:setNetVar("locked", nil)
				ent.password = nil
				client:notifyLocalized("storPassRmv")
			end
		else
			client:notifyLocalized("invalid", "Entity")
		end
	end
})