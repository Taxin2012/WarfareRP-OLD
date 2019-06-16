ITEM.name = "Губная гармошка"
ITEM.category = "Разное"
ITEM.desc = "Для любителей блюза и тюремной романтики. \n\nХАРАКТЕРИСТИКИ: \n-повсеместное применение"
ITEM.model = Model("models/hgn/srp/items/harmonica.mdl")

ITEM.functions.anik = { -- sorry, for name order.
	name = "Сыграть",
	tip = "useTip",
	icon = "icon16/music.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound( Sound( "harmonica/harmonica_"..math.random(1, 5)..".ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			ply.timesay = CurTime() + 60
			ply:ConCommand( "say /actharm" )
		end
		return false
	end,
}

ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(91.65096282959, 76.979270935059, 55.902381896973),
	ang = Angle(25, 220, 0),
	fov = 4
}
ITEM.price = 3520
