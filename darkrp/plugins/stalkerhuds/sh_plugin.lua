local PLUGIN = PLUGIN

PLUGIN.name = "S.T.A.L.K.E.R Hud"
PLUGIN.author = "Petrenko & Kek1ch"
PLUGIN.desc = "Stalker Call of Pripyat HUD."

AddCSLuaFile()
------------------------------------------------------------
if CLIENT then	-- System Client Realm

	------------------------------------------------------------
	--	HUD Special Functions
	--	Author: thejjokerr
	------------------------------------------------------------
	function surface.DrawPartialTexturedRect( x, y, w, h, partx, party, partw, parth, texw, texh )
	/* Source: http://facepunch.com/showthread.php?t=1026117 */
		--[[ 
			Arguments:
			x: Where is it drawn on the x-axis of your screen
			y: Where is it drawn on the y-axis of your screen
			w: How wide must the image be?
			h: How high must the image be?
			partx: Where on the given texture's x-axis can we find the image you want?
			party: Where on the given texture's y-axis can we find the image you want?
			partw: How wide is the partial image in the given texture?
			parth: How high is the partial image in the given texture?
			texw: How wide is the texture?
			texh: How high is the texture?
		]]--
		
		-- Verify that we recieved all arguments
		if not( x && y && w && h && partx && party && partw && parth && texw && texh ) then
			ErrorNoHalt("surface.DrawPartialTexturedRect: Missing argument!")	
			
			return	
		end	
		
		-- Get the positions and sizes as percentages / 100
		local percX, percY = partx / texw, party / texh	
		local percW, percH = partw / texw, parth / texh	
		
		-- Process the data
		local vertexData = {
			{
				x = x,
				y = y,
				u = percX,
				v = percY
			},
			{
				x = x + w,
				y = y,
				u = percX + percW,
				v = percY
			},
			{
				x = x + w,
				y = y + h,
				u = percX + percW,
				v = percY + percH
			},
			{
				x = x,
				y = y + h,
				u = percX,
				v = percY + percH
			}
		}	
			
		surface.DrawPoly( vertexData )	
	end	  
	function surface.DrawPartialTexturedRectRotated( x, y, w, h, partx, party, partw, parth, texw, texh, rot )
	local matrix = Matrix()
		  matrix:Rotate( Angle( 0,-rot,0 ) )  
	cam.PushModelMatrix( matrix )
	surface.DrawPartialTexturedRect( x, y, w, h, partx, party, partw, parth, texw, texh )
	cam.PopModelMatrix()
	end

	------------------------------------------------------------
	--	HUD Fonts
	--	Author: V92
	------------------------------------------------------------
	surface.CreateFont(	"StalkerClock", {			size = 14,	weight = 500,	antialias = true,	shadow = true,	font = "Arial"})
	surface.CreateFont(	"StalkerRadarText", {		size = 64,	weight = 400,	antialias = true,	shadow = true,	font = "Arial"})
	surface.CreateFont(	"StalkerAmmo", {			size = 11,	weight = 300,	antialias = true,	shadow = true,	font = "StalkerSmallFont"})
	surface.CreateFont(	"StalkerAmmoStore", {		size = 11,	weight = 300,	antialias = true,	shadow = true,	font = "StalkerSmallFont"})
	surface.CreateFont(	"StalkerPDATitleBarTxt", {	size = 24,	weight = 500,	antialias = true,	shadow = true,	font = "Arial"})
	surface.CreateFont(	"StalkerPDAErrorTxt", {		size = 72,	weight = 500,	antialias = false,	shadow = false,	font = "Arial"})
	surface.CreateFont(	"StalkerPDAName", {			size = 14,	weight = 500,	antialias = true,	outline = false,		shadow = true,	font = "Arial"})

	local	showHUD = true
	local	function VNT_STALKERHUD_Toggle()	showHUD = !showHUD	end
	concommand.Add("VNT_STALKERHUD_Toggle", VNT_STALKERHUD_Toggle)

	------------------------------------------------------------
	--	HUD Hiding
	--	Author: AceCool
	------------------------------------------------------------
	local HideHudElements = {
		// HL2 HUD - set these up how you want...
		CAchievementNotificationPanel   = false;	 -- Achievement notifications
		CHudAmmo                        = true;	 -- Primary Ammo
		CHudBattery                     = true;	 -- Your Armor
		CHudChat                        = false;	 -- The chat area
		CHudCloseCaption                = false;	 -- The closed-caption messages
		CHudCredits                     = false;	 -- Credits
		CHudCrosshair                   = true;	 -- Your crosshair
		CHudDeathNotice                 = true;	 -- Death notices that appear at the top right of the screen
		CHudHealth                      = true;	 -- Your Health
		CHudHintDisplay                 = true;	 -- Displays hints as seen in Half-Life 2
		CHudHistoryResource             = true;	 -- List of items/ammunition the player recently picked up
		CHudSecondaryAmmo               = true;	 -- Secondary Ammo
		CHudSuitPower                   = false;	 -- Most likely Auxiliary Power
		CHudTrain                       = false;	 -- Controls when using a func_train?
		CHudMessage                     = false;	 -- Messages printed to the center of the screen
		CHudMenu                        = false;	 -- Unknown
		CHudWeapon                      = false;	 -- This is the indicators that appear when you have picked up ammo or weapons.
		CHudWeaponSelection             = false;	 -- Player weapon selection menu
		CHudGMod                        = false;	 -- HUD's produced by Garrysmod
		CHudDamageIndicator             = false;	 -- The red trapazoids displayed on the side of the screen when damage is taken, also includes the red screen you get when died from combat.
		CHudVehicle                     = false;	 -- Control panel when entering a vehicle/crane?
		CHudVoiceStatus                 = false;	 -- Shows when other players use microphone voice chat.
		CHudVoiceSelfStatus             = false;	 -- Shows when the local player uses microphone voice chat.
		CHudSquadStatus                 = false;	 -- Squad status panel shown when rebels join your squad
		CHudZoom                        = false;	 -- Dimming and large crosshair
		CHudCommentary                  = false;	 -- Display showing the duration and progress of the currently active commentary node
		CHudGeiger                      = false;	 -- Commentary panel
		CHudAnimationInfo               = false;	 -- Displays information about HUD elements, activated by the console command cl_animationinfo
		CHUDAutoAim                     = false;	 -- Unknown
		CHudFilmDemo                    = false;	 -- Unknown
		CHudHDRDemo                     = false;	 -- Lost Coast HDR Demonstration HUD element
		CHudPoisonDamageIndicator       = false;	 -- Panel that appears upon a player receiving poison [Neurotoxin] damage
		CPDumpPanel						= false;	 -- Unknown
		VNTHUDStalker					= false;		 -- Don't hide the basic hud we just added...
	}	

	local	function HUDShouldDraw( _name )	
		if(!showHUD) then return end
		return !HideHudElements[ _name ]	
	end
	hook.Add("HUDShouldDraw", "VNTSTALKERHUDDisabler", HUDShouldDraw)
	
	------------------------------------------------------------
	--	HUD Paint Function
	--	Author: V92
	------------------------------------------------------------
	hook.Add("HUDPaint", "VNTHUDStalker", function( )
		if(!showHUD) then return end
		local _P = LocalPlayer()
		if ((_P:Alive() == false) or (IsValid(_P)) == false) then return end
		------------------------------------------------------------
		--	HUD Checks
		------------------------------------------------------------
		local _SHOULDDRAW = hook.Call( "HUDShouldDraw", GAMEMODE, "VNTHUDStalker" )	
		local _W = _P:GetActiveWeapon()	
		if IsValid(_W) and _W:GetClass() == "gmod_camera" then return end

		------------------------------------------------------------
		--	HUD Base (Health/Armour/Ammo)
		------------------------------------------------------------
		local hudBaseXSize	= 256
		local hudBaseYSize	= 128
		local hudBaseXPos 	= ScrW() - (hudBaseXSize + -120)
		local hudBaseYPos 	= ScrH() - (hudBaseYSize + -5)
		surface.SetDrawColor(Color(225,225,225,255)) 
		local Tex_HudBack = surface.GetTextureID("jessev92/ui/stalker/cop/hud1")
		surface.SetTexture( Tex_HudBack )
		surface.DrawPartialTexturedRect ( hudBaseXPos,hudBaseYPos,hudBaseXSize, hudBaseYSize, 0, 0, 222, 63, hudBaseXSize, hudBaseYSize )
		
		------------------------------------------------------------
		--	HUD Base (Minimap/Noise/Sight/Clock/Compass)
		------------------------------------------------------------
		local hudMapXSize	= 0
		local hudMapYSize	= 0
		local hudMapXPos 	= 12
		local hudMapYPos 	= 12
		local Tex_HudMapBack = surface.GetTextureID("jessev92/ui/stalker/cop/minimap")
		surface.SetTexture( Tex_HudMapBack )
		surface.DrawPartialTexturedRect ( hudMapXPos,hudMapYPos,218, 218, 0, 0, 218, 218, hudMapXSize, hudMapYSize )
	
		------------------------------------------------------------
		--	HUD Compass
		------------------------------------------------------------
		local compassX = hudMapXPos - 5
		local compassY = hudMapYPos - 5
	    local compassSize	=	0
		local compassAng = LocalPlayer():GetAimVector():Angle().y -90
		local Tex_Compass = surface.GetTextureID("JesseV92/ui/stalker/cop/compass_needle")
		surface.SetTexture(Tex_Compass)
		surface.DrawTexturedRectRotated(compassX+(compassSize),compassY+(compassSize),compassSize,compassSize,compassAng * -1)
		--]]
		--[[
		local compassX = ScrH()/2
		local compassY = ScrH()/2
		local compassSizeX	=	16
		local compassSizeY	=	32
		local compassAng = LocalPlayer():GetAimVector():Angle().y -270
		local Tex_Compass = surface.GetTextureID("JesseV92/ui/stalker/cop/compass_needle")
		surface.SetTexture(Tex_Compass)
		local Tex_Compass = surface.GetTextureID("JesseV92/ui/stalker/cop/minimap")
		surface.DrawPartialTexturedRectRotated ( compassX-compassSizeX/2,compassY-compassSizeY/2, compassSizeX, compassSizeY, 218, 0, 10, 30, hudMapXSize, hudMapYSize, compassAng * -1 )
		--]]
		------------------------------------------------------------
		--	HUD Health
		------------------------------------------------------------
		--[[local HPInt = _P:Health()
		local HPIntMax = 100
		if HPInt <= 0 then HPInt = 0 end
		if HPInt >= 100 then HPInt = 100 end		
		local HP_X = ScrW()-180	local HP_Y = ScrH()
		local HPBar_X = -4		local HPBar_Y = (HP_Y-164)
		if HPInt > 0 then
			for INTEGER=1, (HPInt) do
				surface.SetTexture( Tex_HudBack )   
				surface.SetDrawColor(255,255,255,255)  
				surface.DrawPartialTexturedRect ( 
					hudBaseXPos + -100,
					hudBaseYPos + 80, 
					160 / (HPIntMax/HPInt),
					16, 
					0,		-- Starts at 0 X
					126,	-- Starts at 126 Y
					138 / (HPIntMax/HPInt),
					16, 
					256, 
					256 )
			end
		end]]
		
		------------------------------------------------------------
		--	HUD STAMINA
		------------------------------------------------------------

		--[[local STInt = LocalPlayer():getLocalVar("stm") or 0
		local STIntMax = 100
		if STInt <= 0 then STInt = 0 end
		if STInt >= 100 then STInt = 100 end
		local STBar_X = -4	local STBar_Y = (HPBar_Y+23)	

		if STInt > 0 then
			for INTEGER=1,(STInt) do
				surface.SetTexture( Tex_HudBack )   
				surface.SetDrawColor(255,255,255,255)
				surface.DrawPartialTexturedRect ( 
					hudBaseXPos + -100,
					hudBaseYPos + 95, 
					160 / (STIntMax/STInt),
					10, 
					0,		-- Starts at 0 X
					144,	-- Starts at 144 Y
					138 / (STIntMax/STInt),
					10,
					256,
					256 )
			end
		end]]
		--	HUD Ammo
		------------------------------------------------------------
		local mag = -1				-- Primary Mag
		local store = 0				-- Total Reserve
		if IsValid(_W) then
			local hudAmmoXSize	= 88
			local hudAmmoYSize	= 40
			local hudAmmoXPos 	= hudBaseXPos + 200
			local hudAmmoYPos 	= hudBaseYPos + 92
			--[[if file.Exists( "materials/vgui/hud/" .. _WC .. ".vmt", "GAME" ) then 
				local Tex_HudAmmoIcon	= surface.GetTextureID( "vgui/hud/" .. _WC )
				surface.SetTexture(Tex_HudAmmoIcon)
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.DrawTexturedRect(hudAmmoXPos-44,hudAmmoYPos-24,hudAmmoXSize,hudAmmoYSize)
			else
			--]]
				--local Tex_HudAmmoIcon = surface.GetTextureID("jessev92/ui/stalker/ammo/556nato")
				--surface.SetTexture(Tex_HudAmmoIcon)
				--surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				--surface.DrawTexturedRect(hudAmmoXPos-32,hudAmmoYPos-32,64,64)
			--end
			------------------------------------------------------------
			--	HUD Primary Ammo
			------------------------------------------------------------
			mag = _W:Clip1()
			store = _P:GetAmmoCount( _W:GetPrimaryAmmoType() ) + _W:Clip1()
			if mag > 999 then mag = 999 end
			if store > 999 then store = 999 end
			if mag >= 0 or store > 0 then
				if mag == -1 then
					draw.SimpleText( store, "StalkerAmmo", hudBaseXPos+96, hudBaseYPos+80, Color( 210, 105, 30, 255 ), 1, 1)
				else
					draw.SimpleText( mag, "StalkerAmmo", hudBaseXPos+120, hudBaseYPos+92, Color( 210, 105, 30, 255 ), 1, 1)
					draw.SimpleText( store, "StalkerAmmoStore", (hudBaseXPos+120), hudBaseYPos+104, Color( 210, 105, 30, 255 ), 1, 1)
				end
			else
				draw.SimpleText( "", "StalkerAmmo", hudBaseXPos+96, hudBaseYPos+68, Color( 210, 105, 30, 255 ), 1, 1)
				draw.SimpleText( "", "StalkerAmmoStore", (hudBaseXPos+100), hudBaseYPos+96, Color( 210, 105, 30, 255 ), 1, 1)
			end

			local iconYpos = ScrH()-ScrH()/3
			local hunger = Material( "ui/food11.png", "noclamp smooth" )
			if (LocalPlayer():getLocalVar("hunger") or 0)<60 then 
				if (LocalPlayer():getLocalVar("hunger") or 0)<40 then 
					if (LocalPlayer():getLocalVar("hunger") or 0)<20 then 
						if (LocalPlayer():getLocalVar("hunger") or 0)<10 then 
							surface.SetMaterial(Material( "ui/food41.png", "noclamp smooth" ))
							surface.SetDrawColor(255,255,255,255) 
							surface.DrawTexturedRectUV(ScrW()-50, iconYpos-19,19,19, 0, 0.01, 1, 1 ) //голод
						else
							surface.SetMaterial(Material( "ui/food31.png", "noclamp smooth" ))
							surface.SetDrawColor(255,255,255,255) 
							surface.DrawTexturedRectUV(ScrW()-50, iconYpos-19,19,19, 0, 0.01, 1, 1  ) //голод
						end
					else
						surface.SetMaterial(Material( "ui/food21.png", "noclamp smooth" ))
						surface.SetDrawColor(255,255,255,255) 
						surface.DrawTexturedRectUV(ScrW()-50, iconYpos-19,19,19, 0, 0.01, 1, 1  ) //голод
					end
				else
					surface.SetMaterial(Material( "ui/food11.png", "noclamp smooth" ))
					surface.SetDrawColor(255,255,255,255) 
					surface.DrawTexturedRectUV(ScrW()-50, iconYpos-19,19,19, 0, 0.01, 1, 1  ) //голод
				end
			//surface.SetTexture(tex1)
				//surface.SetDrawColor(255,255,255,255) 
				//surface.DrawTexturedRectUV(ScrW()-50, iconYpos-44,20,20, 0.15, 0.85, 0.23, 0.94 ) //голод
			end
			
			local iconYpos = ScrH()-ScrH()/4
			local thirst = Material( "ui/water51.png", "noclamp smooth" )
			if (LocalPlayer():getLocalVar("thirst") or 0)<60 then 
				if (LocalPlayer():getLocalVar("thirst") or 0)<50 then 
					if (LocalPlayer():getLocalVar("thirst") or 0)<20 then 
						if (LocalPlayer():getLocalVar("thirst") or 0)<10 then 
							surface.SetMaterial(Material( "ui/water81.png", "noclamp smooth" ))
							surface.SetDrawColor(255,255,255,255) 
							surface.DrawTexturedRectUV(ScrW()-50, iconYpos-19,19,19, 0, 0.01, 1, 1 ) //жажда
						else
							surface.SetMaterial(Material( "ui/water71.png", "noclamp smooth" ))
							surface.SetDrawColor(255,255,255,255) 
							surface.DrawTexturedRectUV(ScrW()-50, iconYpos-19,19,19, 0, 0.01, 1, 1  ) //жажда
						end
					else
						surface.SetMaterial(Material( "ui/water61.png", "noclamp smooth" ))
						surface.SetDrawColor(255,255,255,255) 
						surface.DrawTexturedRectUV(ScrW()-50, iconYpos-19,19,19, 0, 0.01, 1, 1  ) //жажда
					end
				else
					surface.SetMaterial(Material( "ui/water51.png", "noclamp smooth" ))
					surface.SetDrawColor(255,255,255,255) 
					surface.DrawTexturedRectUV(ScrW()-50, iconYpos-19,19,19, 0, 0.01, 1, 1  ) //жажда
				end
			//surface.SetTexture(tex1)
				//surface.SetDrawColor(255,255,255,255) 
				//surface.DrawTexturedRectUV(ScrW()-50, iconYpos-44,30,20, 0.15, 0.85, 0.23, 0.94 ) //жажда
			end
			
			local iconYpos = ScrH()-ScrH()/2.3
			local radioactive = Material( "ui/vlowrad.png", "noclamp smooth" ) --ui/vlowrad.png
			if (LocalPlayer():getLocalVar("radioactive") or 0)>10 then 
				if (LocalPlayer():getLocalVar("radioactive") or 0)>30 then 
					if (LocalPlayer():getLocalVar("radioactive") or 0)>50 then 
						if (LocalPlayer():getLocalVar("radioactive") or 0)>70 then 
							surface.SetMaterial(Material( "ui/hightad.png", "noclamp smooth" )) --ui/medrad.png
							surface.SetDrawColor(255,255,255,255) 
							surface.DrawTexturedRectUV(ScrW()-44, iconYpos-24,24,24, 0, 0.01, 1, 1 ) //рад
						else
							surface.SetMaterial(Material( "ui/medrad.png", "noclamp smooth" ))
							surface.SetDrawColor(255,255,255,255) 
							surface.DrawTexturedRectUV(ScrW()-44, iconYpos-24,24,24, 0, 0.01, 1, 1  ) //рад
						end
					else
						surface.SetMaterial(Material( "ui/lowrad.png", "noclamp smooth" ))
						surface.SetDrawColor(255,255,255,255) 
						surface.DrawTexturedRectUV(ScrW()-44, iconYpos-24,24,24, 0, 0.01, 1, 1  ) //рад
					end
				else
					surface.SetMaterial(Material( "ui/vlowrad.png", "noclamp smooth" )) --ui/vlowrad.png
					surface.SetDrawColor(255,255,255,255) 
					surface.DrawTexturedRectUV(ScrW()-44, iconYpos-24,24,24, 0, 0.01, 1, 1  ) //рад
				end
			//surface.SetTexture(tex1)
				//surface.SetDrawColor(255,255,255,255) 
				//surface.DrawTexturedRectUV(ScrW()-44, iconYpos-44,30,20, 0.15, 0.85, 0.23, 0.94 ) //рад
			end
			
			local iconYpos = ScrH()-ScrH()/2
			local psy = Material( "ui/vlowpsi.png", "noclamp smooth" )
			if (LocalPlayer():getLocalVar("psy") or 0)>10 then 
				if (LocalPlayer():getLocalVar("psy") or 0)>30 then 
					if (LocalPlayer():getLocalVar("psy") or 0)>50 then 
						if (LocalPlayer():getLocalVar("psy") or 0)>70 then 
							surface.SetMaterial(Material( "ui/hightpsi.png", "noclamp smooth" ))
							surface.SetDrawColor(255,255,255,255) 
							surface.DrawTexturedRectUV(ScrW()-44, iconYpos-24,24,24, 0, 0.01, 1, 1 ) //пси
						else
							surface.SetMaterial(Material( "ui/medpsi.png", "noclamp smooth" ))
							surface.SetDrawColor(255,255,255,255) 
							surface.DrawTexturedRectUV(ScrW()-44, iconYpos-24,24,24, 0, 0.01, 1, 1  ) //пси
						end
					else
						surface.SetMaterial(Material( "ui/lowpsi.png", "noclamp smooth" ))
						surface.SetDrawColor(255,255,255,255) 
						surface.DrawTexturedRectUV(ScrW()-44, iconYpos-24,24,24, 0, 0.01, 1, 1  ) //пси
					end
				else
					surface.SetMaterial(Material( "ui/vlowpsi.png", "noclamp smooth" ))
					surface.SetDrawColor(255,255,255,255) 
					surface.DrawTexturedRectUV(ScrW()-44, iconYpos-24,24,24, 0, 0.01, 1, 1  ) //пси
				end
			//surface.SetTexture(tex1)
				//surface.SetDrawColor(255,255,255,255) 
				//surface.DrawTexturedRectUV(ScrW()-44, iconYpos-44,30,20, 0.15, 0.85, 0.23, 0.94 ) //пси
			end
			------------------------------------------------------------
			--	HUD Secondary Ammo
			------------------------------------------------------------
			local mag2 = 0				-- Secondary Mag
			local store2 = 0			-- Total Reserve
			mag2 = _P:GetAmmoCount( _W:GetSecondaryAmmoType() ) or 0
			store2 = _P:GetAmmoCount( _W:GetSecondaryAmmoType() )  + _W:Clip2() or 0
			if mag2 > 9 then mag2 = 9 end
			if store2 <= 0 then store2 = 0 elseif store2 > 9 then store2 = 9 end
			if mag2 > 0 then	
				draw.SimpleText( store2, "StalkerAmmoStore", (hudBaseXPos+48), hudBaseYPos+64, Color( 255, 217, 0, 255 ), 1, 1)	
			else
				draw.SimpleText( "", "StalkerAmmoStore", (hudBaseXPos+48), hudBaseYPos+64, Color( 255, 217, 0, 255 ), 1, 1)	
			end
		end
		end)
	------------------------------------------------------------
	--	HUD Post Processing - Vignette FX
	--	Author: Rush_Freak
	------------------------------------------------------------
	local	function STKHUD_Toggle_Vignette()
		if ( GetConVarNumber("VNT_STALKERHUD_VigFX") != 0 ) then 
			DrawMaterialOverlay( "jessev92/ui/vignette", 1 )
		end
	end
	hook.Add( "RenderScreenspaceEffects", "STKHUD_Toggle_Vignette", STKHUD_Toggle_Vignette )

	list.Set( "PostProcess", "Vignette",
	{
		icon		= "gui/postprocess/vignette.png",		
		convar		= "VNT_STALKERHUD_VigFX",
		category	= "Overlay",
		cpanel		= function( CPanel )
			CPanel:AddControl( "Header", { Text = "Vignette", Description = "Adds vignette effect" }  )
			CPanel:AddControl( "CheckBox", { Label = "Toggle", Command = "VNT_STALKERHUD_VigFX" }  )
		end,
	})
	
end

if GetConVarNumber("VNT_Debug_Prints") != 0 then	print( "[V92] STALKER HUD Shared Loaded!" )	end