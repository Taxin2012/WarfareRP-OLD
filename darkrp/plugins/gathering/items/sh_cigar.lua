ITEM.name = "Сигареты «Marlboro»" --Название предмета
ITEM.desc = "Сигареты, импортированные с Запада. Должно быть, кто-то уже выкурил большую их часть, осталось только несколько штук. \n\nХАРАКТЕРИСТИКИ: \n-слабый отравляющий эффект \n-для использования требуется: зажигалка \n-возможно закурить" --Его описание
ITEM.model = Model("models/misery/drugz/cigar0.mdl") --Нажимаешь ПКМ на предмет и копируешь(1 строчка), вставляешь сюда
ITEM.price = 2424 --Цена
ITEM.height = 1 --Сколько занимает предмет по ширине
ITEM.width = 1 --Сколько занимает предмет по вертикале
ITEM.cigarettesAmount = 4

function ITEM:getDesc()
	local str
	str = self.desc.."\n\nОсталось %s сигарет."
	return Format(str, self:getData("cigarettesAmount"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local cigarettesAmount = item:getData("cigarettesAmount", item.cigarettesAmount or 1)
		draw.SimpleText(cigarettesAmount, "NameFactionFont", 4, y, Color(210, 180, 140, 180))
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
			item:setData("cigarettesAmount", item:getData("cigarettesAmount") - 1)

			
			if item:getData("cigarettesAmount") < 1 then
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
	if !self:getData("cigarettesAmount") then
		self:setData("cigarettesAmount", self.cigarettesAmount)
	end
end

ITEM.iconCam = {
	pos = Vector(0, 0, 189.54248046875),
	ang = Angle(90, 0, 0),
	fov = 1.5
}
ITEM.exRender = true