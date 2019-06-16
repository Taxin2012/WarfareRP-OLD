ITEM.name = "Украинский рацион питания" --Название предмета
--ITEM.desc = "Украинский боевой рацион питания основан на российском аналоге ИРП-Б, состоящий лишь из коммерчески доступных консервов и сущеных продуктов питания, упакованных вместе с тонких пластиковых секциях. \n\nХАРАКТЕРИСТИКИ: \n-военный рацион \n-здоровое питание \n\nНасыщение 90% \nЖажда 90%" --Его описание
ITEM.desc = "Украинский боевой рацион питания основан на российском аналоге ИРП-Б, состоящий лишь из коммерчески доступных консервов и сущеных продуктов питания. \n\nХАРАКТЕРИСТИКИ: \n-военный рацион \n-здоровое питание \n\nНасыщение 90 \nЖажда 90"
ITEM.model = Model("models/misery/rations/ukrainian_ration.mdl") --Нажимаешь ПКМ на предмет и копируешь(1 строчка), вставляешь сюда
ITEM.price = 14574 --Цена
ITEM.height = 1 --Сколько занимает предмет по ширине
ITEM.width = 2 --Сколько занимает предмет по вертикале
ITEM.hunger = 90
ITEM.thirst = 90
ITEM.quantity = 4

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
			item.player:EmitSound("ration_using/us_ration.wav", 80, 110)	
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
ITEM.iconCam = {
ang = Angle(25, 220, 0),
fov = 4.66,
pos = Vector(172.8, 145, 107)
}

function ITEM:onInstanced()
	if !self:getData("quantity") then
		self:setData("quantity", self.quantity)
	end
end
ITEM.exRender = true