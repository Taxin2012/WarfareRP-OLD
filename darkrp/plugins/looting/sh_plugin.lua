PLUGIN.name = "Looting"
PLUGIN.author = "orc, thadah, hikka (fix), kek1ch"
PLUGIN.desc = "A plugin for dropping player inventory on death."

PLUGIN.ignored = PLUGIN.ignored or {}
nut.util.include("sh_ignored.lua")

nut.config.add("lootTime", 360, "Number of seconds before loot disappears.", nil, {
	data = {min = 1, max = 86400},
	category = "Looting"
})

if (SERVER) then

	function SCHEMA:DoPlayerDeath( client, attacker, dmg )
		if !IsValid(client) then return end
		if !client:getChar() then return end
		if (!client:getChar():hasMoney(client:getChar():getMoney())) then return end
		if client:getChar():getMoney() < 1 then return end
		nut.currency.spawn(client:GetPos() + Vector( 0, 0, 15 ), client:getChar():getMoney())
		client:getChar():takeMoney(client:getChar():getMoney())
	end

	function PLUGIN:PlayerDeath( ply, dmg, att )
	
		--[[local char = ply:getChar()
		local amount = 30000

		if (char:getMoney() >= amount) then -- Проверяем, имеет ли персонаж больше или равно той суммы, которая должна выпадать
			char:takeMoney(amount) -- Забираем монетки у персонажа
			nut.currency.spawn(ply:getItemDropPos(), amount) -- Воссоздаем мешочек с монетками на месте смерти персонажа
		end]]
		
		local entity = ents.Create("nut_loot")
		entity:SetPos( ply:GetPos() + Vector( 0, 0, 10 ) )
		entity:SetAngles(entity:GetAngles())
		entity:Spawn()
		entity:setNetVar("name", "Belongings" )
		entity:setNetVar("plyName", ply:Name())
		entity:setNetVar( "max", 5000 )
		entity:SetModel("models/misery/sumki/sumka2.mdl")
		entity:SetSolid(SOLID_VPHYSICS)
		entity:PhysicsInit(SOLID_VPHYSICS)

		local physObj = entity:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end

		nut.item.newInv(0, "loot"..ply:getChar():getID(), function(inventory)
			if (IsValid(entity)) then
				inventory:setSize(nut.config.get("invW"), nut.config.get("invH"))
				entity:setInventory(inventory)
			end
		end)

		local items = ply:getChar():getInv():getItems()
		for _, v in pairs(items) do
			if (table.HasValue(self.ignored, v.uniqueID)) then continue end
			--Thanks efex03 for noticing the issue with equipped items
			if (v:getData("equip")) then
				entity:getInv():add(v.uniqueID)
				v:remove()
			else
				v:transfer(entity:getNetVar("id"))
			end
		end

		ply:StripAmmo()

	end

	function PLUGIN:saveLoot()
		local data = {}

		for k, v in ipairs(ents.FindByClass("nut_loot")) do
			if (v:getInv()) then
				data[#data + 1] = {v:GetPos(), v:GetAngles(), v:getNetVar("id"), v:GetModel()}
			end
		end

		self:setData(data)
	end

	function PLUGIN:loadLoot()
		local data = self:getData() or {}

		if (data) then
			for k, v in ipairs(data) do
				local container = ents.Create("nut_loot")
				container:SetPos(v[1])
				container:SetAngles(v[2])
				container:Spawn()
				container:SetModel(v[3])
				container:SetSolid(SOLID_VPHYSICS)
				container:PhysicsInit(SOLID_VPHYSICS)

				local physObject = container:GetPhysicsObject()

				if (physObject) then
					physObject:EnableMotion()
				end
			end
		end
	end

	function PLUGIN:SaveData()
		self:saveLoot()
	end

	function PLUGIN:LoadData()
		self:loadLoot()
	end

	function PLUGIN:LootItemRemoved(entity, inventory)
		self:saveLoot()
	end

	netstream.Hook("lootExit", function(client, index)
		local entity = client.nutBagEntity

		if (IsValid(entity)) then
			entity.receivers[client] = nil
		end
		client.nutBagEntity = nil
	end)

else
	netstream.Hook("lootOpen", function(entity, index)
		local inventory = nut.item.inventories[index]

		if (IsValid(entity) and inventory and inventory.slots) then
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

			lootingPanelMain = vgui.Create("nutInventory")
			lootingPanelMain:ShowCloseButton(false)
			lootingPanelMain:SetTitle("")
			lootingPanelMain:setInventory(inventory)
			if ScrW() == 1920 then -- Screen fix
				lootingPanelMain:SetPos(220, 190)
			elseif ScrW() == 1600 and ScrH() == 1024 then
				lootingPanelMain:SetPos(187, 180)	
			elseif ScrW() == 1600 and ScrH() == 900 then
				lootingPanelMain:SetPos(187, 145)
			elseif ScrW() == 1440 then	
				lootingPanelMain:SetPos(168, 142)	
			elseif ScrW() == 1280 and ScrH() == 720 then
				lootingPanelMain:SetPos(147, 115)
			else 
				lootingPanelMain:SetPos(147, 180)
			end

			nut.gui["inv"..index] = lootingPanelMain
		end
	end)

	netstream.Hook("closeLootMenuSafe", function()
		if (IsValid(nut.gui.inv1) and !IsValid(nut.gui.menu)) then
			nut.gui.inv1:Remove()
		end
		if (IsValid(lootingPanelMain) and !IsValid(nut.gui.menu)) then
			lootingPanelMain:Remove()
		end
	end)
end


