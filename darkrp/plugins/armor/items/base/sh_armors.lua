ITEM.name = "Armor Base"
ITEM.desc = "A armor."
ITEM.category = "armor"
ITEM.isCloth = true
ITEM.model = ''
	if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end
ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	
	onRun = function(item)
		local inv = item.player:getChar():getInv()
		for k, v in pairs(inv:getItems()) do
			if (v.id != item.id) then
				local itemTable = nut.item.instances[v.id]
				if (itemTable.isCloth and itemTable:getData("equip")) then
					item.player:notify("You're already wearing armor")
					item.player:ConCommand("say /actequiparmor")
					return false
				end
			end
		end
		--[[if (item.SetModel == "models/spenser/ssk/outfit/scientific_outfit_merc.mdl" and item.player:GetModel() == "models/spenser/ssk/new_nebo_01_spen.mdl") then
			return false
		end]]
		--[[if (item.Model == "models/stalker/outfit/mili_tactichelm.mdl" and item.player:GetModel() == "models/spenser/ssk/outfit/scientific_outfit_merc.mdl") then
			return false
		end
		]]
		if (item.SetModel == "models/spenser/ssk/new_band_05_spen.mdl") 
		or (item.SetModel == "models/spenser/ssk/new_dolg_04_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_dolg_05_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_free_04_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_free_06_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_merc_02_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_merc_03_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_mono_02_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_nebo_02_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_nebo_04_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_nebo_05_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_renegat_04_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_renegat_05_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_solder_02_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_solder_04_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_solder_04b_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_solder_05_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_solder_06_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_stalk_02a_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_stalk_03_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_stalk_02a_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_mono_01a_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_free_02a_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_dolg_01a_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_dolg_02_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_stalk_04_spen.mdl") then
			item.player:setNetVar("mask1", true) 
		elseif (item.SetModel == "models/spenser/ssk/new_band_06_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_dolg_03_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_ecolog_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_free_05_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_merc_04_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_mono_03_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_stalk_05_spen.mdl") then
			item.player:setNetVar("mask2", true) 
		elseif (item.SetModel == "models/spenser/ssk/new_band_03a_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_dolg_01_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_free_01_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_free_02_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_free_03_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_merc_01a_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_mono_01_spen.mdl")
		or (item.SetModel == "models/spenser/ssk/new_stalk_02_spen.mdl") then
			item.player:setNetVar("mask3", true) 
		end
		
		
		
		local client = item.player
		if (item.player:Team() == FACTION_LONER) then
			if (item.SetModel == "models/spenser/ssk/new_band_05_spen.mdl" 
			or item.SetModel == "models/spenser/ssk/new_dolg_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_free_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_merc_03_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_renegat_05_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_solder_06_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_stalk_04_spen.mdl") then
				item.player:getChar():setModel("models/spenser/ssk/new_stalk_04_spen.mdl")
			else
				item.player:getChar():setModel(item.SetModel)
		end
		elseif (item.player:Team() == FACTION_DUTY) then
			if (item.SetModel == "models/spenser/ssk/new_band_05_spen.mdl" 
			or item.SetModel == "models/spenser/ssk/new_dolg_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_free_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_merc_03_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_renegat_05_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_solder_06_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_stalk_04_spen.mdl") then
				item.player:getChar():setModel("models/spenser/ssk/new_dolg_04_spen.mdl")
			else
				item.player:getChar():setModel(item.SetModel)
			end
		elseif (item.player:Team() == FACTION_FREEDOM) then
			if (item.SetModel == "models/spenser/ssk/new_band_05_spen.mdl" 
			or item.SetModel == "models/spenser/ssk/new_dolg_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_free_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_merc_03_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_renegat_05_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_solder_06_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_stalk_04_spen.mdl") then
				item.player:getChar():setModel("models/spenser/ssk/new_free_04_spen.mdl")
			else
				item.player:getChar():setModel(item.SetModel)
			end
		elseif (item.player:Team() == FACTION_MERCENARIES) then
			if (item.SetModel == "models/spenser/ssk/new_band_05_spen.mdl" 
			or item.SetModel == "models/spenser/ssk/new_dolg_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_free_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_merc_03_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_renegat_05_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_solder_06_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_stalk_04_spen.mdl") then
				item.player:getChar():setModel("models/spenser/ssk/new_merc_03_spen.mdl")
			else
				item.player:getChar():setModel(item.SetModel)
			end
		elseif (item.player:Team() == FACTION_MILITARY) then
			if (item.SetModel == "models/spenser/ssk/new_band_05_spen.mdl" 
			or item.SetModel == "models/spenser/ssk/new_dolg_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_free_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_merc_03_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_renegat_05_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_solder_06_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_stalk_04_spen.mdl") then
				item.player:getChar():setModel("models/spenser/ssk/new_solder_06_spen.mdl")
			else
				item.player:getChar():setModel(item.SetModel)
			end
		elseif (item.player:Team() == FACTION_RENEGAT) then
			if (item.SetModel == "models/spenser/ssk/new_band_05_spen.mdl" 
			or item.SetModel == "models/spenser/ssk/new_dolg_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_free_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_merc_03_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_renegat_05_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_solder_06_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_stalk_04_spen.mdl") then
				item.player:getChar():setModel("models/spenser/ssk/new_renegat_05_spen.mdl")
			else
				item.player:getChar():setModel(item.SetModel)
			end
		elseif (item.player:Team() == FACTION_RAIDERS) then
			if (item.SetModel == "models/spenser/ssk/new_band_05_spen.mdl" 
			or item.SetModel == "models/spenser/ssk/new_dolg_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_free_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_merc_03_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_renegat_05_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_solder_06_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_stalk_04_spen.mdl") then
				item.player:getChar():setModel("models/spenser/ssk/new_band_05_spen.mdl")
			end
		--[[elseif (item.player:Team() == FACTION_CLEARSKY) then
			if (item.SetModel == "models/spenser/ssk/new_band_05_spen.mdl" 
			or item.SetModel == "models/spenser/ssk/new_dolg_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_free_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_merc_03_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_renegat_05_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_solder_06_spen.mdl"
			or item.SetModel == "models/spenser/ssk/new_stalk_04_spen.mdl") then
				item.player:getChar():setModel("models/spenser/ssk/new_nebo_05_spen.mdl")
			else
				item.player:getChar():setModel(item.SetModel)
			end]]
		else
			item.player:getChar():setModel(item.SetModel)
		end
		item.player:EmitSound("weapons/aks74/cloth.wav")
		item.player:ConCommand("say /actequiparmor")
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		item:setData("equip", true)
        item.player:getChar():setData("armored",true)
        if (item.SetModel == "models/spenser/ssk/new_band_03a_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_band_05_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_band_06_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_dolg_01_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_dolg_01a_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_dolg_02_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_dolg_03_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_dolg_04_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_dolg_05_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_ecolog_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_free_01_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_free_02_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_free_02a_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_free_03_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_free_04_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_free_05_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_free_06_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_merc_01a_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_merc_02_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_merc_03_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_merc_04_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_mono_01_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_mono_01a_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_mono_02_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_mono_03_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_mono_04_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_nebo_02_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_nebo_04_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_nebo_05_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_renegat_03_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_renegat_04_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_renegat_05_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_solder_02_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_solder_04b_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_solder_05_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_solder_06_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_stalk_02_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_stalk_03_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_stalk_04_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_stalk_05_spen.mdl" 
		or item.SetModel == "models/spenser/ssk/new_test.mdl" 
		or item.SetModel == "models/spenser/ssk/new_stalk_02a_spen.mdl") then
			item.player:setNetVar("gassound", true)
   		end
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true)
	end
}
ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		item.player:setNetVar("mask1", false)
		item.player:setNetVar("mask2", false)
		item.player:setNetVar("mask3", false)
		item.player:getChar():setModel( nut.faction.indices[item.player:Team()].models[1])
		item.player:EmitSound("weapons/aks74/cloth.wav")
		item:setData("equip", false)
		item.player:getChar():setData("armored",false)
		item.player:setNetVar("gassound", false)
		item.player:ConCommand("say /actequiparmor")
		local client = item.player
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") == true)
	end
}

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	return !self:getData("equip")
end
ITEM.permit = "arm"
