local function facingWall(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start + client:GetAimVector()*54
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "@faceWall"
	end
end

local function facingWallBack(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start - client:GetAimVector()*54
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "@faceWallBack"
	end
end

ACT_ENDSEQ = 0
ACT_STARTSEQ = 1

PLUGIN.acts["sit"] = {
	["citizen_male"] = {sequence = "sit_ground", untimed = true, transition = { [ACT_STARTSEQ] = "Idle_to_Sit_Ground", [ACT_ENDSEQ] = "Sit_Ground_to_Idle" }},
	["citizen_female"] = {sequence = "sit_ground", untimed = true},
	["stalker"] = {sequence = "item_2_aim_0", untimed = true}
}
PLUGIN.acts["razdelka"] = {
	["stalker"] = {sequence = "dinamit_0", untimed = false}
}
PLUGIN.acts["equiparmor"] = {
	["stalker"] = {sequence = "equip_bron", untimed = false}
}
PLUGIN.acts["staytable"] = {
	["stalker"] = {sequence = "animpoint_stay_table_idle_rnd_2", untimed = true}
}
PLUGIN.acts["idleweapon"] = {
	["stalker"] = {sequence = "idle_ban_3_0", untimed = true}
}
PLUGIN.acts["rest"] = {
	["stalker"] = {sequence = "cut_scene_actor", untimed = true}
}
PLUGIN.acts["band1"] = {
	["stalker"] = {sequence = "idle_band_4", untimed = true}
}
PLUGIN.acts["actbackweaponup"] = {
	["stalker"] = {sequence = "norm_talk_2_idle_0", untimed = true}
}
PLUGIN.acts["idle0"] = {
	["stalker"] = {sequence = "item_0_idle_0", untimed = true}
}
PLUGIN.acts["guitar"] = {
	["stalker"] = {sequence = "guitar_0", untimed = true}
}
PLUGIN.acts["handup"] = {
	["stalker"] = {sequence = "hand_up_0", untimed = true}
}
PLUGIN.acts["lowsit"] = {
	["stalker"] = {sequence = {"item_1_idle_1", "item_1_idle_3"}, untimed = true}
}
PLUGIN.acts["injured"] = {
	["citizen_male"] = {sequence = {"d1_town05_wounded_idle_1", "d1_town05_wounded_idle_2", "d1_town05_winston_down"}, untimed = true},
	["citizen_female"] = {sequence = "d1_town05_wounded_idle_1", untimed = true},
	["stalker"] = {sequence = "waunded_1_idle_0", untimed = true}
}
PLUGIN.acts["arrest"] = {
	["citizen_male"] = {sequence = "apcarrestidle", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["otzhim"] = {
	["stalker"] = {sequence = "otzhim", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["stoit"] = {
	["stalker"] = {sequence = "stoit", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["koleni"] = {
	["stalker"] = {sequence = "prisoner_0_sit_idle_0", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["backhands"] = {
	["stalker"] = {sequence = "ohrana_0", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["backweaponup"] = {
	["stalker"] = {sequence = "norm_talk_idle_1", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["justsit"] = {
	["stalker"] = {sequence = "item_0_idle_2", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["chest"] = {
	["stalker"] = {sequence = "chest_1", untimed = false, onCheck = facingWall}
}
PLUGIN.acts["prisid"] = {
	["stalker"] = {sequence = "prisyad", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["hidegun"] = {
	["stalker"] = {sequence = "uhodi_1_0", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["stol"] = {
	["stalker"] = {sequence = "bar_idle_2", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["cheer"] = {
	["citizen_male"] = {sequence = {"cheer1", "cheer2", "wave_smg1"}},
	["citizen_female"] = {sequence = {"cheer1", "wave_smg1"}},
	["stalker"] = {sequence = "lead_0_idle_0", untimed = true}
}
PLUGIN.acts["here"] = {
	["citizen_male"] = {sequence = {"wave_close", "wave"}},
	["citizen_female"] = {sequence = {"wave_close", "wave"}},
	["stalker"] = {sequence = "hello_0_idle_0", untimed = true}
}
PLUGIN.acts["sitwall"] = {
	["citizen_male"] = {sequence = {"plazaidle4", "injured1"}, untimed = true, onCheck = facingWallBack},
	["citizen_female"] = {sequence = {"plazaidle4", "injured1", "injured2"}, untimed = true, onCheck = facingWallBack}
}
PLUGIN.acts["stand"] = {
	["citizen_male"] = {sequence = {"lineidle01", "lineidle02", "lineidle03", "lineidle04"}, untimed = true},
	["citizen_female"] = {sequence = {"lineidle01", "lineidle02", "lineidle03"}, untimed = true},
	["metrocop"] = {sequence = "plazathreat2", untimed = true},
	["stalker"] = {sequence = "cut_scene_idle_0", untimed = true}
}