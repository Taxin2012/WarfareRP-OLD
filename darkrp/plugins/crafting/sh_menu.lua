if SERVER then return end
local PLUGIN = PLUGIN
local paper = Material("icon16/book.png")
local size = 16
local border = 4
local distance = size + border

local PANEL = {}
	function PANEL:Init()
		self:SetPos(ScrW() - 0.375, ScrH() * 0.025)
		self:SetSize(ScrW() * 0.5, ScrH() * 0.5)
		self:MakePopup()
		self:SetTitle(nut.lang.Get("crafting"))
		function self:Paint( w, h )
			local material = Material("ui/ui_hin2t_wnd_no_tab.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end
		local noticePanel = self:Add( "nut_NoticePanel" )
		noticePanel:Dock( TOP )
		noticePanel:DockMargin( 0, 0, 0, 5 )
		noticePanel:SetType( 7 )
		noticePanel:SetText( nut.lang.Get("craft_menu_tip1") )
		noticePanel:SetFont("StalkerSmallFont")
		--noticePanel:SetTextColor(Color(210, 180, 140))
		function noticePanel:Paint( w, h )
			local material = Material("ui/ui_texte1ntry.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end 
		local noticePanel1 = self:Add( "nut_NoticePanel" )
		noticePanel1:Dock( TOP )
		noticePanel1:DockMargin( 0, 0, 0, 5 )
		noticePanel1:SetType( 4 )
		noticePanel1:SetText( nut.lang.Get("craft_menu_tip2") )
		noticePanel1:SetFont("StalkerSmallFont")
		--noticePanel1:SetTextColor(Color(210, 180, 140))
		function noticePanel1:Paint( w, h )
			local material = Material("ui/ui_texte1ntry.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end

		self.list = self:Add("DScrollPanel")
		self.list:Dock(FILL)
		self.list:SetDrawBackground(true)

		self.categories = {}
		self.nextBuy = 0

		hook.Call("CraftingPrePopulateItems", self)

		for class, itemTable in SortedPairs( RECIPES:GetAll() ) do
			if
				-- acquired recipie book || learned the recipe ( planned )
				-- is it blueprint? ( planned )
				( true )
			then
				local category = itemTable.category
				local category2 = string.lower(category)

				if (!self.categories[category2]) then
					local category3 = self.list:Add("DCollapsibleCategory")
					category3:Dock(TOP)
					category3:SetLabel(category)
					category3:DockMargin(5, 5, 5, 5)
					category3:SetPadding(5)
					function category3:Paint( w, h )
						local material = Material("ui/ui_texte1ntry.png") 
						surface.SetDrawColor(color_white) 
						surface.SetMaterial(material) 
						surface.DrawTexturedRect(0, 0, w, h) 
					end

					local list = vgui.Create("DIconLayout")
						list.Paint = function(list, w, h)
							surface.SetDrawColor(0, 0, 0, 25)
							surface.DrawRect(0, 0, w, h)
						end
					category3:SetContents(list)

						local icon = list:Add("SpawnIcon")
						icon:SetModel( itemTable.model or "models/props_lab/box01a.mdl" )		
						icon.PaintOver = function(icon, w, h)
							surface.SetDrawColor(0, 0, 0, 45)
							surface.DrawOutlinedRect(1, 1, w - 1, h - 1)

							if (!itemTable.noBlueprint) then
								surface.SetDrawColor(0, 0, 0, 50)
								surface.DrawRect(w - distance - 1, w - distance - 1, size + 1, size + 1)

								surface.SetDrawColor(255, 255, 255)
								surface.SetMaterial(paper)
								surface.DrawTexturedRect(w - distance, w - distance, size, size)
							end
						end

						local text = nut.lang.Get("crft_text", itemTable.name, itemTable.desc)
						local cnt = 0
						local brk = "\n"
						for itc, qua in pairs( itemTable.items ) do
							cnt = cnt + 1
							if ( cnt == table.Count( itemTable.items ) ) then brk = "" end
							local tblItem = nut.item.Get( itc )
							if tblItem then
								text = text .. tblItem.name .. " x ".. qua .. brk
							end
						end
						icon:SetToolTip(text) -- should be fixed.
						
						icon.DoClick = function(panel)
							if (icon.disabled) then
								return
							end
							net.Start("nut_CraftItem")
								net.WriteString( class )
							net.SendToServer()
							icon.disabled = true
							icon:SetAlpha(70)
							timer.Simple(nut.config.buyDelay, function()
								if (IsValid(icon)) then
									icon.disabled = false
									icon:SetAlpha(255)
								end
							end)
							
						end
					category3:InvalidateLayout(true)
					hook.Call("CraftingCategoryCreated", category3)
					self.categories[category2] = {list = list, category = category3, panel = panel}
					
				else
				
					local list = self.categories[category2].list
					local icon = list:Add("SpawnIcon")
					icon:SetModel( itemTable.model or "models/props_lab/box01a.mdl" )
						
					local text = nut.lang.Get("crft_text", itemTable.name, itemTable.desc)
					local cnt = 0
					local brk = "\n"
					for itc, qua in pairs( itemTable.items ) do
						cnt = cnt + 1
						if ( cnt == table.Count( itemTable.items ) ) then brk = "" end
						local tblItem = nut.item.Get( itc )
						if tblItem then
							text = text .. tblItem.name .. " x ".. qua .. brk
						end
					end
					icon:SetToolTip(text) -- should be fixed.

					icon.PaintOver = function(icon, w, h)--
						--local material = Material("ui/tiptip.png")
						--surface.SetMaterial(material)
						surface.SetDrawColor(0, 0, 0, 45)
						surface.DrawOutlinedRect(1, 1, w - 1, h - 1)
						if (!itemTable.noBlueprint) then
							surface.SetDrawColor(0, 0, 0, 50)
							surface.DrawRect(w - distance - 1, w - distance - 1, size + 1, size + 1)
							--local material = Material("ui/tiptip.png")
							--surface.SetMaterial(material)
							surface.SetDrawColor(255, 255, 255)
							surface.SetMaterial(paper)
							surface.DrawTexturedRect(w - distance, w - distance, size, size)
						end
					end						
					icon.DoClick = function(panel)
						if (icon.disabled) then
							return
						end
						net.Start("nut_CraftItem")
							net.WriteString(class)
						net.SendToServer()
						icon.disabled = true
						icon:SetAlpha(70)
						timer.Simple(1, function()
							if (IsValid(icon)) then
								icon.disabled = false
								icon:SetAlpha(255)
							end
						end)
					end

					hook.Call("CraftingItemCreated", itemTable, icon)			
				end
				
			end
		end

		hook.Call("CraftingPostPopulateItems", self)
	end
	function PANEL:Think()
		if (!self:IsActive()) then
			self:MakePopup()
		end
	end
vgui.Register("nut_Crafting", PANEL, "DFrame")

function PLUGIN:CreateMenuButtons(menu, addButton)
	if self.menuEnabled then
		addButton("crafting", nut.lang.Get("crafting"), function()
			nut.gui.crafting = vgui.Create("nut_Crafting", menu)
			menu:SetCurrentMenu(nut.gui.crafting)
		end)
	end
end
