local PLUGIN = PLUGIN
surface.CreateFont( "Nut_NPCChatName",
{
	font = "Trebuchet MS",
	size = ScreenScale( 9 ),
	weight = 1000,
})
surface.CreateFont( "Nut_NPCChatName1",
{
	font = "Trebuchet24",
	size = ScreenScale( 9 ),
	weight = 1000,
})
surface.CreateFont( "Nut_NPCChatName111",
{
	font = "Trebuchet24",
	size = ScreenScale( 3 ),
	weight = 1000,
})
surface.CreateFont( "Nut_NPCChatName11",
{
	font = "ChatFont",
	size = ScreenScale( 9 ),
	weight = 1000,
})
surface.CreateFont( "Nut_NPCChatSel",
{
	font = "Myriad Pro",
	size = ScreenScale( 8 ),
	weight = 1000,
})
surface.CreateFont( "Nut_NPCChatText",
{
	font = "Myriad Pro",
	size = ScreenScale( 8 ),
	weight = 500,
})
local color_red = Color(255,0,0)
local color_white = Color(255,255,255)
local color_black = Color(0,0,0)
local color_yellow = Color(255, 140, 0)

local PLUGIN = PLUGIN
/*---------------------------------------------------------
						DIALOGUE PANEL
						SORRY FOR NASTY LOOKING CODE
						I WAS LAZY
						- rebel1324
---------------------------------------------------------*/
local material = Material("ui/33332222.png");
if CLIENT then
	local PANEL = {}
	function PANEL:Init()
		local sh = ScrH()/1.5
		self:SetTitle( " " )
		self:SetSize( 700, 700 )--sh*.8, sh )
		self.content = vgui.Create( "Panel", self )
		self.content:Dock( FILL )
		self.btnlist = {}
		self:MakePopup()
		self:ShowCloseButton( false )
		self:Center()
		self.text = self.content:Add( "DPanel" )
		self.text:SetPos( 20, 0 )
		self.text:SetSize( 650, 440 )--self.content:GetWide(), self.content:GetTall()*.8 - 5 )
		self.dialouge = vgui.Create( "DScrollPanel", self.text )
		self.dialouge:DockMargin(10, 10, 10, 10)
		self.dialouge:Dock( FILL )
		self.dialouge.Paint = function() end
		self.select = self.content:Add( "DPanel" )
		self.select:SetPos( 25, 450 ) --self.content:GetTall()*.8 )
		self.select:SetSize( 640, 185 )--self.content:GetWide(), self.content:GetTall()*.2 )
		self.sdialouge = vgui.Create( "DScrollPanel", self.select )
		self.sdialouge:DockMargin(3, 3, 3, 3)
		self.sdialouge:Dock( FILL )
		self.sdialouge.Paint = function() end
		
		self.openvendor = self:Add("DButton")  --кнопка покупка слева
		self.openvendor:SetFont("ChatFontMisery")
		self.openvendor:SetSize(280, 25)
		self.openvendor:SetPos(220, 672)
		function self.openvendor:Paint( w, h )
			local material = Material("ui/trade_but.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end
		self.openvendor:SetContentAlignment(5)
		-- The text says purchase but the vendor is selling it to us.
		self.openvendor:SetText(L"Выход")
		self.openvendor:SetTextColor(color_white)
		self.openvendor.DoClick = function(this)
				self:Close()
		end
	end

	function PANEL:Paint(w, h)
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h)
	end

	function PANEL:SetEntity( ent )
		self.name = ent:getNetVar( "name", "John Doe" )
		self.dialogue = ent:getNetVar( "dialogue", PLUGIN.defaultDialogue )
		self:AddChat( self.name, self.dialogue.npc._start )
		self:AddSelection( self.dialogue.player )
	end
	function PANEL:AddSelection( tbl )
		for k, v in pairs( tbl ) do
			local btn = self.sdialouge:Add( "DButton" )
			btn:SetFont( "Nut_NPCChatSel" )
			btn:SetTextColor( color_red )
			btn:SetText(v )
			btn:SetContentAlignment( 1 )
			btn.Paint = function(s, w, h) 
	s:SetColor(s:IsHovered() and Color(255, 140, 0) or Color(220, 220, 220))
		end
			btn:DockMargin(0, 0, 0, 0)
			btn:Dock(TOP)
			btn.DoClick = function()
				if k == "_quit" then self:Close() return end
				if self.talking then return end
				local dat = self.dialogue.npc[ k ]
				self:AddChat( LocalPlayer():Name(), v )
				self.talking = true
				if !( string.Left( k, 1 ) == "!" ) then
					timer.Simple( math.Rand( PLUGIN.chatDelay.min, PLUGIN.chatDelay.max ), function()
						if self:IsValid() then
							self.talking = false
							self:AddChat( self.name, self.dialogue.npc[ k ] )
						end
					end)
				else
					-- special dialogue hook.
					netstream.Start("nut_DialogueMessage", { name = self.name, request = k } )
					self.talking = true
				end
			end
		end
	end
	function PANEL:AddName( str )
		local lab = self.dialouge:Add( "DLabel" )
		lab:SetFont( "Nut_NPCChatName" )
		lab:SetTextColor( color_yellow )
		lab:SetText(str )
		lab:SizeToContents()
		lab:DockMargin(3, 3, 3, 0)
		lab:Dock(TOP)
	end
	function PANEL:AddText( str )
		local lab = self.dialouge:Add( "DLabel" )
		lab:SetTextColor( color_white )
		lab:SetFont( "Nut_NPCChatText" )
		lab:SetText( str )
		lab:SetWrap( true )
		lab:DockMargin(10, 0, 3, 5)
		lab:Dock(TOP)
		lab:SetAutoStretchVertical( true )
	end
	function PANEL:AddCustomText( str, font, color )
		local lab = self.dialouge:Add( "DLabel" )
		lab:SetTextColor( color or color_white )
		lab:SetFont( font or "Nut_NPCChatText" )
		lab:SetText( str )
		lab:SetWrap( true )
		lab:DockMargin(10, 0, 3, 5)
		lab:Dock(TOP)
		lab:SetAutoStretchVertical( true )
	end
	function PANEL:AddChat( str1, str2 )
		self:AddName( str1 )
		self:AddText( str2 )
	end

	vgui.Register( "Nut_Dialogue", PANEL, "DFrame" )
end

/*---------------------------------------------------------
	DIALOGUE EDITOR PANEL
	SORRY FOR NASTY LOOKING CODE
	I WAS LAZY
	- rebel1324
---------------------------------------------------------*/
local PANEL = {}
function PANEL:Init()
	self:MakePopup()
	--self:Center()
	local sh = ScrH()/1.5
	self:SetTitle( " " )
	self:SetSize( sh*.8, sh )
	self:SetPos( 0, (ScrH()-sh)/2)
	--print( self:GetPos() )
	self.content = vgui.Create( "DPanel", self )
	self.content:Dock( FILL )
	self.btnlist = {}
	
	self.scroll = self.content:Add( "DScrollPanel" )
	self.scroll:Dock( FILL )
	
end
function PANEL:SetEntity( entity )
		local dialogue = entity:getNetVar( "dialogue", PLUGIN.defaultDialogue )
		local info = self.scroll:Add("DLabel")
		info:SetText("Left Click: Set UID, Right Click: Set Dialogue")
		info:DockMargin(3, 3, 3, 3)
		info:Dock(TOP)
		info:SetTextColor(color_white)
		info:SetFont("nut_ScoreTeamFont")
		info:SizeToContents()
		--- NPC dialogue
		local npcd = self.scroll:Add("DLabel")
		npcd:SetText("NPC Dialogues")
		npcd:DockMargin(3, 3, 3, 3)
		npcd:Dock(TOP)
		npcd:SetTextColor(color_white)
		npcd:SetFont("nut_ScoreTeamFont")
		npcd:SizeToContents()
		self.npcd = self.scroll:Add( "DListView" )
		self.npcd:SetPos( 0, 0 )
		self.npcd:SetSize( self.content:GetWide(), self.content:GetTall() )
		self.npcd:AddColumn("Unique ID")
		self.npcd:AddColumn("Dialogue")
		self.npcd.OnClickLine = function( p, l, s )				
			local menu = DermaMenu()
			menu:AddOption( "Write Unique ID", function()
				if l.uid == "_start" then return end
				Derma_StringRequest( "Write Unique ID", "Write Unique ID what you want to assign", l.uid, function( text )
					l:SetValue(1,  text or l.uid)
					l.uid = text
				end )
			end):SetImage("icon16/textfield_key.png")
			menu:AddOption( "Write Dialogue", function()
				Derma_StringRequest( "Write Dialogue", "Write Dialouge what you want to assign", l.text, function( text )
					l:SetValue(2,  text or l.text)
					l.text = text
				end )
			end):SetImage("icon16/textfield_rename.png")
			menu:AddOption( "Delete Line", function()
				if l.uid == "_start" then return end
				l:Remove()
				self.npcd.l = nil
			end):SetImage("icon16/textfield_delete.png")
			menu:AddOption( "Add New Line", function()	
				local line = self.npcd:AddLine( "uniqueid", "Sample Dialogue.")
			end):SetImage("icon16/textfield_add.png")
			menu:Open()
		end
		self.npcd:Dock( TOP )
		self.npcd:SetTall( 150 )
		--- Player dialogue
		local playerd = self.scroll:Add("DLabel")
		playerd:SetText("Player Dialogues")
		playerd:DockMargin(3, 3, 3, 3)
		playerd:Dock(TOP)
		playerd:SetTextColor(color_white)
		playerd:SetFont("nut_ScoreTeamFont")
		playerd:SizeToContents()
		self.plyd = self.scroll:Add( "DListView" )
		self.plyd:SetPos( 0, 0 )
		self.plyd:SetSize( self.content:GetWide(), self.content:GetTall() )
		self.plyd:AddColumn("Unique ID")
		self.plyd:AddColumn("Dialogue")
		self.plyd.OnClickLine = function( p, l, s )
			local menu = DermaMenu()
			menu:AddOption( "Write Unique ID", function()
				if l.uid == "_quit" then return end
				Derma_StringRequest( "Write Unique ID", "Write Unique ID what you want to assign", l.uid, function( text )
					l:SetValue(1,  text or l.uid)
					l.uid = text
				end )
			end):SetImage("icon16/textfield_key.png")
			menu:AddOption( "Write Dialogue", function()
				Derma_StringRequest( "Write Dialogue", "Write Dialouge what you want to assign", l.text, function( text )
					l:SetValue(2,  text or l.text)
					l.text = text
				end )
			end):SetImage("icon16/textfield_rename.png")
			menu:AddOption( "Delete Line", function()
				if l.uid == "_quit" then return end
				l:Remove()
				self.plyd.l = nil
			end):SetImage("icon16/textfield_delete.png")
			menu:AddOption( "Add New Line", function()	
				local line = self.plyd:AddLine( "uniqueid", "Sample Dialogue.")
			end):SetImage("icon16/textfield_add.png")
			menu:Open()
		end
		self.plyd:Dock( TOP )
		self.plyd:SetTall( 150 )
		for k, v in pairs( dialogue.npc ) do
			local line = self.npcd:AddLine( k, v )
			line.text = v
			line.uid = k 
		end
		for k, v in pairs( dialogue.player ) do
			local line = self.plyd:AddLine( k, v )
			line.text = v
			line.uid = k
		end
	---------------------
		self.factions = {}
		local faction = self.scroll:Add("DLabel")
		faction:SetText("Factions")
		faction:DockMargin(3, 3, 3, 3)
		faction:Dock(TOP)
		faction:SetTextColor(color_white)
		faction:SetFont("nut_ScoreTeamFont")
		faction:SizeToContents()
		local factionData = entity:getNetVar("factiondata", {})
		for k, v in SortedPairs(nut.faction.teams) do
			local panel = self.scroll:Add("DCheckBoxLabel")
			panel:Dock(TOP)
			panel:SetText("Talk to "..v.name..".")
			panel:SetValue(0)
			panel:DockMargin(12, 3, 3, 3)
			panel:SetDark(true)
			if (factionData[k]) then
				panel:SetChecked(factionData[k])
			end
			self.factions[k] = panel
		end
		local classes = self.scroll:Add("DLabel")
		classes:SetText("Classes")
		classes:DockMargin(3, 3, 3, 3)
		classes:Dock(TOP)
		classes:SetTextColor(color_white)
		classes:SetFont("nut_ScoreTeamFont")
		classes:SizeToContents()
		self.classes = {}
		local classData = entity:getNetVar("classdata", {})
		for k, v in SortedPairs(nut.class.list) do
			local panel = self.scroll:Add("DCheckBoxLabel")
			panel:Dock(TOP)
			panel:SetText("Sell to "..v.name..".")
			panel:SetValue(0)
			panel:DockMargin(12, 3, 3, 3)
			panel:SetDark(true)
			if (classData[k]) then
				panel:SetChecked(classData[k])
			end
			self.classes[k] = panel
		end
		local name = self.scroll:Add("DLabel")
		name:SetText("Name")
		name:DockMargin(3, 3, 3, 3)
		name:Dock(TOP)
		name:SetTextColor(color_white)
		name:SetFont("nut_ScoreTeamFont")
		name:SizeToContents()
		self.name = self.scroll:Add("DTextEntry")
		self.name:Dock(TOP)
		self.name:DockMargin(3, 3, 3, 3)
		self.name:SetText(entity:getNetVar("name", "John Doe"))
		self.name:SetTextColor(entity:getNetVar("name", Color(55,55,55)))
		-- Description
		local desc = self.scroll:Add("DLabel")
		desc:SetText("Description")
		desc:DockMargin(3, 3, 3, 3)
		desc:Dock(TOP)
		desc:SetTextColor(color_white)
		desc:SetFont("nut_ScoreTeamFont")
		desc:SizeToContents()
		self.desc = self.scroll:Add("DTextEntry")
		self.desc:Dock(TOP)
		self.desc:DockMargin(3, 3, 3, 3)
		self.desc:SetText(entity:getNetVar("desc", L"no_desc"))
		-- Model
		local model = self.scroll:Add("DLabel")
		model:SetText("Model")
		model:DockMargin(3, 3, 3, 3)
		model:Dock(TOP)
		model:SetTextColor(Color(60, 60, 60))
		model:SetFont("nut_ScoreTeamFont")
		model:SizeToContents()
		self.model = self.scroll:Add("DTextEntry")
		self.model:Dock(TOP)
		self.model:DockMargin(3, 3, 3, 3)
		self.model:SetText(entity:GetModel())
		-- Save button.
		self.save = self:Add("DButton")
		self.save:Dock(BOTTOM)
		self.save:DockMargin(0, 5, 0, 0)
		self.save:SetText("Save")
		self.save.DoClick = function()
			if (IsValid(entity) and (self.nextSend or 0) < CurTime()) then
				self.nextSend = CurTime() + 1
				local dialogue = {
					npc = {},
					player = {},
				}
				for k, v in pairs(self.npcd:GetLines()) do
					if v:IsValid() then
						dialogue.npc[ v.uid ] = v.text
					end
				end
				for k, v in pairs(self.plyd:GetLines()) do
					if v:IsValid() then
						dialogue.player[ v.uid ] = v.text
					end
				end
				local factionData = {}
				for k, v in pairs(self.factions) do
					if (v:GetChecked()) then
						factionData[k] = true
					end
				end
				local classData = {}
				for k, v in pairs(self.classes) do
					if (v:GetChecked()) then
						classData[k] = true
					end
				end
				netstream.Start("nut_DialogueData", { entity, dialogue, factionData, classData, self.name:GetText(), self.desc:GetText(), self.model:GetText() or entity:GetModel() } )
				self:Close()
			end
		end
end
vgui.Register( "Nut_DialogueEditor", PANEL, "DFrame" )


function PLUGIN:ShouldDrawTargetEntity(entity)
	if (string.lower(entity:GetClass()) == "nut_talker") then
		return true
	end
end

function PLUGIN:DrawTargetID(entity, x, y, alpha)
	if (string.lower(entity:GetClass()) == "nut_talker") then
		local mainColor = nut.config.mainColor
		local color = Color(mainColor.r, mainColor.g, mainColor.b, alpha)

		nut.util.DrawText(x, y, entity:getNetVar("name", "John Doe"), color)
			y = y + nut.config.targetTall
		nut.util.DrawText(x, y, entity:getNetVar("desc", nut.lang.Get("no_desc")), Color(255, 255, 255, alpha), "nut_TargetFontSmall")
	end
end