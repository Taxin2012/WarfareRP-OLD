local PANEL = {}

function PANEL:Init()
	self:SetSize(560, 210)	
	self:MakePopup()
	self:Center()
	self:SetTitle("")
	
	self.controls = self:Add("DPanel")
	self.controls:Dock(BOTTOM)
	self.controls:SetTall(30)
	self.controls:DockMargin(0, 5, 0, 0)
	self:ShowCloseButton( false )
	

	self.confirm = self:Add("DButton")
	--self.confirm:Dock(BOTTOM)
	function self.confirm:Paint( w, h )
			local material = Material("ui/but_1.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.confirm:SetDisabled(false)
	self.confirm:SetText(L("Да"))
	self.confirm:SetFont("Nut_NPCChatText")
	self.confirm:SetTextColor(color_white)
	self.confirm:SetSize(120, 17)	
	self.confirm:SetPos(165, 180)	

	self.confirm.DoClick = function(client)
	gui.OpenURL("https://tinyurl.com/y7owc3ra") --со свалки на агропром
	--[[local character = client:getChar()
	if (character) then
		local inventory = client:getInv()
		if (inventory) then		
			if  !client:getChar():getInv():hasItem("svalka_agro") then
					client:getChar():getInv():add("svalka_agro")
				end
			end
		end]]
	end
	
	function self:Paint( w, h )
			local material = Material("ui/ui_actor_sleep_screen.png")  
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
	end
	
	
	self.exit = self:Add("DButton")
	function self.exit:Paint( w, h )
			local material = Material("ui/but_1.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.exit:SetDisabled(false)
	self.exit:SetText(L("Нет"))
	self.exit:SetFont("Nut_NPCChatText")
	self.exit:SetTextColor(color_white)
	self.exit:SetSize(120, 17)	
	self.exit:SetPos(290, 180)	

	self.exit.DoClick = function()
	self:Close()
	end
	
	--[[self.exit:IsDown() = function()
	function self.exit:Paint( w, h )
		local material = Material("ui/but_2.png") 
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end
	end]]
	
	
	function self:Paint( w, h )
			local material = Material("ui/ui_actor_sleep_screen.png")  
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
	end
	
	--[[self.text1 = self.controls:Add("DButton")
	self.text1:SetDisabled(false)
	self.text1:SetText(L("Перейти на следующую локацию?"))
	self.text1:SetFont("Nut_NPCChatText")
	self.text1:SetTextColor(Color(210, 180, 140))
	self.text1:SetSize(187, 27)	
	self.text1:SetPos(290, -11)]]
	
	self.text1 = self:Add("DLabel")
	self.text1.Think = function()
		self.text1:SetText("Перейти на следующую локацию?")
	end
	--self.text1:Dock(LEFT)
	self.text1:SetSize(400, 20)	
	self.text1:SetPos(185, 80)	
	self.text1:SetTextColor(color_white)
	self.text1:SetFont("Nut_NPCChatText")
	

	--[[self.controls.Paint = function(this, w, h)
		draw.SimpleText(Format("Перейти на следующую локацию?", "DermaDefault", 18, h/7, color_white, 1))
	end]]
	
end

vgui.Register("noteRead1", PANEL, "DFrame")
netstream.Hook("receiveNote1", function() --со свалки на агропром
	noteRead1 = vgui.Create("noteRead1")
end)