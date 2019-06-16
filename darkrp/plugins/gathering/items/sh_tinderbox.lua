ITEM.name = "Зажигалка"
ITEM.model = "models/hardbass/lighter.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 1059
ITEM.desc = "Надежный, водонепроницаемный источник огня в Зоне важен не только для курения, но и для приготовления пищи. Эта металлическая газовая зажигалка является инеальным выбором для использования в Зоне. \n\nХАРАКТЕРИСТИКИ: \n-используется для: готовка, курение, розжиг костра \n\nПополняется с помощью: Топливо для зажигалки"
ITEM.tinderboxAmount = 8
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-0.30000001192093, 0, 200),
	ang = Angle(90, -180, 0),
	fov = 2
}
ITEM.functions.use = {
    name = "заправить зажигалку",
    icon = "icon16/add.png",
    onRun = function(item)
        local client = item.player
		local items = client:getChar():getInv():hasItem("brodyagalox")
		if (items) then
			local inv = client:getChar():getInv() 
			--for k, v in pairs(inv:getItems()) do
				--local itemTable = nut.item.instances[v.id]
				item:setData("tinderboxAmount", item:getData("tinderboxAmount", 0) + 8)
				--client:PrintMessage(HUD_PRINTTALK, "Вы наполнили зажигалку газом")	
				client:EmitSound( Sound( "interface/inv_lighter_refiller.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
				client:getChar():getInv():remove(client:getChar():getInv():hasItem("brodyagalox"):getID()) 				
				return false		
			--end
		end
       return false
    end,
    onCanRun = function(item)
        return !IsValid(item.entity)
    end
}
 
function ITEM:getDesc()
	local str
	str = self.desc.." Осталось %s."
	return Format(str, self:getData("tinderboxAmount"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local tinderboxAmount = item:getData("tinderboxAmount", item.tinderboxAmount or 1)
		draw.SimpleText(tinderboxAmount, "nutIconFont", 4, y, Color(255, 255, 255, 255))
	end
end

function ITEM:onInstanced()
	if !self:getData("tinderboxAmount") then
		self:setData("tinderboxAmount", self.tinderboxAmount)
	end
end
