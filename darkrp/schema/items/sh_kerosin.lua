ITEM.name = "Керосин (5 литров)"
ITEM.desc = "Керосин является широко распространенным топливом, используется в авиавции в качестве ракетного топлива, а так же при обжиге стеклянных изделий, ьытовых осветительных и нагревательных устройств. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-топливо для приготовления пищи"
ITEM.category = "misc"
ITEM.price = 1579
ITEM.exRender = true
ITEM.model = "models/hardbass/kerosene.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-209.15032958984, 0, 11),
	ang = Angle(0, -0, 0),
	fov = 5
}

ITEM.kerosinAmount = 5
function ITEM:getDesc()
	local str
	str = self.desc.." Осталось %s литр(а)"
	return Format(str, self:getData("kerosinAmount"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local kerosinAmount = item:getData("kerosinAmount", item.kerosinAmount or 1)
		draw.SimpleText(kerosinAmount, "nutIconFont", 4, y, Color(255, 255, 255, 255))
	end
end

function ITEM:onInstanced()
	if !self:getData("kerosinAmount") then
		self:setData("kerosinAmount", self.kerosinAmount)
	end
end