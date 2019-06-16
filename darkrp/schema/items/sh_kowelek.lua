ITEM.name = "Кошелек"
ITEM.desc = "Используется для хранения значительного количества денег. \n\nХАРАКТЕРИСТИКИ: \n-повсеместное применение \n-используется для: хранения денег \n-не выпадает"
ITEM.category = "misc"
ITEM.price = 3221
ITEM.exRender = true
ITEM.model = "models/hardbass/kowel.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, -90),
	fov = 2.5
}

ITEM.functions.Use = { 
sound = "interface/money_"..math.random(1, 2)..".ogg",
icon = "icon16/cup.png", 
onRun = function(item) 
if (item.player:getChar():hasMoney(5000)) then
	item.player:getChar():takeMoney(5000)
	item:setData("money", 5000)
	item.player:getChar():getInv():add("5000r")
	return false
end
if (item.player:getChar():hasMoney(1000)) then
	item.player:getChar():takeMoney(1000)
	item:setData("money", 1000)
	item.player:getChar():getInv():add("1000r")
	return false
end
if (item.player:getChar():hasMoney(500)) then
	item.player:getChar():takeMoney(500)
	item:setData("money", 500)
	item.player:getChar():getInv():add("500r")
	return false
end
if (item.player:getChar():hasMoney(100)) then
	item.player:getChar():takeMoney(100)
	item:setData("money", 100)
	item.player:getChar():getInv():add("100r")
	return false
end
if (item.player:getChar():hasMoney(50)) then
	item.player:getChar():takeMoney(50)
	item:setData("money", 50)
	item.player:getChar():getInv():add("50r")
	return false
end
if (item.player:getChar():hasMoney(10)) then
	item.player:getChar():takeMoney(10)
	item:setData("money", 10)
	item.player:getChar():getInv():add("10r")
	return false
end
	return false
end 
}