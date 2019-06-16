ITEM.name = "Заряд РС-15"
ITEM.desc = "Самодельное взрывное устройство, полученное из различных химических веществ, забитых в контейнер с металлическими шариками и со сломанным электрическим воспламенителем. Активируется автоматически. \n\nХАРАКТЕРИСТИКИ: \n-взрывоопасно \n-военное изделие \n\nДля активации необходимо выложить"
ITEM.category = "misc"
ITEM.price = 6940
ITEM.exRender = true
ITEM.model = "models/hardbass/bomb_c4.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-0.30000001192093, 0, 200),
	ang = Angle(90, 0, 89.411766052246),
	fov = 4.5
}

ITEM.functions.Use = { 
icon = "icon16/cup.png", 
onRun = function(item) 
local client = item.player
local mine = ents.Create( "mine" )
local data2 = {
start = client:GetShootPos(),
endpos = client:GetShootPos() + client:GetAimVector() * 95,
filter = client
}
local trace = util.TraceLine(data2)
if (!trace.Hit or trace.HitSky) then return false end
local position = trace.HitPos + Vector(0, 0, 0)
mine:SetPos( position )
mine:Spawn()
mine:Activate()
client:EmitSound("physics/flesh/flesh_impact_hard6.wav")
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
end 
}