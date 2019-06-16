ITEM.name = "Персональное удостоверение ВСУ"
ITEM.desc = "Документ военно служащего Украины, в нем содержатся данные, которые занесены в Систему, автоматически даёт право на проход в зону экологического бедствия. \n\nХАРАКТЕРИСТИКИ: \n-личная вещь"
ITEM.category = "misc"
ITEM.price = 9535
ITEM.exRender = true
ITEM.model = "models/hardbass/identity_card.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 90),
	fov = 3.4
}
ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end

ITEM.functions.Use = {
	onRun = function(item)
		local client = item.player
		if (IsValid(client) and client:IsPlayer()) then
				local character = client:getChar() 
				local Inventory = character:getInv() 

				Inventory:add("docsbu", 1, 
				{ 
				name = character:getName(),
				desc = character:getDesc()
				})
			return true
		end

		return false
	end,
	onCanRun = function(item)
		return item.player:Team() == FACTION_MILITARY
	end
}

function ITEM:getDesc()
	local description = self.desc.."\n\nИмя: "..self:getData("name", "Пусто").."\nОписание: "..self:getData("desc", "Пусто").."."
	return description
end