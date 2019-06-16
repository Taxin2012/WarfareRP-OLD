nut.chat = nut.chat or {}
nut.chat.classes = nut.char.classes or {}

local DUMMY_COMMAND = {syntax = "<string text>", onRun = function() end}

if (!nut.command) then
	include("sh_command.lua")
end

-- Registers a new chat type with the information provided.
function nut.chat.register(chatType, data)
	if (!data.onCanHear) then
		-- Have a substitute if the canHear property is not found.
		data.onCanHear = function(speaker, listener)
			-- The speaker will be heard by everyone.
			return true
		end
	elseif (type(data.onCanHear) == "number") then
		-- Use the value as a range and create a function to compare distances.
		local range = data.onCanHear ^ 2

		data.onCanHear = function(speaker, listener)
			-- Length2DSqr is faster than Length2D, so just check the squares.
			return (speaker:GetPos() - listener:GetPos()):Length2DSqr() <= range
		end
	end

	-- Allow players to use this chat type by default.
	if (!data.onCanSay) then
		data.onCanSay = function(speaker, text)
			if (!data.deadCanChat and !speaker:Alive()) then
				speaker:notifyLocalized("noPerm")

				return false
			end

			return true
		end
	end

	-- Chat text color.
	data.color = data.color or Color(242, 230, 160)

	if (!data.onChatAdd) then
		data.format = data.format or "%s: \"%s\""
		
		data.onChatAdd = function(speaker, text, anonymous)
		
				local icon = "ui/rad224.png"

				if (speaker:SteamID() == "STEAM_0:0:62768393") then
					icon = "ui/chatbox8.png"
				elseif (speaker:SteamID() == "STEAM_0:1:37001977") then
					icon = "ui/vitya.png"
				elseif (speaker:SteamID() == "STEAM_0:0:69572899") then
					icon = "ui/n7.png"
				--elseif (speaker:Team() == FACTION_MONOLIT) then
					--icon = "ui/actor_1.png"
				elseif (speaker:Team() == FACTION_LONER) then
					icon = "ui/chatbox5.png"
				elseif (speaker:Team() == FACTION_MERCENARIES) then
					icon = "ui/charbox4.png"
				elseif (speaker:Team() == FACTION_FREEDOM) then
					icon = "ui/chatbox3.png"
				elseif (speaker:Team() == FACTION_DUTY) then
					icon = "ui/chatbox2.png"
				--elseif (speaker:Team() == FACTION_CLEARSKY) then
					--icon = "ui/actor_2.png"
				elseif (speaker:Team() == FACTION_RAIDERS) then
					icon = "ui/chatbox1.png"
				elseif (speaker:Team() == FACTION_ZOMB) then
					icon = "ui/charbox5.png"
				elseif (speaker:Team() == FACTION_MILITARY) then
					icon = "ui/chatbox4.png"
				end
				
				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)
				
			local color = data.color
			local name = anonymous and L"someone" or hook.Run("GetDisplayedName", speaker, chatType) or (IsValid(speaker) and speaker:Name() or "Console")

			if (data.onGetColor) then
				color = data.onGetColor(speaker, text)
			end

			local translated = L2(chatType.."Format", name, text)
			
			local format = "%X"
			local date = os.date(format, nut.date.get())
	--chat.AddText(icon, Color(192, 192, 192), "", date.." Глобальный НОН-РП чат:                                                                                                    ", color_white, speaker:Name()..": "..text)
			chat.AddText(icon, "", color_white, date, Color(192, 192, 192), " Сообщение от ", Color(255, 140, 0), speaker:Name(), color_white, ": "..text, "                                                                                                                                 ")
		end
	end

	if (CLIENT) then
		if (type(data.prefix) == "table") then
			for k, v in ipairs(data.prefix) do
				if (v:sub(1, 1) == "/") then
					nut.command.add(v:sub(2), DUMMY_COMMAND)
				end
			end
		else
			nut.command.add(chatType, DUMMY_COMMAND)
		end
	end

	data.filter = data.filter or "ic"

	-- Add the chat type to the list of classes.
	nut.chat.classes[chatType] = data
end

-- Identifies which chat mode should be used.
function nut.chat.parse(client, message, noSend)
	local anonymous = false
	local chatType = "ic"

	-- Handle anonymous/unknown speaker chat.
	if (message:sub(1, 1) == "?" and message:sub(2):find("%S")) then
		anonymous = true
		message = message:sub(2)
	end

	-- Loop through all chat classes and see if the message contains their prefix.
	for k, v in pairs(nut.chat.classes) do
		local isChosen = false
		local chosenPrefix = ""
		local noSpaceAfter = v.noSpaceAfter

		-- Check through all prefixes if the chat type has more than one.
		if (type(v.prefix) == "table") then
			for _, prefix in ipairs(v.prefix) do
				-- Checking if the start of the message has the prefix.
				if (message:sub(1, #prefix + (noSpaceAfter and 0 or 1)):lower() == prefix..(noSpaceAfter and "" or " "):lower()) then
					isChosen = true
					chosenPrefix = prefix..(v.noSpaceAfter and "" or " ")

					break
				end
			end
		-- Otherwise the prefix itself is checked.
		elseif (type(v.prefix) == "string") then
			isChosen = message:sub(1, #v.prefix + (noSpaceAfter and 1 or 0)):lower() == v.prefix..(noSpaceAfter and "" or " "):lower()
			chosenPrefix = v.prefix..(v.noSpaceAfter and "" or " ")
		end

		-- If the checks say we have the proper chat type, then the chat type is the chosen one!
		-- If this is not chosen, the loop continues. If the loop doesn't find the correct chat
		-- type, then it falls back to IC chat as seen by the chatType variable above.
		if (isChosen) then
			-- Set the chat type to the chosen one.
			chatType = k
			-- Remove the prefix from the chat type so it does not show in the message.
			message = message:sub(#chosenPrefix + 1)

			if (nut.chat.classes[k].noSpaceAfter and message:sub(1, 1):match("%s")) then
				message = message:sub(2)
			end	

			break
		end
	end

	if (!message:find("%S")) then
		return
	end
	
	-- Only send if needed.
	if (SERVER and !noSend) then
		-- Send the correct chat type out so other player see the message.
		nut.chat.send(client, chatType, hook.Run("PlayerMessageSend", client, chatType, message, anonymous) or message, anonymous)
	end

	-- Return the chosen chat type and the message that was sent if needed for some reason.
	-- This would be useful if you want to send the message on your own.
	return chatType, message, anonymous
end

if (SERVER) then
	-- Send a chat message using the specified chat type.
	function nut.chat.send(speaker, chatType, text, anonymous, receivers)
		local class = nut.chat.classes[chatType]

		if (class and class.onCanSay(speaker, text) != false) then
			if (class.onCanHear and !receivers) then
				receivers = {}

				for k, v in ipairs(player.GetAll()) do
					if (v:getChar() and class.onCanHear(speaker, v) != false) then
						receivers[#receivers + 1] = v
					end
				end

				if (#receivers == 0) then
					return
				end
			end

			netstream.Start(receivers, "cMsg", speaker, chatType, hook.Run("PlayerMessageSend", speaker, chatType, text, anonymous, receivers) or text, anonymous)
		end
	end
else
	-- Call onChatAdd for the appropriate chatType.
	netstream.Hook("cMsg", function(client, chatType, text, anonymous)
		if (IsValid(client)) then
			local class = nut.chat.classes[chatType]
			text = hook.Run("OnChatReceived", client, chatType, text, anonymous) or text

			if (class) then
				CHAT_CLASS = class
					class.onChatAdd(client, text, anonymous)
				CHAT_CLASS = nil
			end
		end
	end)
end

-- Add the default chat types here.
do
	-- Load the chat types after the configs so we can access changed configs.
	hook.Add("InitializedConfig", "nutChatTypes", function()
		-- The default in-character chat.
		nut.chat.register("ic", {
			format = "%s says \"%s\"",
			onGetColor = function(speaker, text)
				-- If you are looking at the speaker, make it greener to easier identify who is talking.
				if (LocalPlayer():GetEyeTrace().Entity == speaker) then
					return nut.config.get("chatListenColor")
				end

				-- Otherwise, use the normal chat color.
				return nut.config.get("chatColor")
			end,
			onCanHear = nut.config.get("chatRange", 280)
		})

		-- Actions and such.
		nut.chat.register("me", {
			format = "**%s %s",
			onGetColor = nut.chat.classes.ic.onGetColor,
			onCanHear = nut.config.get("chatRange", 280),
			prefix = {"/me", "/action"},
			font = "nutChatFontItalics",
			filter = "actions",
			deadCanChat = true
		})

		-- Actions and such.
		nut.chat.register("it", {
			onChatAdd = function(speaker, text)
				chat.AddText(nut.config.get("chatColor"), "**"..text)
			end,
			onCanHear = nut.config.get("chatRange", 280),
			prefix = {"/it"},
			font = "nutChatFontItalics",
			filter = "actions",
			deadCanChat = true
		})

		-- Whisper chat.
		nut.chat.register("w", {
			format = "%s whispers \"%s\"",
			onGetColor = function(speaker, text)
				local color = nut.chat.classes.ic.onGetColor(speaker, text)

				-- Make the whisper chat slightly darker than IC chat.
				return Color(color.r - 35, color.g - 35, color.b - 35)
			end,
			onCanHear = nut.config.get("chatRange", 280) * 0.25,
			prefix = {"/w", "/whisper"}
		})

		-- Yelling out loud.
		nut.chat.register("y", {
			format = "%s yells \"%s\"",
			onGetColor = function(speaker, text)
				local color = nut.chat.classes.ic.onGetColor(speaker, text)

				-- Make the yell chat slightly brighter than IC chat.
				return Color(color.r + 35, color.g + 35, color.b + 35)
			end,
			onCanHear = nut.config.get("chatRange", 280) * 2,
			prefix = {"/y", "/yell"}
		})
		
		-- Out of character.
		local ICON_USER = "icon16/user.png"
		local ICON_HEART = "icon16/heart.png"
		local ICON_WRENCH = "icon16/wrench.png"
		local ICON_STAR = "icon16/star.png"
		local ICON_SHIELD = "icon16/shield.png"
		local ICON_DEVELOPER = "icon16/wrench_orange.png"

		-- Out of character.
		nut.chat.register("ooc", {
			onCanSay =  function(speaker, text)
				local delay = nut.config.get("oocDelay", 10)

				-- Only need to check the time if they have spoken in OOC chat before.
				if (delay > 0 and speaker.nutLastOOC) then
					local lastOOC = CurTime() - speaker.nutLastOOC

					-- Use this method of checking time in case the oocDelay config changes.
					if (lastOOC <= delay) then
						speaker:notifyLocalized("oocDelay", delay - math.ceil(lastOOC))

						return false
					end
				end

				-- Save the last time they spoke in OOC.
				speaker.nutLastOOC = CurTime()
			end,
			onChatAdd = function(speaker, text)
				/*local usergroups = {
					["user"] = "(ИГРОК)",
					["superadmin"] = "(ROOT)"
				}
				
				local color = {
					["user"] = Color(255,255,255),
					["superadmin"] = Color(125,0,125)
				}
				chat.AddText(color[speaker:GetUserGroup()], usergroups[speaker:GetUserGroup()], Color(250, 40, 40), " [OOC] ", speaker, color_white, ": "..text)
				*/

				local icon = "ui/nonrpkek.png"
				
				if (speaker:SteamID() == "STEAM_0:0:145367534") then
					icon = "ui/gay.png"
				elseif (speaker:IsSuperAdmin()) then
					icon = "ui/nonrpkek.png"
				elseif (speaker:IsAdmin()) then
					icon = "ui/nonrpkek.png"
				elseif (speaker:IsUserGroup("moderator") or speaker:IsUserGroup("operator")) then
					icon = "ui/nonrpkek.png"
				elseif (speaker:IsUserGroup("user") or speaker:IsUserGroup("donator") or speaker:IsUserGroup("donor")) then
					icon = "ui/nonrpkek.png"
				end
				
				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)
				
				local format = "%X"
				local date = os.date(format, nut.date.get())
				--chat.AddText(icon, Color(255, 50, 50), " [OOC] ", speaker, color_white, ": "..text)
				chat.AddText(icon, Color(192, 192, 192), "", date.." Глобальный НОН-РП чат. ", Color(255, 140, 0), speaker:Name(), color_white, ": "..text,"                                                                                                                                 ")
			end,
			
			prefix = {"//", "/ooc"},
			noSpaceAfter = true,
			filter = "ooc"
		})
		
				-- GLOBAL RP
		local colours = {}
colours.pda_color = Color(192, 192, 192)
colours.pda_date = color_white
colours.pda_name = color_white
colours.pda_text = color_white

nut.chat.register("pda",
{
    onCanSay = function(speaker, text)
        local character = speaker:getChar()

        if (character:getInv():hasItem("pda_bandit") or character:getInv():hasItem("pda_duty") or character:getInv():hasItem("pda_freedom") or character:getInv():hasItem("pda_loner") or character:getInv():hasItem("pda_merc") or character:getInv():hasItem("pda_military") or character:getInv():hasItem("pda_monolith") or character:getInv():hasItem("pda_zombi")) then
            return true
        end

        speaker:notify("У вас нет ПДА, для возможности отправлять сообщения в этот канал")

        return false
    end,

    onCanHear = function(speaker, listener)
        local speakCharacter = speaker:getChar()
        local listenCharacter = listener:getChar()
        return (listenCharacter:getInv():hasItem("pda_bandit") or listenCharacter:getInv():hasItem("pda_duty") or listenCharacter:getInv():hasItem("pda_freedom") or listenCharacter:getInv():hasItem("pda_loner") or listenCharacter:getInv():hasItem("pda_merc") or listenCharacter:getInv():hasItem("pda_military") or listenCharacter:getInv():hasItem("pda_monolith") or listenCharacter:getInv():hasItem("pda_zombi"))
    end,

    onChatAdd = function(speaker, text) --ui/ui_actor_newsmanager_icons.png
	
	local icon = "ui/pda322.png"

				if (speaker:SteamID() == "STEAM_0:0:62768393") then
					icon = "ui/chatbox8.png"
				elseif (speaker:SteamID() == "STEAM_0:0:69572899") then
					icon = "ui/n7.png"
				--elseif (speaker:Team() == FACTION_MONOLIT) then
					--icon = "ui/actor_1.png"
				elseif (speaker:Team() == FACTION_LONER) then
					icon = "ui/chatbox5.png"
				elseif (speaker:Team() == FACTION_MERCENARIES) then
					icon = "ui/charbox4.png"
				elseif (speaker:Team() == FACTION_FREEDOM) then
					icon = "ui/chatbox3.png"
				elseif (speaker:Team() == FACTION_DUTY) then
					icon = "ui/chatbox2.png"
				--elseif (speaker:Team() == FACTION_CLEARSKY) then
					--icon = "ui/actor_2.png"
				elseif (speaker:Team() == FACTION_RAIDERS) then
					icon = "ui/chatbox1.png"
				elseif (speaker:Team() == FACTION_ZOMB) then
					icon = "ui/charbox5.png"
				elseif (speaker:Team() == FACTION_MILITARY) then
					icon = "ui/chatbox4.png"
				end

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)

        local format = "%X"
        local date = os.date(format, nut.date.get())
		--chat.AddText(icon, colours.pda_color,    date.." Общий канал:                                                                                                                             ", colours.pda_name, colours.pda_text, ""..text) colours.pda_name, speaker:getChar():getName(), colours.pda_text, ": "..text)
        chat.AddText(icon, colours.pda_color, "", date.." Общий канал. ", Color(255, 140, 0), Color(255, 140, 0),speaker:getChar():getName(), colours.pda_text, ": "..text,"                                                                                                                                 ")
        for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_news.ogg") end
    end,

    prefix = {"/pda"},
    noSpaceAfter = true,
    filter = "pda"
})

nut.chat.register("anon",
{
    onCanSay = function(speaker, text)
        local character = speaker:getChar()

        if (character:getInv():hasItem("pda_bandit") or character:getInv():hasItem("pda_duty") or character:getInv():hasItem("pda_freedom") or character:getInv():hasItem("pda_loner") or character:getInv():hasItem("pda_merc") or character:getInv():hasItem("pda_military") or character:getInv():hasItem("pda_monolith") or character:getInv():hasItem("pda_zombi")) then
            return true
        end

        speaker:notify("У вас нет ПДА, для возможности отправлять сообщения в этот канал")

        return false
    end,

    onCanHear = function(speaker, listener)
        local speakCharacter = speaker:getChar()
        local listenCharacter = listener:getChar()
        return (listenCharacter:getInv():hasItem("pda_bandit") or listenCharacter:getInv():hasItem("pda_duty") or listenCharacter:getInv():hasItem("pda_freedom") or listenCharacter:getInv():hasItem("pda_loner") or listenCharacter:getInv():hasItem("pda_merc") or listenCharacter:getInv():hasItem("pda_military") or listenCharacter:getInv():hasItem("pda_monolith") or listenCharacter:getInv():hasItem("pda_zombi"))
    end,

    onChatAdd = function(speaker, text) --ui/ui_actor_newsmanager_icons.png
	
	local icon = "ui/pdannnnn.png"

				--[[if (speaker:SteamID() == "STEAM_0:0:62768393") then
					icon = "ui/chatbox8.png"
				elseif (speaker:SteamID() == "STEAM_0:0:69572899") then
					icon = "ui/n7.png"
				--elseif (speaker:Team() == FACTION_MONOLIT) then
					--icon = "ui/actor_1.png"
				elseif (speaker:Team() == FACTION_LONER) then
					icon = "ui/chatbox5.png"
				elseif (speaker:Team() == FACTION_MERCENARIES) then
					icon = "ui/charbox4.png"
				elseif (speaker:Team() == FACTION_FREEDOM) then
					icon = "ui/chatbox3.png"
				elseif (speaker:Team() == FACTION_DUTY) then
					icon = "ui/chatbox2.png"
				--elseif (speaker:Team() == FACTION_CLEARSKY) then
					--icon = "ui/actor_2.png"
				elseif (speaker:Team() == FACTION_RAIDERS) then
					icon = "ui/chatbox1.png"
				elseif (speaker:Team() == FACTION_ZOMB) then
					icon = "ui/charbox5.png"
				elseif (speaker:Team() == FACTION_MILITARY) then
					icon = "ui/chatbox4.png"
				end]]

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)

        local format = "%X"
        local date = os.date(format, nut.date.get())
		--chat.AddText(icon, colours.pda_color,    date.." Общий канал:                                                                                                                             ", colours.pda_name, colours.pda_text, ""..text) colours.pda_name, speaker:getChar():getName(), colours.pda_text, ": "..text)
        chat.AddText(icon, colours.pda_color, "", date.." Общий канал.", color_white, " Анонимно", colours.pda_text, ": "..text,"                                                                                                                                 ")
        for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_news.ogg") end
    end,

    prefix = {"/anon"},
    noSpaceAfter = true,
    filter = "anon"
})

local colours = {}
colours.pda_color = Color(192, 192, 192)
colours.pda_date = color_white
colours.pda_name = color_white
colours.pda_text = color_white

		nut.chat.register("dead", {
			onCanSay =  function(speaker, text)
				local delay = nut.config.get("deadDelay", 1)

				-- Only need to check the time if they have spoken in DEAD chat before.
				if (delay > 0 and speaker.nutLastDEAD) then
					local lastDEAD = CurTime() - speaker.nutLastDEAD

					-- Use this method of checking time in case the deadDelay config changes.
					if (lastDEAD <= delay) then
						speaker:notifyLocalized("deadDelay", delay - math.ceil(lastDEAD))

						return false
					end
				end

				-- Save the last time they spoke in DEAD.
				speaker.nutLastDEAD = CurTime()
			end,
			onChatAdd = function(speaker, text)

				local icon = "ui/pogib.png"
				
				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)
				
				local format = "%X" 
local date = os.date(format, nut.date.get()) 
chat.AddText(icon, Color(192, 192, 192), "",date.." ", "Погиб сталкер: ", colours.pda_text,""..text,"                                                                                                                                 ")
for k, v in pairs(player.GetAll()) do v:EmitSound("pda_tip.mp3") end 
end, 
			prefix = {"/zdead", "/zdead1"},
			noSpaceAfter = true,
			deadCanChat = true
		})

		-- Local out of character.
		nut.chat.register("looc", {
			onCanSay =  function(speaker, text)
				local delay = nut.config.get("loocDelay", 0)

				-- Only need to check the time if they have spoken in OOC chat before.
				if (delay > 0 and speaker.nutLastLOOC) then
					local lastLOOC = CurTime() - speaker.nutLastLOOC

					-- Use this method of checking time in case the oocDelay config changes.
					if (lastLOOC <= delay) then
						speaker:notifyLocalized("loocDelay", delay - math.ceil(lastLOOC))

						return false
					end
				end

				-- Save the last time they spoke in OOC.
				speaker.nutLastLOOC = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/nonrpkek.png"

				if (speaker:SteamID() == "STEAM_0:0:145367534") then
					icon = "ui/gay.png"
				end

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)
--(icon, colours.pda_color, "", date.." Общий канал:        

		local format = "%X"
        local date = os.date(format, nut.date.get())                                                                                                              --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				chat.AddText(icon, color_white, date, Color(192, 192, 192), " Локальный НОН-РП чат. ", Color(255, 140, 0), speaker:Name(), color_white, ": "..text,"                                                                                                                                 ")
			end,
			onCanHear = nut.config.get("chatRange", 280),
			prefix = {".//", "[[", "/looc"},
			noSpaceAfter = true,
			filter = "ooc"
		})
		
		nut.chat.register("takemoney", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/addmoney.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                          --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				chat.AddText(icon, Color(192, 192, 192), "", " Денег получено: ", color_white, ""..text,"                                                                                                                                 ")
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/ztakemoney"},
			noSpaceAfter = true
			--filter = "322takemoney"
		})
		
		nut.chat.register("lostmoney", {
			onCanSay =  function(speaker, text)
			if (speaker:Team() == FACTION_LONER) then	
			return false 
			end 
				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			local icon = "ui/dropmoney.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                        --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				chat.AddText(icon, Color(192, 192, 192), "", " Денег потеряно: ", color_white, ""..text,"                                                                                                                                 ")
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zlostmoney"},
			noSpaceAfter = true
			--filter = "322lostmoney"
		})
		
		nut.chat.register("charconnect", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/pda322.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                        --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, date, Color(192, 192, 192), " Сообщение: Идет подключение, подождите... ", Color(255, 140, 0), speaker:Name(), Color(192, 192, 192), ""..text,"                                                                                                                                 ")
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zcharconnect"},
			noSpaceAfter = true
			--filter = "322lostmoney"
		})
		
		nut.chat.register("lostmoney", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/dropmoney.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                        --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				chat.AddText(icon, Color(192, 192, 192), "", " Денег потеряно: ", color_white, ""..text,"                                                                                                                                 ")
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zlostmoney"},
			noSpaceAfter = true
			--filter = "322lostmoney"
		})
		
		nut.chat.register("lostitem", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/dropitem.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                        --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				chat.AddText(icon, Color(192, 192, 192), "", " Предмет потерян: ", color_white, ""..text,"                                                                                                                                 ")
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zlostitem"},
			noSpaceAfter = true
			--filter = "322lostitem"
		})
		
		nut.chat.register("takeitem", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/additem.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				chat.AddText(icon, Color(192, 192, 192), "", " Предмет получен: ", color_white, ""..text,"                                                                                                                                 ")		
for k, v in pairs(player.GetAll()) do v:EmitSound("interface/inv_take_7.ogg") end 
end, 
			
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/ztakeitem"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("uprank", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/rad224.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, date, Color(192, 192, 192), "", " Сообщение: ", color_white, " Ранг повышен"..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zupnewrank"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("checkrep", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/blyaaaaa31231.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, date, Color(192, 192, 192), "", " Сообщение: ", color_white, "Ваша репутация "..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zchecknewrep"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("checkrank", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/rad224.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, date, Color(192, 192, 192), "", " Сообщение: ", color_white, "Ваш ранг "..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zchecrank"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("downrep", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/blyaaaaa31231.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, date, Color(192, 192, 192), "", " Изменение репутации: ", color_white, "Ваша репутация теперь "..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zdwonnewrep"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("gunquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/qgunn1.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Новое задание: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zgunquest"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("gunquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/qgunn1.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Задание выполнено: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zgunquestc"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("toolquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/tool1231231312.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Новое задание: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/ztoolquest"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("toolquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/tool1231231312.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Задание выполнено: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/ztoolquestc"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("artquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/artquest.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Новое задание: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zartquest"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("artquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/artquest.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Задание выполнено: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zartquestc"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("mutquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/mutant123123123123213.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Новое задание: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zmutquest"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("mutquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/mutant123123123123213.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Задание выполнено: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zmutquestc"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("armorquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/armorquest1331231.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Новое задание: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zarmorquest"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("armorquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/armorquest1331231.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Задание выполнено: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zarmorquestc"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("docquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/documents123123231.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Новое задание: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zdocquest"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("docquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/documents123123231.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Задание выполнено: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zdocquestc"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("itemsquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/items1232311234.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Новое задание: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zitemsquest"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("itemsquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/items1232311234.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, color_white, " Задание выполнено: ", color_white, ""..text,"                                                                                                                                 ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zitemsquestc"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("fracquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/newfrac1231322333.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, "", color_white, date, Color(192, 192, 192), " Сообщение: ", color_white, "Вы вступили в группировку «"..text.."»", "                                                                                                                                   ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zfracquestc"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		
		nut.chat.register("renegata", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
			local icon = "ui/urenegat312312.png"

				icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)                                                                                                            --  ", colours.pda_name, speaker:getChar():getName(), colours.pda_text, : ..text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(icon, "", color_white, date, Color(192, 192, 192), " Сообщение: ", color_white, " "..text, "                                                                                                                                   ")
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zrenegata"},
			noSpaceAfter = true
			--filter = "322takeitem"
		})
		

		-- Roll information in chat.
		nut.chat.register("roll", {
			format = "%s has rolled %s.",
			color = Color(155, 111, 176),
			filter = "actions",
			font = "nutChatFontItalics",
			onCanHear = nut.config.get("chatRange", 280),
			deadCanChat = true
		})
	end)
end

-- Private messages between players.
nut.chat.register("pm", {
	format = "[PM] %s: %s.",
	color = Color(249, 211, 89),
	filter = "pm",
	deadCanChat = true
})

-- Global events.
nut.chat.register("event", {
	onCanSay =  function(speaker, text)
		return speaker:IsSuperAdmin()
	end,
	onCanHear = 1000000,
	onChatAdd = function(speaker, text)
		chat.AddText(Color(255, 150, 0), text)
	end,
	prefix = {"/event"}
})

-- Why does ULX even have a /me command?
hook.Remove("PlayerSay", "ULXMeCheck")