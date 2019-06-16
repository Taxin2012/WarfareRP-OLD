ITEM.name = "Обычная книга"
ITEM.model = "models/props_lab/binderblue.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.attribute = "stm"
ITEM.attributeAmount = 1
ITEM.price = 100000
ITEM.category = "Образование"
function ITEM:getDesc()
	local str
	
	if (!self.entity or !IsValid(self.entity)) then
		str = "Магическая книга.\nЭта книга повысит ваш %s."

		return Format(str, nut.attribs.list[self.attribute].name)
	else
		local data = self.entity:getData()

		str = self.name .. ". Эта книга повысит ваш %s."
		return Format(str, nut.attribs.list[self.attribute].name)
	end
end

ITEM:hook("use", function(item)
	item.player:EmitSound("ui/extended.wav", 60, 120)
end)

ITEM.functions.use = { 
	name = "Читать",
	tip = "useTip",
	icon = "icon16/book.png",
	onRun = function(item)
		local attrib = item.attribute

		if (item.player and item:getData("read", false) == false) then
			if (attrib and nut.attribs.list[attrib]) then
				item.player:getChar():updateAttrib(attrib, item.attributeAmount)
				item.player:notify("Ваше умение "..nut.attribs.list[attrib].name.." повысилось +"..item.attributeAmount)
				return true
			end
		end

		return false
	end,
	onCanRun = function(item)
		local client = item.player or LocalPlayer()
		return (!IsValid(item.entity))
	end
}