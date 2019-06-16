local PANEL = {}
	function PANEL:Init()
		self:MakePopup()
		self:SetPos( 32, 656 )
		self:SetSize( 300, 300 )
		self:SetMultiline(true)

		local img = vgui.Create( "DImage" )	
		img:SetPos( 0, 0 )
		img:SetSize( 1280, 1040 )	
		img:SetImage( "vgui/hud/pda.png" )

		local time = vgui.Create( "DLabel" )
		time:SetText( os.date("Время ".."%I:%M") )	
		time:SetPos( 410, 5 )	
		time:SizeToContents()

		self.exit = vgui.Create( "DImageButton" )
		self.exit:SetSize( 170, 30 )
		self.exit:SetPos( 1102, 0 )						
		self.exit:SetImage( "icon16/cross.png" )		
		self.exit:SizeToContents()							 
		self.exit.DoClick = function()
			self.player:EmitSound("pda/pda_objective.wav")
			self:Remove()
			self.exit:Remove()
			img:Remove()
			time:Remove()
		end
	end


	function PANEL:Setup(client, data, title)
		self.player = client
	end
vgui.Register("nut_Map", PANEL)

netstream.Hook("nut_Map", function(data)
	nut.gui.sprav = vgui.Create("nut_Map")
	nut.gui.sprav:Setup(data[1])
end)