local PLUGIN = PLUGIN;

PLUGIN.name = "Emote Moods";
PLUGIN.author = "OA: Spencer Sharkey, NS: DrodA";
PLUGIN.desc = "With this plugin, characters can set their mood to a preset from predefined values. [Beware! Bugs!]";
PLUGIN.PersonalityTypes =
{
	"Стандарт",
	"Руки в карманы"
};

PLUGIN.LookupTable = {};
PLUGIN.LookupTable[ "Руки в карманы" ] =
{ 
	["idle"] = "idle_band_1",
	["walk"] = "walk_band",
	["normal"] = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "norm_torso_0_idle_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_0_aim_0", "cr_torso_0_aim_0"},
		[ACT_MP_WALK] = {"walk_test", "walk_test_a"},
		[ACT_MP_CROUCHWALK] = {"walk_test_cr", "walk_test_cr"},
		[ACT_MP_RUN] = {"run_test_nowep", "run_test_nowep_a"}
	},
	["pistol"] = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_1_idle_0", "norm_torso_1_aim_1"},
		[ACT_MP_CROUCH_IDLE] = {"cr_idle_1_0", "cr_torso_1_aim_0"},
		[ACT_MP_WALK] = {"walk_test_pr", "walk_test_pa"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crp", "walk_test_crp"},
		[ACT_MP_RUN] = {"run_test_pr", "run_test_pa"},
		attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
		reload = ACT_RELOAD_PISTOL
	},
	["smg"] = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_9_idle_0", "norm_torso_2_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_idle_9_0", "cr_torso_8_aim_0"},
		[ACT_MP_WALK] = {"walk_test_gr", "walk_test_ga"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crg", "walk_test_crg"},
		[ACT_MP_RUN] = {"run_test_gr", "run_test_ga"},
		attack = ACT_GESTURE_RANGE_ATTACK_SMG1,
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	["shotgun"] = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_3_idle_0", "norm_torso_3_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_3_aim_0", "cr_torso_3_aim_0"},
		[ACT_MP_WALK] = {"walk_test_sr", "walk_test_sa"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crs", "walk_test_crs"},
		[ACT_MP_RUN] = {"run_test_sr", "run_test_sa"},
		attack = ACT_GESTURE_RANGE_ATTACK_SHOTGUN
	},
	["grenade"] = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_9_idle_0", "norm_torso_9_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_9_aim_0", "cr_torso_9_aim_0"},
		[ACT_MP_WALK] = {"walk_test_shotr", "walk_test_shota"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crg", "walk_test_crg"},
		[ACT_MP_RUN] = {"run_test_shotr", "run_test_shota"},
		attack = ACT_RANGE_ATTACK_THROW
	},
	["melee"] = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_7_aim_0", "norm_torso_7_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_0_aim_0", "cr_torso_0_aim_0"},
		[ACT_MP_WALK] = {"walk_test", "walk_test_a"},
		[ACT_MP_CROUCHWALK] = {"walk_test_cr", "walk_test_cr"},
		[ACT_MP_RUN] = {"run_test_nowep", "run_test_nowep_a"},
		attack = ACT_MELEE_ATTACK_SWING
	},
	["glide"] = ACT_GLIDE
};

function PLUGIN:GetPlayerMood(client)
	if (client:getNetVar("emoteMood") ~= "") then
		return client:getNetVar("emoteMood");
	end;

	return false;
end;

local weaponWhiteList =
{
	["nut_keys"] = true
};

hook.Add("CalcMainActivity", "OverrideNSCrapHooks", function(client, velocity)
	if (PLUGIN:GetPlayerMood(client) and PLUGIN:GetPlayerMood(client) ~= "Стандарт" and weaponWhiteList[client:GetActiveWeapon():GetClass()]) then
		local getMood = PLUGIN:GetPlayerMood(client);
		local moodTable = PLUGIN.LookupTable[getMood];
		local getClientModel = client:GetModel();

		client.CalcSeqOverride = -1;

		if (!GAMEMODE:HandlePlayerDriving(client) and !GAMEMODE:HandlePlayerJumping(client) and !GAMEMODE:HandlePlayerDucking(client, velocity) and !GAMEMODE:HandlePlayerSwimming(client)) then
			if (velocity:Length2D() < 0.5) then
				client.CalcSeqOverride = moodTable["idle"];
			elseif (velocity:Length2D() >= 0.5 and !client:isRunning()) then
				if (moodTable["walk"] ~= nil) then
					client.CalcSeqOverride = moodTable["walk"]
				end;
			end;
		end;

		if (client.CalcSeqOverride ~= -1) then
			client.CalcSeqOverride = client:LookupSequence(client.CalcSeqOverride);

			return client.CalcIdeal, client.CalcSeqOverride;
		end;
	end;
end);

nut.command.add("setmood",
{
	syntax = "<string moodType>",
	onRun = function(client, arguments)
		if client:isCombine() or client:isFemale() then return end;

		if (table.HasValue(PLUGIN.PersonalityTypes, arguments[1])) then
			client:setNetVar("emoteMood", arguments[1]);
		else
			client:notify("That is not a valid mood!");
		end;
	end;
});

if (CLIENT) then
	hook.Add("BuildHelpMenu", "MoodsBasicHelp", function(tabs)
		tabs["Moods"] = function(node)
			local body = "<h1>Gesture list</h1>"

			for k, v in pairs(PLUGIN.PersonalityTypes) do
				body = (body..[[<b>%s</b><br>]]):format(v);
			end;

			return body;
		end;
	end);
end;