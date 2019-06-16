ITEM.name = "Украинский журнал PlayBoy"
ITEM.desc = "Глянцевый журнал с красивыми славянскими девушками, на развороте Джоанна Крупа - звезда месяца. Довольно популятная находка среди сталкеров, которые нуждаются в психологической поддержке. На сентиментальные сталкеры используеют его лишь как топливо для печки. \n\nХАРАКТЕРИСТИКИ: \n-повсеместное применение"
ITEM.model = "models/porn.mdl"
ITEM.category = "misc"
ITEM.price = 453
ITEM.exRender = true

ITEM.functions.View = {
	name = "Осмотреть",
	icon = "icon16/map.png",
	onClick = function(item)
		local frame = vgui.Create("DFrame")
		frame:SetSize(480, 576)
		frame:SetTitle(item.name)
		frame:MakePopup()
		frame:Center()
		frame.html = frame:Add("DHTML")
		frame.html:Dock(FILL)
		frame.html:SetHTML([[<html>
			<body style="background-color: #ECECEC; color: #282B2D; font-family: 'Book Antiqua', Palatino, 'Palatino Linotype', 'Palatino LT STD', Georgia, serif; font-size 16px; text-align: justify;">
				<center>
				 <img src="https://proxy10.online.ua/news/r2-1025e3ebba/4bbdad5b7401c.jpg"></img>
				</center>
			</body>
		</html>]])
	end,
	onRun = function(item)
		item.player:EmitSound("interface/inv_properties.ogg")
		return false
	end
}
ITEM.model = "models/hardbass/porn2.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(1, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2.8
}
