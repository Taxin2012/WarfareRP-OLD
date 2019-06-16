local PANEL = {}
function PANEL:Init()
	self:SetSize(256, 36)
	self:SetContentAlignment(5)
	self:SetFont("StalkerSmallFont")
	self:SetTextColor(Color(210, 180, 140))
	self:SetDrawOnTop(true)
	function self:Paint( w, h )
		local material = Material("ui/ui_texte1ntry.png") 
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end
end
vgui.Register("nutNotice", PANEL, "DLabel")