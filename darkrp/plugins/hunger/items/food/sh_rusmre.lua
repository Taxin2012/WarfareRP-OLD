ITEM.name = "Российский рацион питания ИРП-Б" --Название предмета
ITEM.desc = "Завтрак, обед и ужин- все в одном пакете. Поставляется в полимерных коробках. \n\nХАРАКТЕРИСТИКИ: \n-военный рацион \n-здоровое питане \n\nНасыщение 100 \nЖажда 100" --Его описание
ITEM.model = Model("models/misery/rations/russian_mre.mdl") --Нажимаешь ПКМ на предмет и копируешь(1 строчка), вставляешь сюда
ITEM.price = 27555 --Цена
ITEM.height = 1 --Сколько занимает предмет по ширине
ITEM.width = 2 --Сколько занимает предмет по вертикале
ITEM.hunger = 100
ITEM.thirst = 100
ITEM.quantity = 7 
ITEM.empty = false
ITEM.iconCam = {
	pos = Vector(238.69999694824, 199.89999389648, 366.01306152344),
	ang = Angle(49.411766052246, 220, 30.588235855103),
	fov = 3.2
}
ITEM.exRender = true
function ITEM:getDesc()
	local str
	str = self.desc.."\n\nОсталось %s порций."
	return Format(str, self:getData("quantity"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local quantity = item:getData("quantity", item.quantity or 1)
		draw.SimpleText(quantity, "NameFactionFont", 4, y, Color(210, 180, 140, 180))
	end
end

ITEM.functions.use = { -- sorry, for name order.
	name = "употребить",
	tip = "useTip",
	icon = "icon16/cup.png",
	onRun = function(item)
	local client = item.player
			item.player:EmitSound("ration_using/rus_ration.wav", 80, 110)	
			if item.hunger > 0 then client:restoreHunger(item.hunger) end
			if item.thirst > 0 then client:restoreThirst(item.thirst) end
			--if (IsValid(target) and target:IsPlayer() and target:Alive()) then
			item:setData("quantity", item:getData("quantity", item.quantity or 0) - 1)
			item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
			if item:getData("quantity") < 1 then
				--item.player:notify("Вы израсходовали все аптечки")
				return true
			end
		--end
		return false;
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

function ITEM:onInstanced()
	if !self:getData("quantity") then
		self:setData("quantity", self.quantity)
	end
end
