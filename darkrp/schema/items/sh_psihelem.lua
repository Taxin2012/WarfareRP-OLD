ITEM.name = "Пси-шлем"
ITEM.desc = "Прототип, разработнный учеными для защиты от пси-излучения. Представляет из себя наушники с начинкой, продолжающиеся конструкцией из сетки, покрывающей голову. Размеры позволяют носить его под капюшоном, каской, шлемом и другой экипировкой. \n\nХАРАКТЕРИСТИКИ: \n-важный предмет \n-элемент экипировки \n-не выпадает \n-обеспечивает надежную защиту от источников пси-излучения"
ITEM.price = 38900
ITEM.exRender = true
ITEM.model = "models/psihelem.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(114, 97, 73.963287353516),
	ang = Angle(25, 220, 0),
	fov = 4.4378279506259
}
ITEM.category = "Other"
ITEM.permit = "misc"

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	
	onRun = function(item)
		local inv = item.player:getChar():getInv()
		for k, v in pairs(inv:getItems()) do
			if (v.id != item.id) then
				local itemTable = nut.item.instances[v.id]
				if (itemTable.isCloth and itemTable:getData("equip")) then
					item.player:notify("You're already wearing armor")
					return false
				end
			end
		end
		
		item.player:setNetVar("psihelem", 1)
		item.player:EmitSound("weapons/aks74/cloth.wav")
		item:setData("equip", true)
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true)
	end
}

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		item.player:EmitSound("weapons/aks74/cloth.wav")
		item:setData("equip", false)
		item.player:setNetVar("psihelem", 0)
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") == true)
	end
}

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	return !self:getData("equip")
end
