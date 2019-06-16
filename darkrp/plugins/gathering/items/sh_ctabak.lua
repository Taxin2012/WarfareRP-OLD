ITEM.name = "Табачные листы (привозные, 5 пакетов)" --Название предмета
ITEM.desc = "Дорогой табак, завернутый в упаковку, судя по всему завезенный с Запада. Без каки--либо дополнительных вредных добавок, так что можно наслаждаться оригинальным вкусом самого табачного листа. \n\nХАРАКТЕРИСТИКИ: \n-слабый отравляющий эффект \n-для использования требуется: зажигалка \n-возможно закурить" --Его описаниевставляешь сюда
ITEM.price = 7722 --Цена
ITEM.model = "models/hardbass/dev_hand_rolling_tobacco.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, -25.882352828979),
	fov = 2
}

ITEM.tabakAmount = 4

function ITEM:getDesc()
	local str
	str = self.desc.." Осталось %s."
	return Format(str, self:getData("tabakAmount"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local tabakAmount = item:getData("tabakAmount", item.tabakAmount or 1)
	end
end

-- Вызывается когда игрок использует предмет
ITEM.functions.Smoke = {
	name = "Закурить",
	icon = "icon16/wand.png",
	onRun = function(item)
	local client = item.player
		if (IsValid(item.player) && item.player:Alive()) then
			if !item.player:getChar():getInv():hasItem("tinderbox") then
				item.player:notify("У вас нет зажигалки!")
				return false
			end
			
			local s = EffectData();
			s:SetOrigin(item.player:EyePos());
			util.Effect("cw_effect_smoke_cig", s);

			if (math.random(1,10) >= 5) then
				local cough = {
					"interface/inv_smoke.ogg",
					"interface/inv_smoke.ogg",
					"interface/inv_smoke.ogg",
					"interface/inv_smoke.ogg"
				}
				item.player:EmitSound(cough[math.random(1,#cough)], 50, 100)
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
			end;
			item:setData("tabakAmount", item:getData("tabakAmount") - 1)
			
			if item:getData("tabakAmount") < 1 then
				item.player:notify("Пачка пуста")
				return true
			end
		end
		return false;
	end,
	
	-- Вызывается когда проп лежит на земле, чтобы не вылезал подпункт - закурить
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

function ITEM:onInstanced()
	if !self:getData("tabakAmount") then
		self:setData("tabakAmount", self.tabakAmount)
	end
end

ITEM.exRender = true