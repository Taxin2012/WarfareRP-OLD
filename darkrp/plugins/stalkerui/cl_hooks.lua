hook.Add("LoadFonts", "StalkerLoadFonts", function(font, genericFont)
	surface.CreateFont("StalkerMediumFont",
	{
		font = "Myriad Pro",
		size = ScreenScale(9),
		weight = 300,
		antialias = true,
		extended = true
	})

	surface.CreateFont("StalkerSmallFont",
	{
		font = "Myriad Pro",
		size = ScreenScale(9),
		weight = 150,
		antialias = true,
		extended = true
	})
	surface.CreateFont("TitleStalkerBigFont",
	{
		font = "Microsoft Uighur",
		size = ScreenScale(20),
		weight = 550,
		antialias = true,
		extended = true
	})
	surface.CreateFont("NameFactionFont",
	{
		font = "Myriad Arabic",
		size = ScreenScale(9),
		weight = 250,
		antialias = true,
		extended = true
	})
	surface.CreateFont("DescCharFont",
	{
		font = "Myriad Pro",
		size = ScreenScale(7),
		weight = 150,
		antialias = true,
		extended = true
	})
	surface.CreateFont("DescCharFont1",
	{
		font = "Myriad Pro",
		size = ScreenScale(7),
		weight = 150,
		antialias = true,
		extended = true
	})
	surface.CreateFont("DescTipFont",
	{
		font = "Myriad Pro",
		size = ScreenScale(7),
		weight = 150,
		antialias = true,
		extended = true
	})
	surface.CreateFont("NameFactionPingFont",
	{
		font = "Myriad Arabic",
		size = ScreenScale(9),
		weight = 250,
		antialias = true,
		extended = true
	})
	surface.CreateFont("NameFactionFactionFont",
	{
		font = "Myriad Arabic",
		size = ScreenScale(9),
		weight = 250,
		antialias = true,
		extended = true
	})
	surface.CreateFont("BigFontForSafe",
	{
		font = "Graffiti1CTT",
		size = ScreenScale(19),
		weight = 250,
		antialias = true,
		extended = true
	})
	surface.CreateFont("LFontForSafe",
	{
		font = "Graffiti1CTT",
		size = ScreenScale(9),
		weight = 250,
		antialias = true,
		extended = true
	})
	surface.CreateFont("BigFontForWS",
	{
		font = "Graffiti1CTT",
		size = ScreenScale(12),
		weight = 250,
		antialias = true,
		extended = true
	})
	surface.CreateFont("DeadBigFontForSafe",
	{
		font = "Graffiti1CTT",
		size = ScreenScale(32),
		weight = 250,
		antialias = true,
		extended = true
	})
	surface.CreateFont("ChatFontMisery",
	{
		font = "Myriad Pro",
		size = ScreenScale(7),
		weight = 250,
		antialias = true,
		extended = true
	})
	surface.CreateFont("ChatFontMisery1",
	{
		font = "Myriad Pro",
		size = ScreenScale(6),
		weight = 250,
		antialias = true,
		extended = true
	})
end)