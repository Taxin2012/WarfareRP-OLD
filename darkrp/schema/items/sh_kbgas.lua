ITEM.name = "Баллон с газом (7 литров)"
ITEM.desc = "Тяжелый металлический газовый баллон, пропитанный изнутри особыми полимерами для хранения внутри СО2/О2 раза, а с внешней стороны покрыт гипалоном для защиты от погодных условий и ультрафиолета. Этот газовый баллон пригоден для хранения внутри любого промышленного газа под давлением. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-топливо для приготовления пищи"
ITEM.category = "misc"
ITEM.price = 1736
ITEM.exRender = true
ITEM.model = "models/z-o-m-b-i-e/st/kitchen/st_gaz_balon_01.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(240.46937561035, 201.77803039551, 157.98692321777),
	ang = Angle(25, 220, 0),
	fov = 4.923632871419
}


ITEM.kerosinAmount = 8
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