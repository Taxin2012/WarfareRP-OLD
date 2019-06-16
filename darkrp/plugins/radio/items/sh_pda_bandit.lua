﻿ITEM.name = "DEL"
ITEM.model = "models/stalker/item/handhelds/pda.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Communication"
ITEM.price = 5800
ITEM.permit = "elec"
ITEM.iconCam = {
pos = Vector(185, 155.1947479248, 113.36277008057),
fov = 3,
ang = Angle(25, 220, 0)
}

function ITEM:getDesc()
	local str
	
	if (!self.entity or !IsValid(self.entity)) then
		str = "\nPower: %s\nFrequency: %s"
		return Format(str, (self:getData("power") and "On" or "Off"), self:getData("freq", "000.0"))
	else
		local data = self.entity:getData()
		
		str = "%s Frequency: %s"
		return Format(str, (self.entity:getData("power") and "On" or "Off"), self.entity:getData("freq", "000.0"))
	end
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("power", false)) then
			surface.SetDrawColor(110, 255, 110, 100)
		else
			surface.SetDrawColor(255, 110, 110, 100)
		end

		surface.DrawRect(w - 14, h - 14, 8, 8)
	end

	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	local COLOR_ACTIVE = Color(0, 255, 0)
	local COLOR_INACTIVE = Color(255, 0, 0)

	function ITEM:drawEntity(entity, item)
		entity:DrawModel()
		local rt = RealTime()*100
		local position = entity:GetPos() + entity:GetForward() * 0 + entity:GetUp() * 2 + entity:GetRight() * 0

		if (entity:getData("power", false) == true) then
			if (math.ceil(rt/14)%10 == 0) then
				render.SetMaterial(GLOW_MATERIAL)
				render.DrawSprite(position, rt % 14, rt % 14, entity:getData("power", false) and COLOR_ACTIVE or COLOR_INACTIVE)
			end
		end
	end
end

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.toggle = { -- sorry, for name order.
	name = "Toggle",
	tip = "useTip",
	icon = "icon16/wrench.png",
	onRun = function(item)
		item:setData("power", !item:getData("power", false), player.GetAll(), false, true)
		item.player:EmitSound("buttons/button14.wav", 70, 150)

		return false
	end,
}

ITEM.functions.use = { -- sorry, for name order.
	name = "Freq",
	tip = "useTip",
	icon = "icon16/wrench.png",
	onRun = function(item)
		netstream.Start(item.player, "radioAdjust", item:getData("freq", "000,0"), item.id)

		return false
	end,
}

ITEM.functions.misli = { -- sorry, for name order.
	name = "Мысли",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
			item.player:EmitSound("zona/stalker/bandit/states/idle/idle_"..math.random(1, 35)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.anik = { -- sorry, for name order.
	name = "Анекдот",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then

		item.player:EmitSound("zona/stalker/bandit/talk/jokes/joke_"..math.random(1, 9)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.atak = { -- sorry, for name order.
	name = "Атака",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/fight/attack/attack_"..math.random(1, 9)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.wait = { -- sorry, for name order.
	name = "Осмотреться",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/fight/post_combat_wait/wait_"..math.random(1, 5)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.good = { -- sorry, for name order.
	name = "Хороший лут",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/states/loot/loot_good_"..math.random(1, 3)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.begin = { -- sorry, for name order.
	name = "Обыск трупа",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/states/loot/loot_begin_"..math.random(1, 3)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.bad = { -- sorry, for name order.
	name = "Плохой лут",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/states/loot/loot_bad_"..math.random(1, 3)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.hi = { -- sorry, for name order.
	name = "Привет",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/states/meet/meet_hello_"..math.random(1, 3)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.hide = { -- sorry, for name order.
	name = "Спрячь оружие",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/states/meet/meet_hide_weapon_"..math.random(1, 3)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.rejoke = { -- sorry, for name order.
	name = "Реакция на шутку",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/reactions/joke/reaction_joke_"..math.random(1, 3)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.smex = { -- sorry, for name order.
	name = "Смех",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/reactions/story/laughter_"..math.random(1, 7)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.kozlina = { -- sorry, for name order.
	name = "Получай козлина!!!",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/fight/cover_fire/cover_fire_"..math.random(1, 6)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.obxod = { -- sorry, for name order.
	name = "Обходим!",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then		
		item.player:EmitSound("zona/stalker/bandit/fight/detour/detour_"..math.random(1, 10)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.vishu = { -- sorry, for name order.
	name = "Вижу противника",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
				local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/fight/enemy/enemy_"..math.random(1, 12)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.boy = { -- sorry, for name order.
	name = "Бой окончен",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
				local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/fight/post_combat_wait/relax_"..math.random(1, 3)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.search = { -- sorry, for name order.
	name = "Поиск противника",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
				local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/fight/searching_enemy/search_"..math.random(1, 18)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.killed = { -- sorry, for name order.
	name = "Союзник убит",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
				local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/fight/tolls/tolls_"..math.random(1, 5)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.ranen = { -- sorry, for name order.
	name = "Я ранен, помогите!",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
				local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/help/wounded_heavy/help_"..math.random(1, 7)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.medkit = { -- sorry, for name order.
	name = "Держи аптечку",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
				local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/help/wounded/medkit_"..math.random(1, 3)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}

ITEM.functions.ty = { -- sorry, for name order.
	name = "Спасибо",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
				local ply = item.player
		if (!ply.timesay or ply.timesay < CurTime()) then
		item.player:EmitSound("zona/stalker/bandit/help/wounded_thanx/thanx_"..math.random(1, 3)..".ogg")
			ply.timesay = CurTime() + 15
		end
		return false
	end,
}