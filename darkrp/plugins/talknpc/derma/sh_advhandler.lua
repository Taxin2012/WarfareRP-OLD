local PLUGIN = PLUGIN
nut.plugin = nut.plugin or {}
nut.plugin.list = nut.plugin.list or {}
--PrintTable(nut.plugin.list.quests)
local questPLUGIN = nut.plugin.list.quests--nut.plugins.list( "quests" )
if not questPLUGIN then
    print( 'quest_honeya example will not work properly without "quest" plugin.' )
end

/*---------------------------------------------------------
    This is advanced handler for dialogue plugin.
    You can make some quest like things with this.
    But I recommends you don't care about this handler
    If you don't know how to code.
   
    I will not answer any question about how to use this plugin.
    Unless you have any clue about this dialogue handler.
--------------------------------------------------------*/

-- You can call SpecialCall with !.
-- example. when a player call dialouge that has uid "!quest_recieve_test" then it will call SpecialCall["quest_receive_test"].
PLUGIN.SpecialCall =
{
		["quest_leader_dolg"] = {
            sv = function( client, data )
                if client:HasQuest( "leader_dolg" ) then
                    -- questPLUGIN = from the "quests" plugin.
                    local pqst_dat = client:GetQuest( "leader_dolg" ) -- get player quest data
                    if client:CanCompleteQuest( "leader_dolg", pqst_dat ) then					-- If see player can complete quest
                        client:GiveQuestReward( "leader_dolg", pqst_dat ) -- Give quest reward
                        client:RemoveQuest( "leader_dolg" ) -- and remove player quest.
						client:getChar():setFaction(FACTION_DUTY)
						client:SetModel("models/spenser/ssk/new_dolg_01_spen.mdl") 
                        data.done = true -- send client data.done. It will generate you're done text.
                    else
                        data.done = false
                    end
                else
                    -- set quest and get quest.
                    data.gotquest = true -- Just got a quest!
                    local d_qst = questPLUGIN:GetQuest( "leader_dolg" )
                    client:AddQuest( "leader_dolg", d_qst:GenerateData( client ) ) -- Give a quest that has uniqueid 'honeya' and generates random data for quest.
                    -- Quest data generating function is in sh_quests.lua file.
                end
                return data -- MUST RETURN DATA
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "leader_dolg" )
                    local pqst_dat = LocalPlayer():GetQuest( "leader_dolg" )
                    panel:AddChat( data.name, "Принеси Комбинезон «Ветер свободы» и Нашивку «Свободы», можешь быть уверен, что ты станешь одним из нас." )
                    --[[for k, v in pairs( pqst_dat ) do
                        panel:AddCustomText( Format( unpack( { v, nut.item.list[k].name } ) ), "Nut_NPCChatSel" )
                    end]]
                    panel.talking = false -- Get quest and end the converstaion.
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Теперь ты член долга.")
                else
                    panel:AddChat( data.name, "Принес Комбенизон «Ветер свободы»?")
                    local d_qst = questPLUGIN:GetQuest( "leader_dolg" )
                    local pqst_dat = LocalPlayer():GetQuest( "leader_dolg" )
                   --[[ for k, v in pairs( pqst_dat ) do
                        panel:AddCustomText( Format( d_qst.desc, unpack( { v, nut.item.list[k].name } ) ), "Nut_NPCChatSel" )
                    end]]
                end
                panel.talking = false
            end,
        },
		["quest_chzo"] = {
            sv = function( client, data )
                if client:HasQuest( "chzo" ) then
                    -- questPLUGIN = from the "quests" plugin.
                    local pqst_dat = client:GetQuest( "chzo" ) -- get player quest data
                    if client:CanCompleteQuest( "chzo", pqst_dat ) then -- If see player can complete quest
                        client:GiveQuestReward( "chzo", pqst_dat ) -- Give quest reward
                        client:RemoveQuest( "chzo" ) -- and remove player quest.
                        data.done = true -- send client data.done. It will generate you're done text.
                    else
                        data.done = false
                    end
                else
                    -- set quest and get quest.
                    data.gotquest = true -- Just got a quest!
                    local d_qst = questPLUGIN:GetQuest( "chzo" )
                    client:AddQuest( "chzo", d_qst:GenerateData( client ) ) -- Give a quest that has uniqueid 'honeya' and generates random data for quest.
                    -- Quest data generating function is in sh_quests.lua file.
                end
                return data -- MUST RETURN DATA
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "chzo" )
                    local pqst_dat = LocalPlayer():GetQuest( "chzo" )
                    panel:AddChat( data.name, "" )
                    for k, v in pairs( pqst_dat ) do
                        panel:AddCustomText( Format( d_qst.desc, unpack( { v, nut.item.list[k].name } ) ), "Nut_NPCChatSel" )
                    end
                    panel.talking = false -- Get quest and end the converstaion.
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Благодарю Вас, молодой человек. Я немедленно приступаю к исследованиям.")
                else
                    panel:AddChat( data.name, "Вы принесли щупальца кровососа?")
                    local d_qst = questPLUGIN:GetQuest( "chzo" )
                    local pqst_dat = LocalPlayer():GetQuest( "chzo" )
                    for k, v in pairs( pqst_dat ) do
                        panel:AddCustomText( Format( d_qst.desc, unpack( { v, nut.item.list[k].name } ) ), "Nut_NPCChatSel" )
                    end
                end
                panel.talking = false
            end,
        },
		["quest_mnash"] = {
            sv = function( client, data )
                if client:HasQuest( "mnash" ) then
                    -- questPLUGIN = from the "quests" plugin.
                    local pqst_dat = client:GetQuest( "mnash" ) -- get player quest data
                    if client:CanCompleteQuest( "mnash", pqst_dat ) then -- If see player can complete quest
                        client:GiveQuestReward( "mnash", pqst_dat ) -- Give quest reward
                        client:RemoveQuest( "mnash" ) -- and remove player quest.
                        data.done = true -- send client data.done. It will generate you're done text.
                    else
                        data.done = false
                    end
                else
                    -- set quest and get quest.
                    data.gotquest = true -- Just got a quest!
                    local d_qst = questPLUGIN:GetQuest( "mnash" )
                    client:AddQuest( "mnash", d_qst:GenerateData( client ) ) -- Give a quest that has uniqueid 'honeya' and generates random data for quest.
                    -- Quest data generating function is in sh_quests.lua file.
                end
                return data -- MUST RETURN DATA
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "mnash" )
                    local pqst_dat = LocalPlayer():GetQuest( "mnash" )
                    panel:AddChat( data.name, "" )
                    for k, v in pairs( pqst_dat ) do
                        panel:AddCustomText( Format( d_qst.desc, unpack( { v, nut.item.list[k].name } ) ), "Nut_NPCChatSel" )
                    end
                    panel.talking = false -- Get quest and end the converstaion.
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Сегодня видишь. ты мне помог, а завра и я тебе.")
                else
                    panel:AddChat( data.name, "Принес %s?")
                    local d_qst = questPLUGIN:GetQuest( "mnash" )
                    local pqst_dat = LocalPlayer():GetQuest( "mnash" )
                    for k, v in pairs( pqst_dat ) do
                        panel:AddCustomText( Format( d_qst.desc, unpack( { v, nut.item.list[k].name } ) ), "Nut_NPCChatSel" )
                    end
                end
                panel.talking = false
            end,
        },
		["quest_psi2"] = { -- QUEST EXAMPLE.
            sv = function( client, data )
                if client:HasQuest( "psi2" ) then
                    -- questPLUGIN = from the "quests" plugin.
                    local pqst_dat = client:GetQuest( "psi2" ) -- get player quest data
                    if client:CanCompleteQuest( "psi2", pqst_dat ) then -- If see player can complete quest
                        client:GiveQuestReward( "psi2", pqst_dat ) -- Give quest reward
                        client:RemoveQuest( "psi2" ) -- and remove player quest.
                        data.done = true -- send client data.done. It will generate you're done text.
                    else
                        data.done = false
                    end
                else
                    -- set quest and get quest.
                    data.gotquest = true -- Just got a quest!
                    local d_qst = questPLUGIN:GetQuest( "psi2" )
                    client:AddQuest( "psi2", d_qst:GenerateData( client ) ) -- Give a quest that has uniqueid 'psi2' and generates random data for quest.
                    -- Quest data generating function is in sh_quests.lua file.
                end
                return data -- MUST RETURN DATA
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "psi2" )
                    local pqst_dat = LocalPlayer():GetQuest( "psi2" ) -- get player quest data
                    panel:AddChat( data.name, "" )
                    for k, v in pairs( pqst_dat ) do
                        panel:AddCustomText( Format( d_qst.desc, unpack( { v, nut.item.list[k].name } ) ), "Nut_NPCChatSel" )
                    end
                    panel.talking = false -- Get quest and end the converstaion.
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Держите. Шлем должен вас защитить.")
                else
                    panel:AddChat( data.name, "Вы принесли пси-шлем?")
                end
                panel.talking = false
            end,
        },
		["quest_psi1"] = { -- QUEST EXAMPLE. 
            sv = function( client, data )
                if client:HasQuest( "psi1" ) then
                    -- questPLUGIN = from the "quests" plugin.
                    local pqst_dat = client:GetQuest( "psi1" ) -- get player quest data
                    if client:CanCompleteQuest( "psi1", pqst_dat ) then -- If see player can complete quest
                        client:GiveQuestReward( "psi1", pqst_dat ) -- Give quest reward
                        client:RemoveQuest( "psi1" ) -- and remove player quest.
                        data.done = true -- send client data.done. It will generate you're done text.
                    else
                        data.done = false
                    end
                else
                    -- set quest and get quest.
                    data.gotquest = true -- Just got a quest!
                    local d_qst = questPLUGIN:GetQuest( "psi1" )
                    client:AddQuest( "psi1", d_qst:GenerateData( client ) ) -- Give a quest that has uniqueid 'psi2' and generates random data for quest.
                    -- Quest data generating function is in sh_quests.lua file.
                end
                return data -- MUST RETURN DATA
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "psi1" )
                    local pqst_dat = LocalPlayer():GetQuest( "psi1" ) -- get player quest data
                    panel:AddChat( data.name, "" )
                    for k, v in pairs( pqst_dat ) do
                        panel:AddCustomText( Format( d_qst.desc, unpack( { v, nut.item.list[k].name } ) ), "Nut_NPCChatSel" )
                    end
                    panel.talking = false -- Get quest and end the converstaion.
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Как и договаривались, твои пси-шлем.")
                else
                    panel:AddChat( data.name, "Принес «Чёрный ящик»?")
                end
                panel.talking = false
            end,
        },
        ["quest_medic"] = {
            sv = function( client, data )
                client:EmitSound( "interface/inv_bandage_2p9.ogg" )
                client:SetHealth( 100 )
				--		end
						
						
				--client:getChar():takeMoney(2100)
                return data -- MUST RETURN DATA
            end,
            cl = function( client, panel, data )
                panel:AddChat( data.name, "Так, вот и всё... Можешь идти." )
                panel.talking = false -- Ends the current conversation and allows player to talk about other topics.
            end,
        },
		["quest_bandit_informator1"] = {
            sv = function( client, data )
                if client:HasQuest( "bandit_informator1" ) then
                    local pqst_dat = client:GetQuest( "bandit_informator1" )
					--if (client:Team() == FACTION_LONER) then
					if (client:getChar():hasMoney(5000)) then
                    if client:CanCompleteQuest( "bandit_informator1", pqst_dat ) then
                        --client:GiveQuestReward( "bandit_informator1", pqst_dat )
                        client:RemoveQuest( "bandit_informator1" )
						client:getChar():takeMoney(5000)
							local faction = nut.faction.indices[FACTION_RAIDERS]
							if (faction) then
								local faction = nut.faction.indices[FACTION_RAIDERS]
							    local character = client:getChar()
							
							    character.vars.faction = faction.uniqueID
							    character:setFaction(faction.index)
							end
							--client:SetModel("models/spenser/ssk/new_renegat_01_spen.mdl")
							local character = client:getChar() 
							if !character then return end 
							local faction = nut.faction.indices[character:getFaction()] 
							client:ConCommand("say /zfracquestc"..faction.name.."")
							timer.Simple(0.7, function()
							client:ConCommand("say /zlostmoney 5000")
							end)
						
                        data.done = true
                    else
                        data.done = false
                    end
				--end
				end
                else
                    data.gotquest = true 
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator1" )
                    client:AddQuest( "bandit_informator1" ) 
                end
                return data 
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator1" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator1" )
                    panel:AddChat( data.name, "Че ж ты сразу к пахану Султану не пошел... ах да, совсем забыл, тебя бы к нему и на метр не подпустили бы, че ж ты забыл у этих клятых гопарей? Ладно, не мое это дело, все сделаем за 5000 деревянных." )
                    panel.talking = false 
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Отлично, начинаю обновлять твои данные. Такс... Сейчас обновим твой профиль в глобальной сталкерской сети... Старые данные стираем... Все, теперь ты бандит! Удачного тебе гоп-стопа по Зоне, ральный пацан *смеется*! И да, комбез бандитский возьми.")
                else
                    panel:AddChat( data.name, "Не, парень, так не пойдет, у тебя бабла нет, возвращайся когда у тебя будет 5000 деревянных.")
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator1" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator1" )
					--LocalPlayer():RemoveQuest( "bandit_informator1" )
                end
                panel.talking = false
            end,
        },
		---------------------------------------------------
		["quest_bandit_informator3"] = {
            sv = function( client, data )
                if client:HasQuest( "bandit_informator3" ) then
                    local pqst_dat = client:GetQuest( "bandit_informator3" )
					--if (client:Team() == FACTION_LONER) then
					if (client:getChar():hasMoney(40000)) then
                    if client:CanCompleteQuest( "bandit_informator3", pqst_dat ) then
                        --client:GiveQuestReward( "bandit_informator3", pqst_dat )
                        client:RemoveQuest( "bandit_informator3" )
						client:getChar():takeMoney(40000)
						client:getChar():getInv():add("militaryskat") 
						client:getChar():getInv():add("groza") 
							local faction = nut.faction.indices[FACTION_MERCENARIES]
							if (faction) then
								local faction = nut.faction.indices[FACTION_MERCENARIES]
							    local character = client:getChar()
							
							    character.vars.faction = faction.uniqueID
							    character:setFaction(faction.index)
							end
							--client:SetModel("models/spenser/ssk/new_solder_04b_spen.mdl")
							local character = client:getChar() 
							if !character then return end 
							local faction = nut.faction.indices[character:getFaction()] 
							client:ConCommand("say /zfracquestc"..faction.name.."")
							timer.Simple(0.8, function()
							client:ConCommand("say /zlostmoney 40000")
							end)
							timer.Simple(1.6, function()
							client:ConCommand("say /ztakeitem Бронекостюм «СКАТ-9М»")
							end)
							timer.Simple(2.3, function()
							client:ConCommand("say /ztakeitem ОЦ-14-4А")
							end)
						
                        data.done = true
                    else
                        data.done = false
                    end
				--end
				end
                else
                    data.gotquest = true 
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator3" )
                    client:AddQuest( "bandit_informator3" ) 
                end
                return data 
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator3" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator3" )
                    panel:AddChat( data.name, "Это запросто... Просто позволь тебе кое-что объяснить. Для начала скажу тебе одно: это будет стоить денег: 40000 деревянных, иначе разговора вообще не будет, вот еще что: если ты уйдешь из группировки в которую вступил, обратной дороги уже не будет, ни за какие деньги назад уже не примут, так что подумай башкой очень хорошо, надо ли тебе это. " )
                    panel.talking = false 
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Отлично, начинаю обновлять твои данные. Такс... Сейчас обновим твой профиль в глобальной сталкерской сети... Старые данные стираем... Все, теперь ты в Синдикате. Прибыльных контрактов, и да, держи снарягу.")
                else
                    panel:AddChat( data.name, "Не, парень, так не пойдет, у тебя бабла нет, возвращайся когда у тебя будет 40000 деревянных.")
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator3" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator3" )
					--LocalPlayer():RemoveQuest( "bandit_informator3" )
                end
                panel.talking = false
            end,
        },
		
		---------------------------------------------------
		["quest_bandit_informator3"] = {
            sv = function( client, data )
                if client:HasQuest( "bandit_informator3" ) then
                    local pqst_dat = client:GetQuest( "bandit_informator3" )
					--if (client:Team() == FACTION_LONER) then
					if (client:getChar():hasMoney(20000)) then
                    if client:CanCompleteQuest( "bandit_informator3", pqst_dat ) then
                        --client:GiveQuestReward( "bandit_informator3", pqst_dat )
                        client:RemoveQuest( "bandit_informator3" )
						client:getChar():takeMoney(20000)
						client:getChar():getInv():add("militaryskat") 
						client:getChar():getInv():add("groza") 
							local faction = nut.faction.indices[FACTION_FREEDOM]
							if (faction) then
								local faction = nut.faction.indices[FACTION_FREEDOM]
							    local character = client:getChar()
							
							    character.vars.faction = faction.uniqueID
							    character:setFaction(faction.index)
							end
							--client:SetModel("models/spenser/ssk/new_solder_04b_spen.mdl")
							local character = client:getChar() 
							if !character then return end 
							local faction = nut.faction.indices[character:getFaction()] 
							client:ConCommand("say /zfracquestc"..faction.name.."")
							timer.Simple(0.8, function()
							client:ConCommand("say /zlostmoney 20000")
							end)
							timer.Simple(1.6, function()
							client:ConCommand("say /ztakeitem Бронекостюм «СКАТ-9М»")
							end)
							timer.Simple(2.3, function()
							client:ConCommand("say /ztakeitem ОЦ-14-4А")
							end)
						
                        data.done = true
                    else
                        data.done = false
                    end
				--end
				end
                else
                    data.gotquest = true 
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator3" )
                    client:AddQuest( "bandit_informator3" ) 
                end
                return data 
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator3" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator3" )
                    panel:AddChat( data.name, "Это запросто... Просто позволь тебе кое-что объяснить. Для начала скажу тебе одно: это будет стоить денег: 20000 деревянных, иначе разговора вообще не будет, вот еще что: если ты уйдешь из группировки в которую вступил, обратной дороги уже не будет, ни за какие деньги назад уже не примут, так что подумай башкой очень хорошо, надо ли тебе это. " )
                    panel.talking = false 
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Отлично, начинаю обновлять твои данные. Такс... Сейчас обновим твой профиль в глобальной сталкерской сети... Старые данные стираем... Все, теперь ты свободовец! Держи снарягу Свободы.")
                else
                    panel:AddChat( data.name, "Не, парень, так не пойдет, у тебя бабла нет, возвращайся когда у тебя будет 40000 деревянных.")
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator3" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator3" )
					--LocalPlayer():RemoveQuest( "bandit_informator3" )
                end
                panel.talking = false
            end,
        },
		---------------------------------------------------
		["quest_bandit_informator4"] = {
            sv = function( client, data )
                if client:HasQuest( "bandit_informator4" ) then
                    local pqst_dat = client:GetQuest( "bandit_informator4" )
					--if (client:Team() == FACTION_LONER) then
					if (client:getChar():hasMoney(10000)) then
                    if client:CanCompleteQuest( "bandit_informator4", pqst_dat ) then
                        --client:GiveQuestReward( "bandit_informator4", pqst_dat )
                        client:RemoveQuest( "bandit_informator4" )
						client:getChar():takeMoney(10000)
							local faction = nut.faction.indices[FACTION_LONER]
							if (faction) then
								local faction = nut.faction.indices[FACTION_LONER]
							    local character = client:getChar()
							
							    character.vars.faction = faction.uniqueID
							    character:setFaction(faction.index)
							end
							--client:SetModel("models/spenser/ssk/new_solder_04b_spen.mdl")
							local character = client:getChar() 
							if !character then return end 
							local faction = nut.faction.indices[character:getFaction()] 
							client:ConCommand("say /zfracquestc"..faction.name.."")
							timer.Simple(0.8, function()
							client:ConCommand("say /zlostmoney 10000")
							end)
							timer.Simple(1.6, function()
							client:ConCommand("say /ztakeitem Бронекостюм «СКАТ-9М»")
							end)
							timer.Simple(2.3, function()
							client:ConCommand("say /ztakeitem ОЦ-14-4А")
							end)
						
                        data.done = true
                    else
                        data.done = false
                    end
				--end
				end
                else
                    data.gotquest = true 
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator4" )
                    client:AddQuest( "bandit_informator4" ) 
                end
                return data 
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator4" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator4" )
                    panel:AddChat( data.name, "Я тебя понимаю, ко мне много таких приходит, которых заманала эта рутина внутри самой группировки, я освобожу тебя от членства во фракции, за 10000 деревянных." )
                    panel.talking = false 
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Вот и отлично, начинаю обновлять твои данные.  Такс... Сейчас обновим твой профиль в глобальной сталкерской сети... Старые данные стираем...Все, теперь ты простой одиночка! Наслаждайся этой свободой.")
                else
                    panel:AddChat( data.name, "Не, парень, так не пойдет, у тебя бабла нет, возвращайся когда у тебя будет 10000 деревянных.")
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator4" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator4" )
					--LocalPlayer():RemoveQuest( "bandit_informator4" )
                end
                panel.talking = false
            end,
        },
		
}

-- Handler.
if SERVER then
    netstream.Hook( "nut_DialogueMessage", function( client, data )
        if string.Left( data.request, 1 ) == "!" then
            data.request = string.sub( data.request, 2 )
            if PLUGIN.SpecialCall[ data.request ] then
                data = PLUGIN.SpecialCall[ data.request ].sv( client, data )
                netstream.Start( client, "nut_DialoguePingpong", data )
            else
                print( Format( "%s( %s ) tried to call invalid dialouge request( %s ) from %s.", client:Name(), client:Nick(), data.request, data.name ) )
                print( "Please check PLUGIN.SpecialCall or NPC's dialouge unique id." )
                client:EmitSound( "HL1/fvox/hev_general_fail.wav" )
            end
        end
    end)
else
    netstream.Hook( "nut_DialoguePingpong", function( data )
        if IsValid( nut.gui.dialogue ) then
            if PLUGIN.SpecialCall[ data.request ] then
                PLUGIN.SpecialCall[ data.request ].cl( client, nut.gui.dialogue, data )
            end
        end
    end)
end

