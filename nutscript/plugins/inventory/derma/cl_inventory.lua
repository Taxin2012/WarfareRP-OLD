renderdIcons = renderdIcons or {}

-- To make making inventory variant, This must be followed up.
function renderNewIcon(panel, itemTable)
	-- re-render icons
	if ((itemTable.iconCam and !renderdIcons[string.lower(itemTable.model)]) or itemTable.forceRender) then
		local iconCam = itemTable.iconCam
		iconCam = {
			cam_pos = iconCam.pos,
			cam_ang = iconCam.ang,
			cam_fov = iconCam.fov,
		}
		renderdIcons[string.lower(itemTable.model)] = true
		
		panel.Icon:RebuildSpawnIconEx(
			iconCam
		)
	end
end

local PANEL = {}

function PANEL:Init()
	self:Droppable("inv")
end

function PANEL:PaintOver(w, h)
	local itemTable = nut.item.instances[self.itemID]

	if (self.waiting and self.waiting > CurTime()) then
		local wait = (self.waiting - CurTime()) / self.waitingTime
		surface.SetDrawColor(255, 255, 255, 100*wait)
		surface.DrawRect(2, 2, w - 4, h - 4)
	end

	if (itemTable and itemTable.paintOver) then
		local w, h = self:GetSize()

		itemTable.paintOver(self, itemTable, w, h)
	end
end

function PANEL:ExtraPaint(w, h)
end

function PANEL:Paint(w, h)
	local parent = self:GetParent()

	surface.SetDrawColor(0, 0, 0, 85)
	surface.DrawRect(2, 2, w - 4, h - 4)

	self:ExtraPaint(w, h)
end

function PANEL:wait(time)
	time = math.abs(time) or .2
	self.waiting = CurTime() + time
	self.waitingTime = time
end

function PANEL:isWaiting()
	if (self.waiting and self.waitingTime) then
		return (self.waiting and self.waiting > CurTime())
	end
end

vgui.Register("nutItemIcon", PANEL, "SpawnIcon")

PANEL = {}
	function PANEL:Init()
		self:MakePopup()
		self:Center()
		self:ShowCloseButton(false)
		self:SetDraggable(false)
		self:SetTitle("")

		self.panels = {}
	end
		
	function PANEL:OnRemove()
		if (self.childPanels) then
			for k, v in ipairs(self.childPanels) do
				if (v != self) then
					v:Remove()
				end
			end
		end
		if (IsValid(nut.gui.inv1)) then
			nut.gui.inv1:Remove()
			nut.gui.inv1.backGroundIcon:Remove()
			nut.gui.inv1.backGround:Remove()
			nut.gui.inv1.closeButton:Remove()
			if (IsValid(nut.gui.storage) and !IsValid(nut.gui.menu)) then
				nut.gui.storage:Remove()
				nut.gui.inv1.storageBackGround:Remove()
				nut.gui.inv1.storageBackGroundIcon:Remove()
			elseif (IsValid(safebox_menuINV) and !IsValid(nut.gui.menu)) then
				safebox_menuINV:Remove()
				nut.gui.inv1.storageBackGround:Remove()
				nut.gui.inv1.storageBackGroundIcon:Remove()
			elseif (IsValid(lootingPanelMain) and !IsValid(nut.gui.menu)) then
				lootingPanelMain:Remove()
				nut.gui.inv1.storageBackGround:Remove()
				nut.gui.inv1.storageBackGroundIcon:Remove()
			end
		end	
	end

	function PANEL:viewOnly()
		self.viewOnly = true

		for id, icon in pairs(self.panels) do
			icon.OnMousePressed = nil
			icon.OnMouseReleased = nil
			icon.doRightClick = nil
		end
	end

	function PANEL:setInventory(inventory)
		if (inventory.slots) then
			if (IsValid(nut.gui.inv1) and nut.gui.inv1.childPanels and inventory != LocalPlayer():getChar():getInv()) then
				table.insert(nut.gui.inv1.childPanels, self)
			end

			self.invID = inventory:getID()
			if ScrW() == 1920 then -- Screen fix
				self:SetSize(64, 64)
			elseif ScrW() == 1600 and ScrH() == 1024 then
				self:SetSize(54, 54)
			elseif ScrW() == 1600 and ScrH() == 900 then
				self:SetSize(54, 54)
			elseif ScrW() == 1440 then
				self:SetSize(48, 48)	
			elseif ScrW() == 1280 and ScrH() == 720 then
				self:SetSize(42, 42)
			else
				self:SetSize(42, 42)
			end		
			self:setGridSize(inventory:getSize())

			for x, items in pairs(inventory.slots) do
				for y, data in pairs(items) do
					if (!data.id) then continue end

					local item = nut.item.instances[data.id]

					if (item and !IsValid(self.panels[item.id])) then
						local icon = self:addIcon(item.model or "models/props_junk/popcan01a.mdl", x, y, item.width, item.height)

						if (IsValid(icon)) then
							local newTooltip = hook.Run("OverrideItemTooltip", self, data, item)

							if (newTooltip) then
								icon:SetToolTip(newTooltip)
							else
								icon:SetToolTip(
									Format(nut.config.itemFormat,
									L(item.name), item:getDesc() or "")
								)
							end
							icon.itemID = item.id

							self.panels[item.id] = icon
						end
					end
				end
			end
		end
	end

	function PANEL:setGridSize(w, h)
		self.gridW = w
		self.gridH = h
		
		if ScrW() == 1920 then -- Screen fix
			self:SetSize(w * 64 + 8, h * 64 + 31)
		elseif ScrW() == 1600 and ScrH() == 1024 then
			self:SetSize(w * 54 + 8, h * 54 + 31)	
		elseif ScrW() == 1600 and ScrH() == 900 then
			self:SetSize(w * 54 + 8, h * 54 + 31)
		elseif ScrW() == 1440 then
			self:SetSize(w * 48 + 8, h * 48 + 31)
		elseif ScrW() == 1280 and ScrH() == 720 then
			self:SetSize(w * 42 + 8, h * 42 + 31)
		else
			self:SetSize(w * 42 + 8, h * 42 + 31)	
		end		
		self:buildSlots()
	end
	
	function PANEL:buildSlots()
		self.slots = self.slots or {}
		
		local function PaintSlot(slot, w, h)
			surface.SetDrawColor(35, 35, 35, 85)
			surface.DrawRect(1, 1, w - 2, h - 2)
			
			surface.SetDrawColor(0, 0, 0, 250)
			surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
		end
		
		for k, v in ipairs(self.slots) do
			for k2, v2 in ipairs(v) do
				v2:Remove()
			end
		end
		
		self.slots = {}
		
		for x = 1, self.gridW do
			self.slots[x] = {}
			
			for y = 1, self.gridH do
				local slot = self:Add("DPanel")
				slot:SetZPos(-999)
				slot.gridX = x
				slot.gridY = y
				if ScrW() == 1920 then -- Screen fix
					slot:SetPos((x - 1) * 64 + 4, (y - 1) * 64 + 27)
					slot:SetSize(64, 64)
				elseif ScrW() == 1600 and ScrH() == 1024 then	
					slot:SetPos((x - 1) * 54 + 4, (y - 1) * 54 + 27)
					slot:SetSize(54, 54)	
				elseif ScrW() == 1600 and ScrH() == 900 then	
					slot:SetPos((x - 1) * 54 + 4, (y - 1) * 54 + 27)
					slot:SetSize(54, 54)
				elseif ScrW() == 1440 then	
					slot:SetPos((x - 1) * 48 + 4, (y - 1) * 48 + 27)
					slot:SetSize(48, 48)	
				elseif ScrW() == 1280 and ScrH() == 720 then
					slot:SetPos((x - 1) * 42 + 4, (y - 1) * 42 + 27)
					slot:SetSize(42, 42)
				else
					slot:SetPos((x - 1) * 42 + 4, (y - 1) * 42 + 27)
					slot:SetSize(42, 42)		
				end	
				slot.Paint = PaintSlot
				
				self.slots[x][y] = slot	
			end
		end
	end
	
	local activePanels = {}
	function PANEL:PaintOver(w, h)
		local item = nut.item.held
		
		if (IsValid(item)) then
			local mouseX, mouseY = self:LocalCursorPos()
			if ScrW() == 1920 then -- Screen fix
				invdropX, invdropY = math.ceil((mouseX - 4 - (item.gridW - 1) * 32) / 64), math.ceil((mouseY - 27 - (item.gridH - 1) * 32) / 64)	
			elseif ScrW() == 1600 and ScrH() == 1024 then
				invdropX, invdropY = math.ceil((mouseX - 4 - (item.gridW - 1) * 27) / 54), math.ceil((mouseY - 27 - (item.gridH - 1) * 27) / 54)	
			elseif ScrW() == 1600 and ScrH() == 900 then
				invdropX, invdropY = math.ceil((mouseX - 4 - (item.gridW - 1) * 27) / 54), math.ceil((mouseY - 27 - (item.gridH - 1) * 27) / 54)
			elseif ScrW() == 1440 then
				invdropX, invdropY = math.ceil((mouseX - 4 - (item.gridW - 1) * 24) / 48), math.ceil((mouseY - 27 - (item.gridH - 1) * 24) / 48)	
			elseif ScrW() == 1280 and ScrH() == 720 then
				invdropX, invdropY = math.ceil((mouseX - 4 - (item.gridW - 1) * 21) / 42), math.ceil((mouseY - 27 - (item.gridH - 1) * 21) / 42)	
			else
				invdropX, invdropY = math.ceil((mouseX - 4 - (item.gridW - 1) * 21) / 42), math.ceil((mouseY - 27 - (item.gridH - 1) * 21) / 42)	
			end		

			if ((mouseX < -w*0.05 or mouseX > w*1.05) or (mouseY < h*0.05 or mouseY > h*1.05)) then
				activePanels[self] = nil
			else
				activePanels[self] = true
			end

			item.dropPos = item.dropPos or {}
			if (item.dropPos[self]) then
				item.dropPos[self].item = nil
			end

			for x = 0, item.gridW - 1 do
				for y = 0, item.gridH - 1 do
					local x2, y2 = invdropX + x, invdropY + y
					
					-- Is Drag and Drop icon is in the Frame?
					if (self.slots[x2] and IsValid(self.slots[x2][y2])) then
						local bool = self:isEmpty(x2, y2, item)
						
						surface.SetDrawColor(0, 0, 255, 10)

						if (x == 0 and y == 0) then
							if ScrW() == 1920 then -- Screen fix
								item.dropPos[self] = {x = (x2 - 1)*64 + 4, y = (y2 - 1)*64 + 27, x2 = x2, y2 = y2}
							elseif ScrW() == 1600 and ScrH() == 1024 then
								item.dropPos[self] = {x = (x2 - 1)*54 + 4, y = (y2 - 1)*54 + 27, x2 = x2, y2 = y2}	
							elseif ScrW() == 1600 and ScrH() == 900 then
								item.dropPos[self] = {x = (x2 - 1)*54 + 4, y = (y2 - 1)*54 + 27, x2 = x2, y2 = y2}
							elseif ScrW() == 1440 then
								item.dropPos[self] = {x = (x2 - 1)*48 + 4, y = (y2 - 1)*48 + 27, x2 = x2, y2 = y2}	
							elseif ScrW() == 1280 and ScrH() == 720 then
								item.dropPos[self] = {x = (x2 - 1)*42 + 4, y = (y2 - 1)*42 + 27, x2 = x2, y2 = y2}
							else
								item.dropPos[self] = {x = (x2 - 1)*42 + 4, y = (y2 - 1)*42 + 27, x2 = x2, y2 = y2}	
							end		
						end
							
						if (bool) then
							surface.SetDrawColor(0, 0, 0, 10)
						else
							surface.SetDrawColor(0, 0, 0, 10)
							
							if (self.slots[x2] and self.slots[x2][y2] and item.dropPos[self]) then
								item.dropPos[self].item = self.slots[x2][y2].item
							end
						end
						
						surface.DrawRect((x2 - 1)*64 + 4, (y2 - 1)*64 + 27, 64, 64)
					else
						if (item.dropPos) then
							item.dropPos[self] = nil
						end
					end
				end
			end
		end
	end
	
	function PANEL:isEmpty(x, y, this)
		return (!IsValid(self.slots[x][y].item) or self.slots[x][y].item == this)
	end
	
	function PANEL:onTransfer(oldX, oldY, x, y, oldInventory, noSend)
		local inventory = nut.item.inventories[oldInventory.invID]
		local inventory2 = nut.item.inventories[self.invID]
		local item
		
		if (inventory) then
			item = inventory:getItemAt(oldX, oldY)
			
			if (!item) then
				return false
			end

			if (hook.Run("CanItemBeTransfered", item, nut.item.inventories[oldInventory.invID], nut.item.inventories[self.invID]) == false) then
				return false, "notAllowed"
			end
		
			if (item.onCanBeTransfered and item:onCanBeTransfered(inventory, inventory != inventory2 and inventory2 or nil) == false) then
				return false
			end
		end

		if (!noSend) then
			if (self != oldInventory) then
				netstream.Start("invMv", oldX, oldY, x, y, oldInventory.invID, self.invID)
			else
				netstream.Start("invMv", oldX, oldY, x, y, oldInventory.invID)
			end
		end

		if (inventory) then			
			inventory.slots[oldX][oldY] = nil
		end

		if (item and inventory2) then
			inventory2.slots[x] = inventory2.slots[x] or {}
			inventory2.slots[x][y] = item
		end
	end

	function PANEL:addIcon(model, x, y, w, h)
		w = w or 1
		h = h or 1
		
		if (self.slots[x] and self.slots[x][y]) then
			local panel = self:Add("nutItemIcon")
			if ScrW() == 1920 then -- Screen fix
				panel:SetSize(w * 64, h * 64)
			elseif ScrW() == 1600 and ScrH() == 1024 then
				panel:SetSize(w * 54, h * 54)	
			elseif ScrW() == 1600 and ScrH() == 900 then
				panel:SetSize(w * 54, h * 54)
			elseif ScrW() == 1440 then
				panel:SetSize(w * 48, h * 48)	
			elseif ScrW() == 1280 and ScrH() == 720 then
				panel:SetSize(w * 42, h * 42)	
			else
				panel:SetSize(w * 42, h * 42)	
			end		
			panel:SetZPos(999)
			panel:InvalidateLayout(true)
			panel:SetModel(model)
			panel:SetPos(self.slots[x][y]:GetPos())
			panel.gridX = x
			panel.gridY = y
			panel.gridW = w
			panel.gridH = h

			local inventory = nut.item.inventories[self.invID]

			if (!inventory) then
				return
			end

			panel.inv = inventory

			local itemTable = inventory:getItemAt(panel.gridX, panel.gridY)
			panel.itemTable = itemTable

			if (self.panels[itemTable:getID()]) then
				self.panels[itemTable:getID()]:Remove()
			end
			
			if (itemTable.exRender) then
				panel.Icon:SetVisible(false)
				panel.ExtraPaint = function(self, x, y)
					local exIcon = ikon:getIcon(itemTable.uniqueID)
					if (exIcon) then
						surface.SetMaterial(exIcon)
						surface.SetDrawColor(color_white)
						surface.DrawTexturedRect(0, 0, x, y)
					else
						ikon:renderIcon(
							itemTable.uniqueID,
							itemTable.width,
							itemTable.height,
							itemTable.model,
							itemTable.iconCam
						)
					end
				end
			else
				-- yeah..
				renderNewIcon(panel, itemTable)
			end

			panel.move = function(this, data, inventory, noSend)
				local oldX, oldY = this.gridX, this.gridY
				local oldParent = this:GetParent()

				if (inventory:onTransfer(oldX, oldY, data.x2, data.y2, oldParent, noSend) == false) then
					return
				end

				data.x = data.x or (data.x2 - 1)*64 + 4
				data.y = data.y or (data.y2 - 1)*64 + 27

				this.gridX = data.x2
				this.gridY = data.y2
				this.invID = inventory.invID
				this:SetParent(inventory)
				this:SetPos(data.x, data.y)

				if (this.slots) then
					for k, v in ipairs(this.slots) do
						if (IsValid(v) and v.item == this) then
							v.item = nil
						end
					end
				end
				
				this.slots = {}

				for x = 1, this.gridW do
					for y = 1, this.gridH do
						local slot = inventory.slots[this.gridX + x-1][this.gridY + y-1]

						slot.item = this
						this.slots[#this.slots + 1] = slot
					end
				end
			end

			panel.OnMousePressed = function(this, code)
				if (code == MOUSE_LEFT) then
					if (input.IsKeyDown(KEY_LCONTROL) or input.IsKeyDown(KEY_RCONTROL)) then
						local func = itemTable.functions

						if (func) then
							local use
							local comm
							for k, v in pairs(USABLE_FUNCS or {}) do
								comm = v
								use = func[comm]

								if (use and use.onCanRun) then
									if (use.onCanRun(itemTable) == false) then
										continue
									end
								end

								if (use) then
									break
								end
							end

							if (!use) then return end

							if (use.onCanRun) then
								if (use.onCanRun(itemTable) == false) then
									itemTable.player = nil

									return
								end
							end

							itemTable.player = LocalPlayer()
								local send = true

								if (use.onClick) then
									send = use.onClick(itemTable)
								end

								if (use.sound) then
									surface.PlaySound(use.sound)
								end

								if (send != false) then
									netstream.Start("invAct", comm, itemTable.id, self.invID)
								end
							itemTable.player = nil
						end
					else
						this:DragMousePress(code)
						this:MouseCapture(true)

						nut.item.held = this
					end
				elseif (code == MOUSE_RIGHT and this.doRightClick) then
					this:doRightClick()
				end
			end
			panel.OnMouseReleased = function(this, code, speaker, listener)
				if (code == MOUSE_LEFT and nut.item.held == this) then
					local data = this.dropPos

					this:DragMouseRelease(code)
					this:MouseCapture(false)
					this:SetZPos(99)

					nut.item.held = nil
					
					if (table.Count(activePanels) == 0) then
						local item = this.itemTable
						local inv = this.inv

						if (item and inv) then
							netstream.Start("invAct", "drop", item.id, inv:getID(), item.id)
						end
						
						return false
					end
					activePanels = {}

					if (data) then
						local inventory = table.GetFirstKey(data)
						
						if (IsValid(inventory)) then
							data = data[inventory]

							if (IsValid(data.item)) then
								inventory = panel.inv

								if (inventory) then
									local targetItem = data.item.itemTable
									
									if (targetItem) then
										-- to make sure...
										if (targetItem.id == itemTable.id) then return end

										if (itemTable.functions) then
											local combine = itemTable.functions.combine

											-- does the item has the combine feature?
											if (combine) then
												itemTable.player = LocalPlayer()

												-- canRun == can item combine into?
												if (combine.onCanRun and (combine.onCanRun(itemTable, targetItem.id) != false)) then
													netstream.Start("invAct", "combine", itemTable.id, inventory:getID(), targetItem.id)
												end

												itemTable.player = nil
											else
												/*
													-- Drag and drop bag transfer requires half-recode of Inventory GUI.
													-- It will be there. But it will take some time.

													-- okay, the bag doesn't have any combine function.
													-- then, what's next? yes. moving the item in the bag.

													if (targetItem.isBag) then
														-- get the inventory.
														local bagInv = targetItem.getInv and targetItem:getInv()
														-- Is the bag's inventory exists?
														if (bagInv) then
															print(bagInv, "baggeD")
															local mx, my = bagInv:findEmptySlot(itemTable.width, itemTable.height, true)
															
															-- we found slot for the inventory.
															if (mx and my) then		
																print(bagInv, "move")						
																this:move({x2 = mx, y2 = my}, bagInv)
															end
														end
													end
												*/
											end
										end
									end
								end
							else
								local oldX, oldY = this.gridX, this.gridY

								if (oldX != data.x2 or oldY != data.y2 or inventory != self) then									
									this:move(data, inventory)
								end
							end
						end
					end
				end
			end
			panel.doRightClick = function(this)
				if (itemTable) then
					itemTable.player = LocalPlayer()
						local menu = DermaMenu()
						local override = hook.Run("OnCreateItemInteractionMenu", panel, menu, itemTable)
						
						if (override == true) then if (menu.Remove) then menu:Remove() end return end
							for k, v in SortedPairs(itemTable.functions) do
								if (k == "combine") then continue end -- we don't need combine on the menu mate. 

								if (v.onCanRun) then
									if (v.onCanRun(itemTable) == false) then
										itemTable.player = nil

										continue
									end
								end

								-- is Multi-Option Function
								if (v.isMulti) then
									local subMenu, subMenuOption = menu:AddSubMenu(L(v.name or k), function()
										itemTable.player = LocalPlayer()
											local send = true

											if (v.onClick) then
												send = v.onClick(itemTable)
											end

											if (v.sound) then
												surface.PlaySound(v.sound)
											end

											if (send != false) then
												netstream.Start("invAct", k, itemTable.id, self.invID)
											end
										itemTable.player = nil
									end)
									subMenuOption:SetImage(v.icon or "icon16/brick.png")

									if (v.multiOptions) then
										local options = isfunction(v.multiOptions) and v.multiOptions(itemTable, LocalPlayer()) or v.multiOptions

										for _, sub in pairs(options) do
											subMenu:AddOption(L(sub.name or "subOption"), function()
												itemTable.player = LocalPlayer()
													local send = true

													if (v.onClick) then
														send = v.onClick(itemTable)
													end

													if (v.sound) then
														surface.PlaySound(v.sound)
													end

													if (send != false) then
														netstream.Start("invAct", k, itemTable.id, self.invID, sub.data)
													end
												itemTable.player = nil
											end)
										end
									end
								else
									menu:AddOption(L(v.name or k), function()
										itemTable.player = LocalPlayer()
											local send = true

											if (v.onClick) then
												send = v.onClick(itemTable)
											end

											if (v.sound) then
												surface.PlaySound(v.sound)
											end

											if (send != false) then
												netstream.Start("invAct", k, itemTable.id, self.invID)
											end
										itemTable.player = nil
									end):SetImage(v.icon or "icon16/brick.png")
								end
							end
						menu:Open()
					itemTable.player = nil
				end
			end
			
			panel.slots = {}
			
			for i = 0, w - 1 do
				for i2 = 0, h - 1 do
					local slot = self.slots[x + i] and self.slots[x + i][y + i2]

					if (IsValid(slot)) then
						slot.item = panel
						panel.slots[#panel.slots + 1] = slot
					else
						for k, v in ipairs(panel.slots) do
							v.item = nil
						end

						panel:Remove()

						return
					end
				end
			end
			
			return panel
		end
	end

	local backgroundMaterial = nut.util.getMaterial("stalkerrp/invent1.png")

	function PANEL:Paint(w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(backgroundMaterial)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	matinv = "stalkerrp/invent.png"

	function PANEL:backGround()
		local char = LocalPlayer():getChar()	

		nut.gui.inv1.backGroundIcon = vgui.Create( "DPanel" )
		nut.gui.inv1.backGroundIcon:SetBackgroundColor( Color( 0, 0, 0, 255 ) )

		backGroundIconMat = vgui.Create( "Material", nut.gui.inv1.backGroundIcon )
		backGroundIconMat:SetPos( 0, 0 )
		
		backGroundIconMat:SetMaterial( hook.Run("GetPlayerIcon1") )
		

		backGroundIconMat.AutoSize = false

		nut.gui.inv1.backGround = vgui.Create( "DPanel" )
		nut.gui.inv1.backGround:SetSize( ScrW(), ScrH() )
		nut.gui.inv1.backGround:Center()
		nut.gui.inv1.backGround:SetBackgroundColor( Color( 0, 0, 0, 255 ) )
		
		backGroundMat = vgui.Create( "Material", nut.gui.inv1.backGround )
		backGroundMat:SetPos( 0, 0 )
		backGroundMat:SetSize( ScrW(), ScrH() )
		backGroundMat:SetMaterial( matinv )

		backGroundMat.AutoSize = false

		backGroundName = nut.gui.inv1.backGround:Add("DLabel")
		backGroundName:SetTall(60)
		backGroundName:Dock(TOP)
		backGroundName:SetTextColor(Color(210, 180, 140))
		backGroundName:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		backGroundName:SetText(LocalPlayer():Name())
		backGroundName.Think = function(this)
			this:SetText(LocalPlayer():Name())
		end

		backGroundFaction = nut.gui.inv1.backGround:Add("DLabel")
		backGroundFaction:Dock(TOP)
		backGroundFaction:SetTextColor(Color(169, 169, 169))
		backGroundFaction:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		backGroundFaction:SetText(L(team.GetName(LocalPlayer():Team())))

		backGroundMoney = nut.gui.inv1.backGround:Add("DLabel")
		backGroundMoney:Dock(TOP)
		backGroundMoney:SetTextColor(color_white)
		backGroundMoney:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		backGroundMoney:SetText(nut.currency.get(char:getMoney()))

		if ScrW() == 1920 then -- Screen fix
		
			backGroundName:SetFont("nutMediumInfoFont")
			backGroundFaction:SetFont("DescCharFont1")
			backGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.backGroundIcon:SetPos( 1527, 12 )
			nut.gui.inv1.backGroundIcon:SetSize( 185, 130 )	
			backGroundIconMat:SetSize( 180, 130 )
			backGroundName:DockMargin(1250, 0, 0, 0)
			backGroundFaction:DockMargin(1250, -15, 0, 0)
			backGroundMoney:DockMargin(1250, 42, 0, 0)
		elseif ScrW() == 1600 and ScrH() == 1024 then
			backGroundName:SetFont("nutMediumInfoFont")
			backGroundFaction:SetFont("DescCharFont1")
			backGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.backGroundIcon:SetPos( 1273, 10 )
			nut.gui.inv1.backGroundIcon:SetSize( 152, 122 )	
			backGroundIconMat:SetSize( 152, 122 )
			backGroundName:DockMargin(1035, 0, 0, 0)
			backGroundFaction:DockMargin(1035, -15, 0, 0)
			backGroundMoney:DockMargin(1035, 35, 0, 0)	
		elseif ScrW() == 1600 and ScrH() == 900 then
			backGroundName:SetFont("nutMediumInfoFont")
			backGroundFaction:SetFont("DescCharFont1")
			backGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.backGroundIcon:SetPos( 1273, 10 )
			nut.gui.inv1.backGroundIcon:SetSize( 152, 105 )	
			backGroundIconMat:SetSize( 152, 105 )
			backGroundName:DockMargin(1035, 0, 0, 0)
			backGroundFaction:DockMargin(1035, -15, 0, 0)
			backGroundMoney:DockMargin(1035, 25, 0, 0)
		elseif ScrW() == 1440 then
			backGroundName:SetFont("nutMediumInfoFont")
			backGroundFaction:SetFont("DescCharFont1")
			backGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.backGroundIcon:SetPos( 1145, 10 )
			nut.gui.inv1.backGroundIcon:SetSize( 140, 110 )	
			backGroundIconMat:SetSize( 140, 110 )
			backGroundName:DockMargin(930, -10, 0, 0)
			backGroundFaction:DockMargin(930, -15, 0, 0)
			backGroundMoney:DockMargin(930, 33, 0, 0)	
		elseif ScrW() == 1280 and ScrH() == 720 then
			backGroundName:SetFont("nutMediumFont")
			backGroundFaction:SetFont("DescCharFont1")
			backGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.backGroundIcon:SetPos( 1020, 10 )
			nut.gui.inv1.backGroundIcon:SetSize( 122, 84 )	
			backGroundIconMat:SetSize( 122, 84 )
			backGroundName:DockMargin(825, -10, 0, 0)
			backGroundFaction:DockMargin(825, -15, 0, 0)
			backGroundMoney:DockMargin(825, 15, 0, 0)		
		else
			backGroundName:SetFont("nutMediumFont")
			backGroundFaction:SetFont("DescCharFont1")
			backGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.backGroundIcon:SetPos( 1015, 10 )
			nut.gui.inv1.backGroundIcon:SetSize( 125, 125 )	
			backGroundIconMat:SetSize( 125, 125 )
			backGroundName:DockMargin(825, -10, 0, 0)
			backGroundFaction:DockMargin(825, -15, 0, 0)
			backGroundMoney:DockMargin(825, 46, 0, 0)
		end	
	end

	stgmatinv = "stalkerrp/invent2.png"

	function PANEL:storageBackGround()
		nut.gui.inv1.storageBackGroundIcon = vgui.Create( "DPanel" )
		nut.gui.inv1.storageBackGroundIcon:SetBackgroundColor( Color( 0, 0, 0, 255 ) )

		storageBackGroundIconMat = vgui.Create( "Material", nut.gui.inv1.storageBackGroundIcon )
		storageBackGroundIconMat:SetPos( 0, 0 )
		
		--[[if (LocalPlayer():GetModel() == "models/spenser/ssk/new_stalk_01_spen.mdl") then
            material1 = "vgui/hud/face_1.png"  
        elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_stalk_02_spen.mdl") then
            material1 = "stalkerrp/face25.png"
        elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_stalk_03_spen.mdl") then
            material1 = "stalkerrp/face27.png"
        elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_stalk_04_spen.mdl") then
            material1 = "stalkerrp/face28.png"
        elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_test.mdl") then
            material1 = "stalkerrp/face222.png"
        elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_stalk_05_spen.mdl") then
            material1 = "stalkerrp/face29.png"
        elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_band_01_spen.mdl") then
            material1 = "stalkerrp/face2.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_band_02_spen.mdl") then
            material1 = "stalkerrp/face3.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_band_03_spen.mdl") then
            material1 = "stalkerrp/face4.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_band_03a_spen.mdl") then
            material1 = "stalkerrp/face1.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_band_04_spen.mdl") then
            material1 = "stalkerrp/face5.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_band_05_spen.mdl") then
            material1 = "stalkerrp/face28.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_dolg_01_spen.mdl") then
            material1 = "stalkerrp/face8.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_dolg_01a_spen.mdl") then
            material1 = "stalkerrp/face555.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_dolg_02_spen.mdl") then
            material1 = "stalkerrp/face10.png" 
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_dolg_03_spen.mdl") then
            material1 = "stalkerrp/face7.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_dolg_04_spen.mdl") then
            material1 = "stalkerrp/face11.png"  
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_dolg_05_spen.mdl") then
            material1 = "stalkerrp/face27.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_ecolog_spen.mdl") then
            material1 = "stalkerrp/face12.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_free_00_spen.mdl") then
            material1 = "stalkerrp/face15.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_free_01_spen.mdl") then
            material1 = "stalkerrp/face13.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_free_02_spen.mdl") then
            material1 = "stalkerrp/face14.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_free_02a_spen.mdl") then
            material1 = "stalkerrp/face14.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_free_03_spen.mdl") then
            material1 = "stalkerrp/face16.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_free_03a_spen.mdl") then
            material1 = "stalkerrp/face16.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_free_04_spen.mdl") then
            material1 = "stalkerrp/face17.png"
		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_free_05_spen.mdl") then
            material1 = "stalkerrp/face320.png"			
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_free_06_spen.mdl") then
            material1 = "stalkerrp/face27.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_hahlet_spen.mdl") then
            material1 = "stalkerrp/face30.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_merc_01a_spen.mdl") then
            material1 = "stalkerrp/face18.png"	
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_merc_01_spen.mdl") then
            material1 = "stalkerrp/face888.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_merc_02_spen.mdl") then
            material1 = "stalkerrp/face27.png"	
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_merc_03_spen.mdl") then
            material1 = "stalkerrp/face19.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_merc_04_spen.mdl") then
            material1 = "stalkerrp/face330.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_mono_01_spen.mdl") then
            material1 = "stalkerrp/face21.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_mono_01a_spen.mdl") then
            material1 = "stalkerrp/face21.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_mono_02_spen.mdl") then
            material1 = "stalkerrp/face22.png"	
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_mono_03_spen.mdl") then
            material1 = "stalkerrp/face20.png"	
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_mono_04_spen.mdl") then
            material1 = "stalkerrp/face23.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_nebo_03_spen.mdl") then
            material1 = "stalkerrp/face222.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_nebo_01_spen.mdl") then
            material1 = "stalkerrp/face360.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_nebo_02_spen.mdl") then
            material1 = "stalkerrp/face370.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_nebo_04_spen.mdl") then
            material1 = "stalkerrp/face380.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_nebo_05_spen.mdl") then
            material1 = "stalkerrp/face28.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_security_spen.mdl") then
            material1 = "stalkerrp/face24.png"
 		elseif (LocalPlayer():GetModel() == "models/spenser/ssk/new_solder_01_spen.mdl") then
            material1 = "stalkerrp/face340.png"
 		elseif (LocalPlayer():GetModel() == "models/wicked/squad/wick_brodyga_wo_mask.mdl") then
            material1 = "stalkerrp/brodyagaico.png"
		elseif (LocalPlayer():GetModel() == "models/wicked/squad/wick_brodyga.mdl") then
            material1 = "stalkerrp/brodyagaico.png"
 		elseif (LocalPlayer():GetModel() == "models/wicked/squad/wick_sunrice_01.mdl") then
            material1 = "stalkerrp/wickico.png"		    
        else
        	material1 = "stalkerrp/face310.png"    		
        end
		
		storageBackGroundIconMat:SetMaterial( material1 )]] 
		storageBackGroundIconMat:SetMaterial( "stalkerrp/face310.png" ) 
		

		storageBackGroundIconMat.AutoSize = false

		nut.gui.inv1.storageBackGround = vgui.Create( "DPanel" )
		nut.gui.inv1.storageBackGround:SetSize( ScrW(), ScrH() )
		nut.gui.inv1.storageBackGround:Center()
		nut.gui.inv1.storageBackGround:SetBackgroundColor( Color( 0, 0, 0, 255 ) )
		
		storageBackGroundMat = vgui.Create( "Material", nut.gui.inv1.storageBackGround )
		storageBackGroundMat:SetPos( 0, 0 )
		storageBackGroundMat:SetSize( ScrW(), ScrH() )
		storageBackGroundMat:SetMaterial( stgmatinv )

		storageBackGroundMat.AutoSize = false

		storageBackGroundName = nut.gui.inv1.storageBackGround:Add("DLabel")
		storageBackGroundName:SetTall(60)
		storageBackGroundName:Dock(TOP)
		storageBackGroundName:SetTextColor(color_white)
		storageBackGroundName:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		storageBackGroundName:SetText( "Хранилище" )

		storageBackGroundMoney = nut.gui.inv1.storageBackGround:Add("DLabel")
		storageBackGroundMoney:Dock(TOP)
		storageBackGroundMoney:SetTextColor(color_white)
		storageBackGroundMoney:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		storageBackGroundMoney:SetText("- - - rubles")

		if ScrW() == 1920 then -- Screen fix
			storageBackGroundName:SetFont("nutMediumInfoFont")
			storageBackGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.storageBackGroundIcon:SetPos( 502, 12 )
			nut.gui.inv1.storageBackGroundIcon:SetSize( 185, 130 )	
			storageBackGroundIconMat:SetSize( 185, 130 )
			storageBackGroundName:DockMargin(220, 0, 0, 0)
			storageBackGroundMoney:DockMargin(220, 47, 0, 0)
		elseif ScrW() == 1600 and ScrH() == 1024 then		
			storageBackGroundName:SetFont("nutMediumInfoFont")
			storageBackGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.storageBackGroundIcon:SetPos( 421, 10 )
			nut.gui.inv1.storageBackGroundIcon:SetSize( 152, 122 )
			storageBackGroundIconMat:SetSize( 152, 122 )
			storageBackGroundName:DockMargin(183, 0, 0, 0)
			storageBackGroundMoney:DockMargin(183, 40, 0, 0)
		elseif ScrW() == 1600 and ScrH() == 900 then
			storageBackGroundName:SetFont("nutMediumInfoFont")
			storageBackGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.storageBackGroundIcon:SetPos( 421, 10 )
			nut.gui.inv1.storageBackGroundIcon:SetSize( 152, 105 )
			storageBackGroundIconMat:SetSize( 152, 105 )
			storageBackGroundName:DockMargin(183, 0, 0, 0)
			storageBackGroundMoney:DockMargin(183, 30, 0, 0)
		elseif ScrW() == 1440 then
			storageBackGroundName:SetFont("nutMediumInfoFont")
			storageBackGroundMoney:SetFont("BigFontForWS")	
			nut.gui.inv1.storageBackGroundIcon:SetPos( 380, 10 )
			nut.gui.inv1.storageBackGroundIcon:SetSize( 140, 110 )
			storageBackGroundIconMat:SetSize( 140, 110 )
			storageBackGroundName:DockMargin(175, 0, 0, 0)
			storageBackGroundMoney:DockMargin(175, 30, 0, 0)	
		elseif ScrW() == 1280 and ScrH() == 720 then
			storageBackGroundName:SetFont("nutMediumFont")
			storageBackGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.storageBackGroundIcon:SetPos( 336, 10 )
			nut.gui.inv1.storageBackGroundIcon:SetSize( 122, 84 )
			storageBackGroundIconMat:SetSize( 122, 84 )
			storageBackGroundName:DockMargin(147, -10, 0, 0)
			storageBackGroundMoney:DockMargin(147, 20, 0, 0)
		else
			storageBackGroundName:SetFont("nutMediumFont")
			storageBackGroundMoney:SetFont("BigFontForWS")
			nut.gui.inv1.storageBackGroundIcon:SetPos( 336, 10 )
			nut.gui.inv1.storageBackGroundIcon:SetSize( 125, 125 )
			storageBackGroundIconMat:SetSize( 125, 125 )
			storageBackGroundName:DockMargin(147, -10, 0, 0)
			storageBackGroundMoney:DockMargin(147, 54, 0, 0)		
		end	
	end

	local matbut = "stalkerrp/closebut.png"

	function PANEL:closeButton()
		nut.gui.inv1.closeButton = vgui.Create( "DButton" )
		nut.gui.inv1.closeButton:SetText( "Закрыть" )
		nut.gui.inv1.closeButton:SetTextColor( Color( 255, 255, 255 ) )

		local closeButtonMat = vgui.Create( "Material", nut.gui.inv1.closeButton )
		closeButtonMat:SetPos( 0, 0 )
		closeButtonMat:SetMaterial( matbut )

		closeButtonMat.AutoSize = false
		
		nut.gui.inv1.closeButton.DoClick = function()
			PANEL:OnRemove()
		end

		if ScrW() == 1920 then -- Screen fix
			nut.gui.inv1.closeButton:SetPos( 717, 1030 )
			nut.gui.inv1.closeButton:SetSize( 480, 36 )
			closeButtonMat:SetSize( 480, 36 )
		elseif ScrW() == 1600 and ScrH() == 1024 then	
			nut.gui.inv1.closeButton:SetPos( 600, 980 )
			nut.gui.inv1.closeButton:SetSize( 400, 30 )
			closeButtonMat:SetSize( 400, 30 )	
		elseif ScrW() == 1600 and ScrH() == 900 then	
			nut.gui.inv1.closeButton:SetPos( 600, 860 )
			nut.gui.inv1.closeButton:SetSize( 400, 30 )
			closeButtonMat:SetSize( 400, 30 )
		elseif ScrW() == 1440 then	
			nut.gui.inv1.closeButton:SetPos( 550, 860 )
			nut.gui.inv1.closeButton:SetSize( 350, 30 )
			closeButtonMat:SetSize( 350, 30 )	
		elseif ScrW() == 1280 and ScrH() == 720 then 
			nut.gui.inv1.closeButton:SetPos( 480, 685 )
			nut.gui.inv1.closeButton:SetSize( 320, 27 )	
			closeButtonMat:SetSize( 320, 27 )
		elseif ScrW() == 1280 and ScrH() == 1024 then
			nut.gui.inv1.closeButton:SetPos( 480, 980 )
			nut.gui.inv1.closeButton:SetSize( 320, 27 )	
			closeButtonMat:SetSize( 320, 27 )
		else
			nut.gui.inv1.closeButton:SetSize( 320, 27 )	
			closeButtonMat:SetSize( 320, 27 )	
		end	
	end

vgui.Register("nutInventory", PANEL, "DFrame")

hook.Add("ViewInventory", "nutInventoryView", function()
	if (hook.Run("CanPlayerViewInventory") != false) then
		nut.gui.inv1 = vgui.Create("nutInventory")
		nut.gui.inv1.childPanels = {}
		local inventory = LocalPlayer():getChar():getInv()
		local inventory1 = LocalPlayer():getChar():getInv()

		if (inventory) then
			nut.gui.inv1:setInventory(inventory)
			nut.gui.inv1:backGround()
			nut.gui.inv1:closeButton()
		end	

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
	end
end)

function PLUGIN:PlayerBindPress(client, bind, pressed)
	if IsKeyPressed(KEY_I) then 
		if !IsValid(nut.gui.inv1) then
			hook.Run("ViewInventory")

			return true 
		--else		
			--nut.chat.send(client, "say", "Если инвентарь не включается, напишите 'unbind i' в вашу консоль.", false, client)
		end
	end	
end

function PLUGIN:createWepInv()
	inventorydata = {
	name = LocalPlayer():Name(),
	width = 2,
	height = 3
	}

	local client = LocalPlayer()
	local index = client:getNetVar("id")
	local inventory = nut.item.inventories[index]

	if inventorydata then
		nut.item.registerInv("wepinv1"..inventorydata.name, inventorydata.width, inventorydata.height)
	end

	nut.item.newInv(0, "wepinv1"..inventorydata.name, function(inventory)
		if (IsValid(client)) then
			client:setInventory(inventory)
		end
	end)

	nut.item.restoreInv(inventorydata.name, inventorydata.width, inventorydata.height, function(inventory)
		if (IsValid(client)) then
			client:setInventory(inventory)
		end
	end)
end

surface.CreateFont("nutMediumInfoFont", {
	font = font,
	size = 27,
	extended = true,
	weight = 1000
})

surface.CreateFont("nutMediumInfoSmallFont", {
		font = font,
		size = 20,
		extended = true,
		weight = 1000
	})

hook.Add("PostRenderVGUI", "nutInvHelper", function()
	local pnl = nut.gui.inv1

	hook.Run("PostDrawInventory", pnl)
end)
