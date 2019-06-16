ITEM.name = "Мультитопливная печь"
ITEM.desc = "Печь прошла тщательное тестирование в полевых условиях и была использована в бесчисленном множестве экспедиций в течении многих лет. Она невероятно прочная, надежная и мощная. Работает в самых сложных и суровых условиях: как на огромных высотах, так и при экстремальных температурах. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-высококачественное изделие \n-используется для: приготовления мясо мутантов \n-для использования требуется: зажигалка, керосин, либо канистра бензина"
ITEM.price = 9385
ITEM.exRender = true
ITEM.model = "models/spenser/ssk/item_misery/cooking_mfs.mdl"
ITEM.width = 2
ITEM.height = 1
--ITEM.gasplateAmount = 20
ITEM.iconCam = {
	pos = Vector(161.74397277832, 133.57247924805, 100.32518768311),
	ang = Angle(25, 220, 23.529411315918),
	fov = 4
}

ITEM.functions.Campfire = { -- sorry, for name order.
	name = "Приготовить",
	icon = "icon16/fire.png",
	onRun = function(item)
		local client = item.player
		local items = client:getChar():getInv()
		local trace = client:GetEyeTraceNoCursor()
		--local itemTable = nut.item.instances[v.id] 
if (item.player:getChar():getInv():hasItem("tinderbox")) then
--
if (item.player:getChar():getInv():hasItem("fooddrop1")) then
if (!client.usetime or client.usetime < CurTime()) then
		if trace.HitPos:Distance( client:GetShootPos() ) <= 9999999 then
			-------------------------------------
			if (trace.HitPos) then
				local items = client:getChar():getInv():hasItem("kerosin")
				
				if (items) then
					----
					local inv = client:getChar():getInv() 
						for k, v in pairs(inv:getItems()) do 
						local itemTable = nut.item.instances[v.id] 
						if (itemTable:getData("kerosinAmount", 0) > 0) then 
							itemTable:setData("kerosinAmount", itemTable:getData("kerosinAmount", 0) - 1) 
							item.player:getChar():getInv():add("fooddropcook2") 
							client:getChar():getInv():remove(client:getChar():getInv():hasItem("fooddrop1"):getID()) 
							
							item.player:Freeze(true)
							timer.Create("frizitem"..item.player:UniqueID(),5,1,function()
								item.player:Freeze(false)
							end)
							item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
							timer.Simple(1,function()
								item.player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
							end)
							item.player:EmitSound("interface/inv_cooking.ogg")
						else 
						--item.player:notify("Керосин кончился") 
						end 
					end 

					----
				else
					--client:notify("У вас нет керосина!")
					return false
				end
			end
			--------------------------------
		else
			--client:notify("Вы не можете разжечь костер так далеко!")
			return false
		end
	client.usetime = CurTime() + 1
	return false
end
end

if (item.player:getChar():getInv():hasItem("fooddrop2")) then
if (!client.usetime or client.usetime < CurTime()) then
		if trace.HitPos:Distance( client:GetShootPos() ) <= 9999999 then
			-------------------------------------
			if (trace.HitPos) then
				local items = client:getChar():getInv():hasItem("kerosin")
				
				if (items) then
					----
					local inv = client:getChar():getInv() 
						for k, v in pairs(inv:getItems()) do 
						local itemTable = nut.item.instances[v.id] 
						if (itemTable:getData("kerosinAmount", 0) > 0) then 
							itemTable:setData("kerosinAmount", itemTable:getData("kerosinAmount", 0) - 1) 
							item.player:getChar():getInv():add("fooddropcook1") 
							client:getChar():getInv():remove(client:getChar():getInv():hasItem("fooddrop2"):getID()) 
							item.player:Freeze(true)
							timer.Create("frizitem"..item.player:UniqueID(),5,1,function()
								item.player:Freeze(false)
							end)
							item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
							timer.Simple(1,function()
								item.player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
							end)
							item.player:EmitSound("interface/inv_cooking.ogg")
						else 
						--item.player:notify("Керосин кончился") 
						end 
					end 

					----
				else
					--client:notify("У вас нет керосина!")
					return false
				end
			end
			--------------------------------
		else
			--client:notify("Вы не можете разжечь костер так далеко!")
			return false
		end
	client.usetime = CurTime() + 1
	return false
end
end

if (item.player:getChar():getInv():hasItem("fooddrop3")) then
if (!client.usetime or client.usetime < CurTime()) then
		if trace.HitPos:Distance( client:GetShootPos() ) <= 9999999 then
			-------------------------------------
			if (trace.HitPos) then
				local items = client:getChar():getInv():hasItem("kerosin")
				
				if (items) then
					----
					local inv = client:getChar():getInv() 
						for k, v in pairs(inv:getItems()) do 
						local itemTable = nut.item.instances[v.id] 
						if (itemTable:getData("kerosinAmount", 0) > 0) then 
							itemTable:setData("kerosinAmount", itemTable:getData("kerosinAmount", 0) - 1) 
							item.player:getChar():getInv():add("fooddropcook3") 
							client:getChar():getInv():remove(client:getChar():getInv():hasItem("fooddrop3"):getID()) 
							item.player:Freeze(true)
							timer.Create("frizitem"..item.player:UniqueID(),5,1,function()
								item.player:Freeze(false)
							end)
							item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
							timer.Simple(1,function()
								item.player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
							end)
							item.player:EmitSound("interface/inv_cooking.ogg")
						else 
						--item.player:notify("Керосин кончился") 
						end 
					end 

					----
				else
					--client:notify("У вас нет керосина!")
					return false
				end
			end
			--------------------------------
		else
			--client:notify("Вы не можете разжечь костер так далеко!")
			return false
		end
	client.usetime = CurTime() + 1
	return false
end
end

if (item.player:getChar():getInv():hasItem("fooddrop4")) then
if (!client.usetime or client.usetime < CurTime()) then
		if trace.HitPos:Distance( client:GetShootPos() ) <= 9999999 then
			-------------------------------------
			if (trace.HitPos) then
				local items = client:getChar():getInv():hasItem("kerosin")
				
				if (items) then
					----
					local inv = client:getChar():getInv() 
						for k, v in pairs(inv:getItems()) do 
						local itemTable = nut.item.instances[v.id] 
						if (itemTable:getData("kerosinAmount", 0) > 0) then 
							itemTable:setData("kerosinAmount", itemTable:getData("kerosinAmount", 0) - 1) 
							item.player:getChar():getInv():add("fooddropcook4") 
							client:getChar():getInv():remove(client:getChar():getInv():hasItem("fooddrop4"):getID()) 
							item.player:Freeze(true)
							timer.Create("frizitem"..item.player:UniqueID(),5,1,function()
								item.player:Freeze(false)
							end)
							item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
							timer.Simple(1,function()
								item.player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
							end)
							item.player:EmitSound("interface/inv_cooking.ogg")
						else 
						--item.player:notify("Керосин кончился") 
						end 
					end 

					----
				else
					--client:notify("У вас нет керосина!")
					return false
				end
			end
			--------------------------------
		else
			--client:notify("Вы не можете разжечь костер так далеко!")
			return false
		end
	client.usetime = CurTime() + 1
	return false
end
end

if (item.player:getChar():getInv():hasItem("fooddrop5")) then
if (!client.usetime or client.usetime < CurTime()) then
		if trace.HitPos:Distance( client:GetShootPos() ) <= 9999999 then
			-------------------------------------
			if (trace.HitPos) then
				local items = client:getChar():getInv():hasItem("kerosin")
				
				if (items) then
					----
					local inv = client:getChar():getInv() 
						for k, v in pairs(inv:getItems()) do 
						local itemTable = nut.item.instances[v.id] 
						if (itemTable:getData("kerosinAmount", 0) > 0) then 
							itemTable:setData("kerosinAmount", itemTable:getData("kerosinAmount", 0) - 1) 
							item.player:getChar():getInv():add("fooddropcook5") 
							client:getChar():getInv():remove(client:getChar():getInv():hasItem("fooddrop5"):getID()) 
							item.player:Freeze(true)
							timer.Create("frizitem"..item.player:UniqueID(),5,1,function()
								item.player:Freeze(false)
							end)
							item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
							timer.Simple(1,function()
								item.player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
							end)
							item.player:EmitSound("interface/inv_cooking.ogg")
						else 
						--item.player:notify("Керосин кончился") 
						end 
					end 

					----
				else
					--client:notify("У вас нет керосина!")
					return false
				end
			end
			--------------------------------
		else
			--client:notify("Вы не можете разжечь костер так далеко!")
			return false
		end
	client.usetime = CurTime() + 1
	return false
end
end

if (item.player:getChar():getInv():hasItem("fooddrop6")) then
if (!client.usetime or client.usetime < CurTime()) then
		if trace.HitPos:Distance( client:GetShootPos() ) <= 9999999 then
			-------------------------------------
			if (trace.HitPos) then
				local items = client:getChar():getInv():hasItem("kerosin")
				
				if (items) then
					----
					local inv = client:getChar():getInv() 
						for k, v in pairs(inv:getItems()) do 
						local itemTable = nut.item.instances[v.id] 
						if (itemTable:getData("kerosinAmount", 0) > 0) then 
							itemTable:setData("kerosinAmount", itemTable:getData("kerosinAmount", 0) - 1) 
							item.player:getChar():getInv():add("fooddropcook6") 
							client:getChar():getInv():remove(client:getChar():getInv():hasItem("fooddrop6"):getID()) 
							item.player:Freeze(true)
							timer.Create("frizitem"..item.player:UniqueID(),5,1,function()
								item.player:Freeze(false)
							end)
							item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
							timer.Simple(1,function()
								item.player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
							end)
							item.player:EmitSound("interface/inv_cooking.ogg")
						else 
						--item.player:notify("Керосин кончился") 
						end 
					end 

					----
				else
					--client:notify("У вас нет керосина!")
					return false
				end
			end
			--------------------------------
		else
			--client:notify("Вы не можете разжечь костер так далеко!")
			return false
		end
	client.usetime = CurTime() + 1
	return false
end
end

end
	return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
