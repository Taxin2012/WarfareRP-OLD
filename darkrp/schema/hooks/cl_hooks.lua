SCHEMA.displays = {}

function SCHEMA:HUDPaint()
local W = ScrW()
local H = ScrH()
	if (LocalPlayer():getNetVar("mask1", true) == true) then
		local overlay = Material( "gasmask/helm_battle1.png", "noclamp" )

		surface.SetMaterial(overlay)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, W, H)
	elseif (LocalPlayer():getNetVar("mask2", true) == true) then
		local overlay = Material( "gasmask/helm_scientific2.png", "noclamp" )

		surface.SetMaterial(overlay)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, W, H)
	elseif (LocalPlayer():getNetVar("mask3", true) == true) then
		local overlay = Material( "gasmask/helm_respirator1.png", "noclamp" )

		surface.SetMaterial(overlay)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, W, H)
	end
	if (LocalPlayer():Health() > 0 and LocalPlayer():GetVar("scope") == true) then
if (LocalPlayer():GetActiveWeapon():GetClass() == "ssk_gauss" or LocalPlayer():GetActiveWeapon():GetClass() == "ssk_il86") then
local W = ScrW()
local H = ScrH()
local X = ScrW()/2
local Y = ScrH()/2
local cross = Material( "vgui/hud/wpn_crosshair_l85.png", "noclamp" )
surface.SetMaterial(cross)
surface.SetDrawColor(255, 255, 255, 255)
surface.DrawTexturedRect(0, 0, W, H)
end
if (LocalPlayer():GetActiveWeapon():GetClass() == "ssk_val") then
local W = ScrW()
local H = ScrH()
local X = ScrW()/2
local Y = ScrH()/2
local cross = Material( "vgui/hud/wpn_crosshair.png", "noclamp" )
surface.SetMaterial(cross)
surface.SetDrawColor(255, 255, 255, 255)
surface.DrawTexturedRect(0, 0, W, H)
end
if (LocalPlayer():GetActiveWeapon():GetClass() == "ssk_fn2000" or LocalPlayer():GetActiveWeapon():GetClass() == "ssk_gp37") then
local W = ScrW()
local H = ScrH()
local X = ScrW()/2
local Y = ScrH()/2
local cross = Material( "vgui/hud/wpn_crosshair_g36.png", "noclamp" )
surface.SetMaterial(cross)
surface.SetDrawColor(255, 255, 255, 255)
surface.DrawTexturedRect(0, 0, W, H)
end
if (LocalPlayer():GetActiveWeapon():GetClass() == "ssk_svd" or LocalPlayer():GetActiveWeapon():GetClass() == "ssk_vintorez" or LocalPlayer():GetActiveWeapon():GetClass() == "ssk_svu") then
local W = ScrW()
local H = ScrH()
local X = ScrW()/2
local Y = ScrH()/2
local cross = Material( "vgui/hud/wpn_crosshair.png", "noclamp" )
surface.SetMaterial(cross)
surface.SetDrawColor(255, 255, 255, 255)
surface.DrawTexturedRect(0, 0, W, H)
end
end
end

function SCHEMA:addDisplay(text, color)
	if (LocalPlayer():isCombine()) then
		color = color or Color(0, 0, 0)

		SCHEMA.displays[#SCHEMA.displays + 1] = {text = tostring(text):upper(), color = color, realText = ""}
		LocalPlayer():EmitSound("buttons/button16.wav", 30, 120)
	end
end

function SCHEMA:OnChatReceived(client, chatType, text, anonymous)
	local class = nut.chat.classes[chatType]

	if (client:isCombine() and class and class.filter == "ic") then
		return ""..text..""
	end
end

function SCHEMA:CharacterLoaded(character)
	if (character == LocalPlayer():getChar()) then
		if (self:isCombineFaction(character:getFaction())) then
			vgui.Create("nutCombineDisplay")
		elseif (IsValid(nut.gui.combine)) then
			nut.gui.combine:Remove()
		end
	end
end

function SCHEMA:OnContextMenuOpen()
	if (IsValid(nut.gui.combine)) then
		nut.gui.combine:SetVisible(true)
	end
end

function SCHEMA:OnContextMenuClose()
	if (IsValid(nut.gui.combine)) then
		nut.gui.combine:SetVisible(false)
	end
end
local color = {}
if (game.GetMap() == "rp_garbage_shoc") then
color["$pp_colour_addr"] = 0
color["$pp_colour_addg"] = 0
color["$pp_colour_addb"] = 0
color["$pp_colour_brightness"] = 0.03
color["$pp_colour_contrast"] = 1.1
color["$pp_colour_colour"] = 0.85
color["$pp_colour_mulr"] = 0
color["$pp_colour_mulg"] = 0
color["$pp_colour_mulb"] = 0
elseif (game.GetMap() == "rp_army_warehouses_v1a") then
color["$pp_colour_addr"] = 0
color["$pp_colour_addg"] = 0
color["$pp_colour_addb"] = 0
color["$pp_colour_brightness"] = -0.01
color["$pp_colour_contrast"] = 0.8
color["$pp_colour_colour"] = 0.65
color["$pp_colour_mulr"] = 0
color["$pp_colour_mulg"] = 0
color["$pp_colour_mulb"] = 0
elseif (game.GetMap() == "rp_rostok_v1") then
color["$pp_colour_addr"] = 0
color["$pp_colour_addg"] = 0
color["$pp_colour_addb"] = 0
color["$pp_colour_brightness"] = -0.01
color["$pp_colour_contrast"] = 0.8
color["$pp_colour_colour"] = 0.65
color["$pp_colour_mulr"] = 0
color["$pp_colour_mulg"] = 0
color["$pp_colour_mulb"] = 0
elseif (game.GetMap() == "rp_agroprom") then
color["$pp_colour_addr"] = 0
color["$pp_colour_addg"] = 0
color["$pp_colour_addb"] = 0
color["$pp_colour_brightness"] = -0.01
color["$pp_colour_contrast"] = 1
color["$pp_colour_colour"] = 0.65
color["$pp_colour_mulr"] = 0
color["$pp_colour_mulg"] = 0
color["$pp_colour_mulb"] = 0
end

function SCHEMA:RenderScreenspaceEffects()
	DrawColorModify(color)
end

netstream.Hook("cDisp", function(text, color)
	SCHEMA:addDisplay(text, color)
end)

netstream.Hook("plyData", function(...)
	vgui.Create("nutData"):setData(...)
end)

netstream.Hook("obj", function(...)
	vgui.Create("nutObjective"):setData(...)
end)

netstream.Hook("voicePlay", function(sounds, volume, index)
	if (index) then
		local client = Entity(index)

		if (IsValid(client)) then
			nut.util.emitQueuedSounds(client, sounds, nil, nil, volume)
		end
	else
		nut.util.emitQueuedSounds(LocalPlayer(), sounds, nil, nil, volume)
	end
end)

hook.Add("CanDrawAmmoHUD", "DisableLeAmmoHUD", function()
return false;
end);