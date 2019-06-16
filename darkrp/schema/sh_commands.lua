nut.command.add("doorkick", {
	onRun = function(client, arguments)
		if (client:Team() == FACTION_CP) then
			local aimVector = client:GetAimVector()

			local data = {}
				data.start = client:GetShootPos()
				data.endpos = data.start + aimVector*96
				data.filter = client
			local entity = util.TraceLine(data).Entity

			if (IsValid(entity) and entity:GetClass() == "prop_door_rotating") then
				if (client:forceSequence("kickdoorbaton")) then
					timer.Simple(0.75, function()
						if (IsValid(client) and IsValid(entity)) then
							entity:EmitSound("physics/wood/wood_crate_break"..math.random(1, 5)..".wav", 150)
							entity:blastDoor(aimVector * (360 + client:getChar():getAttrib("str", 0)*5))
						end
					end)
				end
			else
				return "@dNotValid"
			end
		else
			return "@mustBeCP"
		end
	end
})