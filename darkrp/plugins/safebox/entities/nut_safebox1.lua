AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Safebox"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/spenser/ssk/props/decor_janov_40.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end
	
	function ENT:CreateInv(activator)
		local character = activator:getChar()
		nut.item.newInv(character:getID(), "safe."..character:getID(), function(inventory)
			character:setData("safebox", inventory:getID())
		end)
	end
	
	function ENT:getInv(activator)
		local index = activator:getChar():getData("safebox")

		if (index) then
			return nut.item.inventories[index]
		end
	end

	function ENT:RestoreInv(activator)
		local character = activator:getChar()
		local index = character:getData("safebox")
		local inventory = nut.item.inventories[index]
		
		if (index) then
			if (inventory) then
				inventory:sync(activator)
			else
				nut.item.restoreInv(index, PLUGIN.config.width, PLUGIN.config.height, function(inventory)
					inventory:setOwner(character, true)
				end)
			end
		else
			nut.item.newInv(character:getID(), "safe."..character:getID(), function(inventory)
				character:setData("safebox", inventory:getID())
			end)
		end
	end
	
	local OPEN_TIME = .3
	function ENT:OpenInv(activator)
		local index = activator:getChar():getData("safebox")
		local character = activator:getChar()
		
		/*if (index) then
			activator:setAction("@opening", .5, function()
				if (activator:GetPos():Distance(self:GetPos()) < 101) then
					netstream.Start(activator, "safeOpen", index, self.money)
				end
			end)
		else
			self:RestoreInv(activator)
		end*/
		if index then
			activator:setAction("@opening", OPEN_TIME)
			activator:doStaredAction(self, function()
				if (activator:GetPos():Distance(self:GetPos()) < 101) then
					print("old")
					--nut.item.inventories[index]:sync(activator)
					nut.item.restoreInv(index, nut.config.get("BankInvW"), nut.config.get("BankInvH"), function(inventory) -- width = 10; height = 10
						inventory:setOwner(character, true)
						self:setNetVar("bank", inventory:getID())
					end)
					nut.item.inventories[index]:sync(activator)
					netstream.Start(activator, "safeOpen", self, index)
					self:EmitSound("items/ammocrate_open.wav")
				end
			end, OPEN_TIME, function()
				if (IsValid(activator)) then
					activator:setAction()
				end
			end)
			return
		else
			local index = character:getData("safebox")
			local inventory = nut.item.inventories[index]
			nut.item.newInv(character:getID(), "safe."..character:getID(), function(inventory)
				character:setData("safebox", inventory:getID())
				print("new")
			end)
		end
	end
	
	function ENT:Use(activator)
		self:OpenInv(activator)		
	end
	
	netstream.Hook("TakeMoney", function(client, value)
		client:getChar():takeMoney(value)
	end)
	
	netstream.Hook("GiveMoney", function(client, value)
		client:getChar():giveMoney(value)
	end)
	
	netstream.Hook("BankTakeMoney", function(client, value)
		client:getChar():takeReserve(value)
	end)
	
	netstream.Hook("BankGiveMoney", function(client, value)
		client:getChar():addReserve(value)
	end)
else
	netstream.Hook("safeOpen", function(entity, index)
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

		safebox_menuINV = vgui.Create("nutInventory")
		safebox_menuINV:ShowCloseButton(false)
		safebox_menuINV:SetTitle("")
		safebox_menuINV:setInventory(nut.item.inventories[index])
		if ScrW() == 1920 then -- Screen fix
			safebox_menuINV:SetPos(220, 190)
		elseif ScrW() == 1600 and ScrH() == 1024 then
			safebox_menuINV:SetPos(187, 180)	
		elseif ScrW() == 1600 and ScrH() == 900 then
			safebox_menuINV:SetPos(187, 145)
		elseif ScrW() == 1440 then	
			safebox_menuINV:SetPos(168, 142)	
		elseif ScrW() == 1280 and ScrH() == 720 then
			safebox_menuINV:SetPos(147, 115)
		else 
			safebox_menuINV:SetPos(147, 180)
		end	

		nut.gui["inv"..index] = safebox_menuINV
		nut.gui.inv1:SetSize(nut.gui.inv1:GetWide(), nut.gui.inv1:GetTall() + 48)
		local text = nut.gui.inv1:Add("DLabel")
		text.Think = function()
			text:SetText(nut.currency.get(LocalPlayer():getChar():getMoney()))
		end
		text:Dock(BOTTOM)
		text:DockMargin(0, 0, nut.gui.inv1:GetWide()/2, 0)
		text:SetTextColor(color_white)
		text:SetFont("nutGenericFont")
		
		local entry = nut.gui.inv1:Add("DTextEntry")
		entry:Dock(BOTTOM)
		entry:DockMargin(nut.gui.inv1:GetWide()/2, 0, 0, 0)
		entry:SetValue(0)
		entry:SetNumeric(true)
		entry.OnEnter = function()
			local value = tonumber(entry:GetValue()) or 0
			if value and value > 0 then
				if LocalPlayer():getChar():hasMoney(value) then
					surface.PlaySound("hgn/crussaria/items/itm_gold_down.wav")
					netstream.Start("TakeMoney", value)
					netstream.Start("BankGiveMoney", value)
					--nut.command.send("actstand", 4)
					entry:SetValue(0)
				else
					nut.util.notify(L("provideValidNumber"))
					entry:SetValue(0)
				end
			else
				nut.util.notify(L("cantAfford"))
				entry:SetValue(0)
			end		
		end
		
		local transfer = nut.gui.inv1:Add("DButton")
		transfer:Dock(BOTTOM)
		transfer:DockMargin(nut.gui.inv1:GetWide()/2, 40, 0, -40)
		transfer:SetText("Положить")
		transfer.DoClick = function()
			local value = tonumber(entry:GetValue()) or 0
			if value and value > 0 then
				if LocalPlayer():getChar():hasMoney(value) then
					surface.PlaySound("hgn/crussaria/items/itm_gold_down.wav")
					netstream.Start("TakeMoney", value)
					netstream.Start("BankGiveMoney", value)
					--nut.command.send("actstand", 4)
					entry:SetValue(0)
				else
					nut.util.notify(L("provideValidNumber"))
					entry:SetValue(0)
				end
			else
				nut.util.notify(L("cantAfford"))
				entry:SetValue(0)
			end					
		end
		
		safebox_menuINV:SetSize(safebox_menuINV:GetWide(), safebox_menuINV:GetTall() + 48)
		
		local text1 = safebox_menuINV:Add("DLabel")
		text1.Think = function()
			text1:SetText(nut.currency.get(LocalPlayer():getChar():getReserve()))
		end			
		text1:Dock(BOTTOM)
		text1:DockMargin(0, 0, safebox_menuINV:GetWide()/2, 0)
		text1:SetTextColor(color_white)
		text1:SetFont("nutGenericFont")
		
		local entry1 = safebox_menuINV:Add("DTextEntry")
		entry1:Dock(BOTTOM)
		entry1:SetValue(LocalPlayer():getChar():getReserve() or 0)
		entry1:SetNumeric(true)
		entry1:DockMargin(safebox_menuINV:GetWide()/2, 0, 0, 0)
		entry1.OnEnter = function()
			local value = tonumber(entry1:GetValue()) or 0
			if LocalPlayer():getChar():getReserve() >= value and value > 0 then
				surface.PlaySound("hgn/crussaria/items/itm_gold_up.wav")
				netstream.Start("BankTakeMoney", value)
				netstream.Start("GiveMoney", value)
				entry1:SetValue(0)
			elseif value < 1 then
				nut.util.notify(L("provideValidNumber"))
				entry1:SetValue(0)
			else
				nut.util.notify(L("cantAfford"))
				entry1:SetValue(0)
			end			
		end
		
		local transfer1 = safebox_menuINV:Add("DButton")
		transfer1:Dock(BOTTOM)
		transfer1:DockMargin(safebox_menuINV:GetWide()/2, 40, 0, -40)
		transfer1:SetText("Снять")
		transfer1.DoClick = function()
			local value = tonumber(entry1:GetValue()) or 0
			if LocalPlayer():getChar():getReserve() >= value and value > 0 then
				surface.PlaySound("hgn/crussaria/items/itm_gold_up.wav")
				netstream.Start("BankTakeMoney", value)
				netstream.Start("GiveMoney", value)
				entry1:SetValue(0)
			elseif value < 1 then
				nut.util.notify(L("provideValidNumber"))
				entry1:SetValue(0)
			else
				nut.util.notify(L("cantAfford"))
				entry1:SetValue(0)
			end								
		end

	end)

	ENT.DrawEntityInfo = true
	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y
		local tx, ty = drawText("Сейф", x, y, colorAlpha(Color(210, 180, 140)), 1, 1, "nutMediumInfoFont", alpha * 2) --BigFontForWS
	end
end