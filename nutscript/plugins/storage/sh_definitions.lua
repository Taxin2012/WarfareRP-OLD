--[[
	PLUGIN.definitions[model's name(lowercase)] = {
		name = "Crate",
		desc = "A simple wooden create.",
		width = 4,
		height = 4,
		locksound = "",
		opensound = "",
	}
--]]

PLUGIN.definitions["models/z-o-m-b-i-e/st/equipment_cache/st_equipment_box_01.mdl"] = {
	name = "Железный ящик",
	desc = "Железный, синий металлический ящик, используется для хранения предметов.",
	width = 6,
	height = 6,
}

PLUGIN.definitions["models/z-o-m-b-i-e/st/shkaf/st_seif_02.mdl"] = {
	name = "Большой сейф",
	desc = "Большой, ржавый сейф, используется для хранения предметов.",
	width = 7,
	height = 10,
}

PLUGIN.definitions["models/maver1k_xvii/stalker/props/box/box_1a.mdl"] = {
	name = "Деревянный ящик",
	desc = "Маленький, деревянный ящик.",
	width = 2,
	height = 2,
}

PLUGIN.definitions["models/z-o-m-b-i-e/st/equipment_cache/st_equipment_seif_04.mdl"] = {
	name = "Маленький сейф",
	desc = "Маленький сейф для хранения предметов, огнеупорный.",
	width = 2,
	height = 4,
}
PLUGIN.definitions["models/props_c17/furniturefridge001a.mdl"] = {
	name = "Refrigerator",
	desc = "A metal box for keeping food in.",
	width = 2,
	height = 3,
}

PLUGIN.definitions["models/props_wasteland/kitchen_fridge001a.mdl"] = {
	name = "Large Refrigerator",
	desc = "A large metal box for storing even more food in.",
	width = 4,
	height = 5,
}
PLUGIN.definitions["models/props_junk/trashbin01a.mdl"] = {
	name = "Trash Bin",
	desc = "What do you expect to find in here?",
	width = 1,
	height = 2,
}

PLUGIN.definitions["models/tnb/props/footlocker1.mdl"] = {
	name = "Маленький железные ящик",
	desc = "Железный, синий металлический ящик, используется для хранения предметов.",
	width = 6,
	height = 6,
}

PLUGIN.definitions["models/tnb/props/safe1.mdl"] = {
	name = "Сейф",
	desc = "Большой железный сейя для хранения предметов.",
	width = 7,
	height = 10,
}

PLUGIN.definitions["models/items/ammocrate_smg1.mdl"] = {
	name = "Ammo Crate",
	desc = "A heavy crate that stores ammo",
	width = 5,
	height = 3,
	onOpen = function(entity, activator)
		local seq = entity:LookupSequence("Close")
		entity:ResetSequence(seq)

		timer.Simple(2, function()
			if (entity and IsValid(entity)) then
				local seq = entity:LookupSequence("Open")
				entity:ResetSequence(seq)
			end
		end)
	end,
}
