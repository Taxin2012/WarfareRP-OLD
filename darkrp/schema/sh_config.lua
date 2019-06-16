-- Customize the beep sounds here, before and after voices.
SCHEMA.beepSounds = {}
SCHEMA.beepSounds[FACTION_CP] = {
	on = {
		"",
		""
	},
	off = {
		"",
		""
	}
}
SCHEMA.beepSounds[FACTION_OW] = {
	on = {
		"",
		""
	},
	off = {
		"",
		""
	}
}

-- Sounds play after the player has died.
SCHEMA.deathSounds = {}
SCHEMA.deathSounds[FACTION_RAIDERS] = {
	"pain/die1.ogg",
	"pain/die2.ogg",
	"pain/die3.ogg",
	"pain/die4.ogg"
}
SCHEMA.deathSounds[FACTION_LONER] = {
	"pain/die1.ogg",
	"pain/die2.ogg",
	"pain/die3.ogg",
	"pain/die4.ogg"
}
SCHEMA.deathSounds[FACTION_DUTY] = {
	"pain/die1.ogg",
	"pain/die2.ogg",
	"pain/die3.ogg",
	"pain/die4.ogg"
}
SCHEMA.deathSounds[FACTION_MERCHANTS] = {
	"pain/die1.ogg",
	"pain/die2.ogg",
	"pain/die3.ogg",
	"pain/die4.ogg"
}
SCHEMA.deathSounds[FACTION_FREEDOM] = {
	"pain/die1.ogg",
	"pain/die2.ogg",
	"pain/die3.ogg",
	"pain/die4.ogg"
}
SCHEMA.deathSounds[FACTION_MILITARY] = {
	"pain/die1.ogg",
	"pain/die2.ogg",
	"pain/die3.ogg",
	"pain/die4.ogg"
}
SCHEMA.deathSounds[FACTION_MONOLIT] = {
	"pain/die1.ogg",
	"pain/die2.ogg",
	"pain/die3.ogg",
	"pain/die4.ogg"
}
SCHEMA.deathSounds[FACTION_SCIENTISTS] = {
	"pain/die1.ogg",
	"pain/die2.ogg",
	"pain/die3.ogg",
	"pain/die4.ogg"
}
SCHEMA.deathSounds[FACTION_MERCENARIES] = {
	"pain/die1.ogg",
	"pain/die2.ogg",
	"pain/die3.ogg",
	"pain/die4.ogg"
}
SCHEMA.deathSounds[FACTION_CLEARSKY] = {
	"pain/die1.ogg",
	"pain/die2.ogg",
	"pain/die3.ogg",
	"pain/die4.ogg"
}

-- Sounds the player makes when injured.
SCHEMA.painSounds = {}
SCHEMA.painSounds[FACTION_MILITARY] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}
SCHEMA.painSounds[FACTION_MERCHANTS] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}
SCHEMA.painSounds[FACTION_LONER] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}
SCHEMA.painSounds[FACTION_DUTY] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}
SCHEMA.painSounds[FACTION_FREEDOM] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}
SCHEMA.painSounds[FACTION_SCIENTISTS] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}
SCHEMA.painSounds[FACTION_MERCENARIES] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}
SCHEMA.painSounds[FACTION_CLEARSKY] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}
SCHEMA.painSounds[FACTION_RAIDERS] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}
SCHEMA.painSounds[FACTION_MONOLIT] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}
SCHEMA.painSounds[FACTION_RENEGAT] = {
	"pain/pain1.ogg",
	"pain/pain2.ogg",
	"pain/pain3.ogg",
	"pain/pain4.ogg",
	"pain/pain5.ogg",
	"pain/pain6.ogg",
	"pain/pain7.ogg",
	"pain/pain8.ogg"
}

-- Civil Protection name prefix.
SCHEMA.cpPrefix = "CP-"

-- How long the Combine digits are.
SCHEMA.digitsLen = 5

-- Rank information.
SCHEMA.rctRanks = {"RCT"}
SCHEMA.unitRanks = {"05", "04", "03", "02", "01", "OfC"}
SCHEMA.eliteRanks = {"EpU", "DvL", "SeC"}
SCHEMA.scnRanks = {"SCN", "CLAW.SCN"}

-- What model each rank should be.
SCHEMA.rankModels = {
	["RCT"] = "models/police.mdl",
	[SCHEMA.unitRanks] = "models/dpfilms/metropolice/hl2concept.mdl",
	["OfC"] = "models/dpfilms/metropolice/policetrench.mdl",
	["EpU"] = "models/dpfilms/metropolice/elite_police.mdl",
	["DvL"] = "models/dpfilms/metropolice/blacop.mdl",
	["SeC"] = "models/dpfilms/metropolice/phoenix_police.mdl",
	["SCN"] = "models/combine_scanner.mdl",
	["CLAW.SCN"] = "models/shield_scanner.mdl"
}

-- The default player data when using /data
SCHEMA.defaultData = [[
Points:
Infractions:
]]

-- sh_anims.lua

nut.anim.stalker =
{
	normal = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "norm_torso_0_idle_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_0_aim_0", "cr_torso_0_aim_0"},
		[ACT_MP_WALK] = {"walk_test", "walk_test_a"},
		[ACT_MP_CROUCHWALK] = {"walk_test_cr", "walk_test_cr"},
		[ACT_MP_RUN] = {"run_test_nowep", "run_test_nowep_a"}
	},
	pistol = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_1_idle_0", "norm_torso_1_aim_1"},
		[ACT_MP_CROUCH_IDLE] = {"cr_idle_1_0", "cr_torso_1_aim_0"},
		[ACT_MP_WALK] = {"walk_test_pr", "walk_test_pa"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crp", "walk_test_crp"},
		[ACT_MP_RUN] = {"run_test_pr", "run_test_pa"},
		attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
		reload = ACT_RELOAD_PISTOL
	},
	smg = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_9_idle_0", "norm_torso_2_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_idle_9_0", "cr_torso_8_aim_0"},
		[ACT_MP_WALK] = {"walk_test_gr", "walk_test_ga"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crg", "walk_test_crg"},
		[ACT_MP_RUN] = {"run_test_gr", "run_test_ga"},
		attack = ACT_GESTURE_RANGE_ATTACK_SMG1,
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	shotgun = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_3_idle_0", "norm_torso_3_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_3_aim_0", "cr_torso_3_aim_0"},
		[ACT_MP_WALK] = {"walk_test_sr", "walk_test_sa"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crs", "walk_test_crs"},
		[ACT_MP_RUN] = {"run_test_sr", "run_test_sa"},
		attack = ACT_GESTURE_RANGE_ATTACK_SHOTGUN
	},
	grenade = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_9_idle_0", "norm_torso_9_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_9_aim_0", "cr_torso_9_aim_0"},
		[ACT_MP_WALK] = {"walk_test_shotr", "walk_test_shota"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crg", "walk_test_crg"},
		[ACT_MP_RUN] = {"run_test_shotr", "run_test_shota"},
		attack = ACT_RANGE_ATTACK_THROW
	},
	melee = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_7_aim_0", "norm_torso_7_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_0_aim_0", "cr_torso_0_aim_0"},
		[ACT_MP_WALK] = {"walk_test", "walk_test_a"},
		[ACT_MP_CROUCHWALK] = {"walk_test_cr", "walk_test_cr"},
		[ACT_MP_RUN] = {"run_test_nowep", "run_test_nowep_a"},
		attack = ACT_MELEE_ATTACK_SWING
	},
	glide = ACT_GLIDE,
}

nut.anim.zombie = {
	normal = {
		[ACT_MP_STAND_IDLE] = {"idle_0_idle_"..math.random(0, 4), "idle_0_idle_"..math.random(0, 4)},
		[ACT_MP_WALK] = {"norm_torso_0_walk_0", "norm_torso_0_walk_0"},
	},
	pistol = {
		[ACT_MP_STAND_IDLE] = {"idle_1_idle_"..math.random(0, 4), "norm_torso_1_aim_0"},
		[ACT_MP_WALK] = {"norm_torso_1_walk_0", "norm_torso_1_aim_walk"},
		attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
		reload = ACT_GESTURE_RELOAD_PISTOL
	},
	smg = {
		[ACT_MP_STAND_IDLE] = {"idle_2_idle_"..math.random(0, 4), "norm_torso_2_aim_0"},
		[ACT_MP_WALK] = {"norm_torso_2_walk_0", "norm_torso_2_aim_fwd"},
		attack = ACT_GESTURE_RANGE_ATTACK_SMG1,
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	shotgun = {
		[ACT_MP_STAND_IDLE] = {"idle_3_idle_"..math.random(0, 4), "norm_torso_3_aim_0"},
		[ACT_MP_WALK] = {"norm_torso_3_walk_0", "norm_torso_3_aim_1"},
		attack = ACT_GESTURE_RANGE_ATTACK_SHOTGUN,
		reload = ACT_GESTURE_RELOAD_SHOTGUN
	},
	grenade = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1_RELAXED, "idle_gun_aim_0"},
		[ACT_MP_WALK] = {"norm_torso_2_walk_0", "walk_gun_0"},
		attack = ACT_RANGE_ATTACK_SMG1,
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	melee = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1_RELAXED, "idle_gun_aim_0"},
		[ACT_MP_WALK] = {"norm_torso_2_walk_0", "walk_gun_0"},
		attack = ACT_RANGE_ATTACK_SMG1,
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	glide = ACT_GLIDE
}

nut.anim.izlom = {
	normal = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"}
	},
	pistol = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"},
		attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
		reload = ACT_RELOAD_PISTOL
	},
	smg = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"},
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	shotgun = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"},
		attack = "shoot_shotgun"
	},
	grenade = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"},
		attack = ACT_RANGE_ATTACK_THROW
	},
	melee = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"},
		attack = ACT_MELEE_ATTACK_SWING
	},
	glide = ACT_GLIDE
}

nut.anim.setModelClass("models/spenser/ssk/new_izlom_spen.mdl", "izlom")
--models/tnb/stalker/male_bandit_skat.mdl
nut.anim.setModelClass("models/tnb/stalker/male_bandit_skat.mdl", "player")
nut.anim.setModelClass("models/spenser/ssk/new_zomb_01_spen.mdl", "zombie")
nut.anim.setModelClass("models/spenser/ssk/new_zomb_02_spen.mdl", "zombie")
nut.anim.setModelClass("models/spenser/ssk/new_zomb_03_spen.mdl", "zombie")
nut.anim.setModelClass("models/spenser/ssk/new_zomb_04_spen.mdl", "zombie")
nut.anim.setModelClass("models/spenser/ssk/new_zomb_05_spen.mdl", "zombie")
nut.anim.setModelClass("models/spenser/ssk/new_test.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_dolg_shepard_spen.mdl", "stalker")
nut.anim.setModelClass("models/blagod/ssk/dark_stalker_ssk.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_stalk_01_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_stalk_01a_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_stalk_02_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_stalk_02a_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_stalk_03_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_stalk_04_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_stalk_05_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_band_01_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_band_02_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_band_03_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_band_03a_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_band_04_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_band_05_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_band_06_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_barman_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_dolg_00_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_dolg_01_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_dolg_01a_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_dolg_02_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_dolg_03_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_dolg_04_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_dolg_05_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_ecolog_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_free_00_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_free_01_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_free_02_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_free_02a_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_free_03_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_free_03a_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_free_04_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_free_05_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_free_06_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_merc_01_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_merc_01a_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_merc_02_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_merc_03_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_merc_04_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_mono_01_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_mono_01a_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_mono_02_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_mono_03_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_mono_04_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_nebo_01_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_nebo_02_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_nebo_03_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_nebo_04_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_nebo_05_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_other2_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_renegat_01_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_renegat_02_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_renegat_03_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_renegat_04_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_renegat_05_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_security_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_solder_01_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_solder_02_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_solder_02a_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_solder_03_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_solder_04_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_solder_04a_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_solder_04b_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_solder_05_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_solder_06_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/ssk/new_sviter_spen.mdl", "stalker")