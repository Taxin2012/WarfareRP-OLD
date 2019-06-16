PLUGIN.name = "Item Cleanup"
PLUGIN.author = "Hikka"
PLUGIN.desc = "Cleans up items after a period of time."

if (SERVER) then
	timer.Create( "itemcleanup", 5, 0, function()
		if table.Count(ents.FindByClass( "nut_item" )) > 12 then -- тут ставиш каличество предметов 
			for _, ent in ipairs(ents.FindByClass("nut_item")) do
				ent:Remove()
			end
		end
		if table.Count(ents.FindByClass( "nut_money" )) > 12 then -- тут ставиш каличество предметов 
			for _, ent in ipairs(ents.FindByClass("nut_money")) do
				ent:Remove()
			end
		end
	end)
end

nut.command.add("itemclean", {
	operatorOnly = true,
	onRun = function (client, arguments)
		if (!client:getChar():hasFlags("M")) then return end
		for k, itm in pairs( ents.FindByClass( "nut_item" ) ) do
			itm:Remove()
		end
		for k, mny in pairs( ents.FindByClass( "nut_money" ) ) do
			mny:Remove()
		end
		for k, itm2 in pairs( ents.FindByClass( "nut_item_death" ) ) do
			itm2:Remove()
		end
		client:notify("cleaning_done")
	end
})