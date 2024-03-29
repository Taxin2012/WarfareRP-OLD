ITEM.name = "Записка"
ITEM.model = "models/hardbass/notes_paper_1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, -180),
	fov = 2.4
}
ITEM.price = 129
ITEM.permit = "misc"

--[[function ITEM:getDesc()
	local str
	if (!self.entity or !IsValid(self.entity)) then
		str = "Кажется, на ней что-то написано.\n %s"
		return Format(str, self:getData("blocked", "Не запечатано"))
	else
		local data = self.entity:getData()
		str = "Кажется, на ней что-то написано.\n %s"
		return Format(str, self:getData("blocked", "Не запечатано"))
	end
end]]

ITEM.functions.Write = { -- sorry, for name order.
	name = "Прочитать",
	tip = "useTip",
	icon = "icon16/font.png",
	onRun = function(item)	
	local canwrite = true
	if item:getData("owner") == nil then
		item:setData("owner", item.player:getChar():getID())
	end
	if (item:getData("owner")) and (item:getData("owner") == item.player:getChar():getID()) then
		canwrite = true
	elseif (item:getData("owner")) and (item:getData("owner") ~= item.player:getChar():getID()) then
		canwrite = false
	end
	local client = item.player
		netstream.Start(client, "receiveNote", item:getID(), item:getData("text", ""), canwrite)	
		client:EmitSound("hgn/crussaria/items/itm_book_open.wav")
		return false
	end,
	onCanRun = function(item)
		if item:getData("block") then
			return false
		end
	end,
}

--[[ITEM.functions.Block = { -- sorry, for name order.
	name = "Запечатать",
	tip = "useTip",
	icon = "icon16/delete.png",
	onRun = function(item)
	local client = item.player
	if client:getChar():getInv():hasItem("note") then --Проверка наличия предмета для запечатывания письма.
		--client:getChar():getInv():remove(client:getChar():getInv():hasItem("wax"):getID()) --Изъятие предмета для запечатывания письма.
		item:setData("owner", item.player:getChar():getID())
		item:setData("block", true)
		item:setData("blocked", "Запечатано")
		client:EmitSound("npc/barnacle/neck_snap1.wav")
	else
		client:notify("У вас нет воска для печати!")
	end
	return false
	end,
	onCanRun = function(item)
		if item:getData("block") or item:getData("blocked") == "Печать сорвана"	or IsValid(item.entity) then
			return false
		end
	end,
}

ITEM.functions.UnBlock = { -- sorry, for name order.
	name = "Сорвать печать",
	tip = "useTip",
	icon = "icon16/delete.png",
	onRun = function(item)
	local client = item.player
		item:setData("owner", nil)
		item:setData("block", false)
		item:setData("blocked", "Печать сорвана")
		client:EmitSound("physics/cardboard/cardboard_box_impact_bullet1.wav")
	return false
	end,
	onCanRun = function(item)
		if !item:getData("block") then
			return false
		end
	end,
}]]
