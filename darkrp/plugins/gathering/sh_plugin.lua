PLUGIN.name = "Gathering System"
PLUGIN.author = "DrodA & AleXXX_007"
PLUGIN.desc = "New brand gathering system."

PLUGIN.TreeModels = {
	"models/gm_forest/tree_alder.mdl",
	"models/gm_forest/tree_birch1.mdl",
	"models/gm_forest/tree_commonlinden_1.mdl",
	"models/prop/tree/tree_02.mdl"
}
PLUGIN.tree = {}
PLUGIN.tree["models/gm_forest/tree_alder.mdl"] = {
	hp = math.random(3, 5),
	condition = math.random(3, 5),
	respawntime = math.random(120, 180)
}
PLUGIN.tree["models/gm_forest/tree_birch1.mdl"] = {
	hp = math.random(5, 7),
	condition = math.random(4, 6),
	respawntime = math.random(180, 240)
}
PLUGIN.tree["models/gm_forest/tree_commonlinden_1.mdl"] = {
	hp = math.random(7, 10),
	condition = math.random(7, 8),
	respawntime = math.random(300, 480)
}
PLUGIN.tree["models/prop/tree/tree_02.mdl"] = {
	hp = math.random(4, 6),
	condition = math.random(4, 6),
	respawntime = math.random(150, 200)
}