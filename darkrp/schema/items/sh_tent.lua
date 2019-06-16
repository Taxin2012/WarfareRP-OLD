ITEM.name = "Палатка"
ITEM.desc = "Брезентовая палатка является широко известным временным сооружение, способным предоставить укрытие от ветра, дождя или пыли. Используемый материал был подвергнут огнеупорной водоотталкивающей и противогнилостной пропитками. \n\nХАРАКТЕРИСТИКИ: \n-повсеместное применение \n-восстанавливает здоровье \n-для установки требуется: матрас, два синтетических каната, лопата"
ITEM.category = "misc"
ITEM.price = 13500
ITEM.exRender = true
ITEM.model = "models/hardbass/item_merger.mdl"
ITEM.width = 3
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(247.01643371582, 207.27139282227, 161.89111328125),
	ang = Angle(25, 220, -96.470588684082),
	fov = 4.9487787075149
}


ITEM.functions.use = { 
	name = "установить палатку",
	tip = "useTip",
	icon = "icon16/drive.png",
	onRun = function(item)
		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)
		
		if (item.player:getChar():getInv():hasItem("twomatras")) then
		if (item.player:getChar():getInv():hasItem("twosincan")) then
		if (item.player:getChar():getInv():hasItem("shovel")) then
		if (trace.HitPos) then
			local printer = ents.Create("nut_tent")
			printer:SetPos(trace.HitPos + trace.HitNormal * 10)
			printer:Spawn()
			item.player:EmitSound( Sound( "interface/inv_put_up_tent.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			
		--[[client:Freeze(true)
		timer.Create("frizitem"..client:UniqueID(),5,1,function()
			client:Freeze(false)
		end)]]
		local ply = item.player
		ply:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		ply:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		
		end
		end
		end
		end
		return false
	end,
	onCanRun = function(item)
		local client = item.player or LocalPlayer()
	end
}

