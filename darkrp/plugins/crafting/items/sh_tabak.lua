ITEM.name = "Российский табак"
ITEM.category = nut.lang.Get( "icat_material" )
ITEM.model = Model( "models/hardbass/tobacco.mdl" )
ITEM.desc = "Сигареты довольно дорогие и редкие в Зоне, так что наличие табачкого сырья позволяет изготавливать собственные сигареты по более низкой цене. Герметичная упаковка из олова гарантирует, что табак будет оставаться свежим в течении нескольких дней или недель. \n\nХАРАКТЕРИСТКИ: \n-низкое качество \n-вредно для организма \n-используется для изготовления самокруток \n-для использования требуется: зажигалка"
ITEM.price = 3201
ITEM.exRender = true
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(86.833824157715, 72.86222076416, 54.575504302979),
	ang = Angle(25, 220, 0),
	fov = 4.8,
}

ITEM.bigtabakAmount = 3

function ITEM:getDesc()
	local str
	str = self.desc.." \nОсталось %s пакета"
	return Format(str, self:getData("bigtabakAmount"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local bigtabakAmount = item:getData("bigtabakAmount", item.bigtabakAmount or 1)
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
			item:setData("bigtabakAmount", item:getData("bigtabakAmount") - 1)
			
			if item:getData("bigtabakAmount") < 1 then
				item.player:notify("Табак кончился")
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
	if !self:getData("bigtabakAmount") then
		self:setData("bigtabakAmount", self.bigtabakAmount)
	end
end