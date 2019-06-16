PLUGIN.name = "SafeZone"
PLUGIN.author = "Hikka"
PLUGIN.desc = "Настройки для зеленой зоны"

function PLUGIN:EntityTakeDamage(target, dmginfo)
	if IsValid(target) && target:IsPlayer() && target.safezone && (dmginfo:IsBulletDamage() || dmginfo:IsDamageType( DMG_SLASH ) || dmginfo:IsDamageType( DMG_CLUB ) || dmginfo:IsFallDamage()
	|| dmginfo:IsDamageType(DMG_CRUSH)) then
		dmginfo:SetDamage(0)
	end
end

netstream.Hook("hudsafezone", function(safez)
	LocalPlayer().inSafeZone = safez
end)

function PLUGIN:PostDrawHUD()
	local client = LocalPlayer()
	if (!client:getChar() || !client:Alive()) then
		return
	end

	if LocalPlayer().inSafeZone != true then return end
	
	local w, h = ScrW(), ScrH()
	local cury = h/17.5*3.5
	local tx, ty = draw.SimpleTextOutlined("Вы находитесь в безопасной зоне", "BigFontForSafe", w/2.82, cury, Color(210, 180, 140), 0, 0, 0, Color(210, 180, 140))
	cury = cury + ty
	--local tx, ty = draw.SimpleTextOutlined("УРОН В ЭТОЙ ЗОНЕ ЗАПРЕЩЕН", "nutDynFontSmall", w/2, cury, Color(255,140,0), 1, 1, 1, Color(0,0,0))
end

--local tx, ty = draw.SimpleText("Вы находитесь в безопасной зоне", "BigFontForSafe", w/2.4,  cury, Color(210, 180, 140))