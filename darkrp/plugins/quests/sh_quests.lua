local PLUGIN = PLUGIN
---------------------------------
--- BUYER QUEST
--- COLLECT ONE ARTIFACT FOR SOMEONE
--- THE ITEM HAS TO BE COLLECTED WILL BE RANDOMIZED IN randomItem.

local QUEST = {}
QUEST.uniqueID = "saharart"
QUEST.name = "Артефакт для сахарова"
QUEST.desc = "Поможете мне с исследованиями, молодой человек? Плачу хорошо, мне нужен %s %s." -- If you don't know how it's working, Just check in sh_advhandler.lua in dialogue.
QUEST.quickRewards = {
    currency = 7200,
	    items = {
        { uid = "chzo", amount = 1, data = {} },
    }   
}

QUEST.randomItem = { --
    { uid = "food_ruchkasamodrochka7", min = 1, max = 1 },
}

function QUEST:GenerateData( player )
    local tbl = {}
    for i = 0, 0 do
        local idat = table.Random( self.randomItem )
        tbl[ idat.uid ] = math.random( idat.min, idat.max )
    end
    return tbl
end

function QUEST:CanComplete( player, data )
    for uid, num in pairs( data ) do
        if !player:getChar():getInv():hasItem( uid ) then
            return false
        end
    end
    return true
end

function QUEST:RemoveQuestItem( player, data )
    for uid, num in pairs( data ) do
        player:getChar():getInv():remove(player:getChar():getInv():hasItem( uid ):getID(), false, false)
    end
end

function QUEST:PostReward( player, data )
    return true
end

PLUGIN:RegisterQuest( QUEST.uniqueID, QUEST )
---------------------------------
local QUEST = {}
QUEST.uniqueID = "leader_dolg"
QUEST.name = "Вступить в долг"
--QUEST.desc = "Принеси %s %s и можешь быть уверен, что ты станешь один из нас." -- If you don't know how it's working, Just check in sh_advhandler.lua in dialogue.
QUEST.quickRewards = {
    currency = 0,
	    items = {
        { uid = "", amount = 1, data = {} },
    }   
}

QUEST.randomItem = { --
    { uid = "freedomkombezveter", min = 1, max = 1 },
}

function QUEST:GenerateData( player )
    local tbl = {}
    for i = 0, 0 do
        local idat = table.Random( self.randomItem )
        tbl[ idat.uid ] = math.random( idat.min, idat.max )
    end
    return tbl
end

function QUEST:CanComplete( player, data )
    for uid, num in pairs( data ) do
        if !player:getChar():getInv():hasItem( uid ) then
            return false
        end
    end
    return true
end

function QUEST:RemoveQuestItem( player, data )
    for uid, num in pairs( data ) do
        player:getChar():getInv():remove(player:getChar():getInv():hasItem( uid ):getID(), false, false)
    end
end

function QUEST:PostReward( player, data )
    return true
end

PLUGIN:RegisterQuest( QUEST.uniqueID, QUEST )
---------------------------------
local QUEST = {}
QUEST.uniqueID = "bandit_informator1"
QUEST.name = "Вступление в бандиты через информатора."
--QUEST.desc = "Принеси %s %s и можешь быть уверен, что ты станешь один из нас." -- If you don't know how it's working, Just check in sh_advhandler.lua in dialogue.
QUEST.quickRewards = {
    currency = 0,
	    items = {}   
}

QUEST.randomItem = { --
    { uid = "", min = 1, max = 1 },
}


function QUEST:GenerateData( player )
    --[[local tbl = {}
    for i = 0, 0 do
        local idat = table.Random( self.randomItem )
        tbl[ idat.uid ] = math.random( idat.min, idat.max )
    end
    return tbl]]
end

function QUEST:CanComplete( player, data )
    for uid, num in pairs( data ) do
        if !player:getChar():getInv():hasItem( uid ) then
            return false
        end
    end
    return true
end

function QUEST:RemoveQuestItem( player, data )
    for uid, num in pairs( data ) do
        player:getChar():getInv():remove(player:getChar():getInv():hasItem( uid ):getID(), false, false)
    end
end

function QUEST:PostReward( player, data )
    return true
end

PLUGIN:RegisterQuest( QUEST.uniqueID, QUEST )
---------------------------------
local QUEST = {}
QUEST.uniqueID = "bandit_informator2"
QUEST.name = "Вступление в военных через информатора."
--QUEST.desc = "Принеси %s %s и можешь быть уверен, что ты станешь один из нас." -- If you don't know how it's working, Just check in sh_advhandler.lua in dialogue.
QUEST.quickRewards = {
    currency = 0,
	    items = {}   
}

QUEST.randomItem = { --
    { uid = "", min = 1, max = 1 },
}


function QUEST:GenerateData( player )
    --[[local tbl = {}
    for i = 0, 0 do
        local idat = table.Random( self.randomItem )
        tbl[ idat.uid ] = math.random( idat.min, idat.max )
    end
    return tbl]]
end

function QUEST:CanComplete( player, data )
    for uid, num in pairs( data ) do
        if !player:getChar():getInv():hasItem( uid ) then
            return false
        end
    end
    return true
end

function QUEST:RemoveQuestItem( player, data )
    for uid, num in pairs( data ) do
        player:getChar():getInv():remove(player:getChar():getInv():hasItem( uid ):getID(), false, false)
    end
end

function QUEST:PostReward( player, data )
    return true
end

PLUGIN:RegisterQuest( QUEST.uniqueID, QUEST )
---------------------------------
--- BUYER QUEST
--- BUYER QUEST
local QUEST = {}
QUEST.uniqueID = "chzo"
QUEST.name = "ЧЗО"
QUEST.desc = "Мне требуются некоторые образцы для исследований, а именно... Щупальца кровососа. Не важно где Вы их достанете, главное, чтобы они были как можно свежее. Возвращайтесь в лабораторию как можно быстрее, после того как соберёте всё, что мне нужно." -- If you don't know how it's working, Just check in sh_advhandler.lua in dialogue.
QUEST.quickRewards = {
    currency = 4200,
	    items = {
        { uid = "chzo", amount = 1, data = {} },
    }   
}

QUEST.randomItem = { --
    { uid = "food_ruchkasamodrochka7", min = 1, max = 1 },
}

function QUEST:GenerateData( player )
    local tbl = {}
    for i = 0, 0 do
        local idat = table.Random( self.randomItem )
        tbl[ idat.uid ] = math.random( idat.min, idat.max )
    end
    return tbl
end

function QUEST:CanComplete( player, data )
    for uid, num in pairs( data ) do
        if !player:getChar():getInv():hasItem( uid ) then
            return false
        end
    end
    return true
end

function QUEST:RemoveQuestItem( player, data )
    for uid, num in pairs( data ) do
        player:getChar():getInv():remove(player:getChar():getInv():hasItem( uid ):getID(), false, false)
    end
end

function QUEST:PostReward( player, data )
    return true
end

PLUGIN:RegisterQuest( QUEST.uniqueID, QUEST )
--- COLLECT ONE ARTIFACT FOR SOMEONE
--- THE ITEM HAS TO BE COLLECTED WILL BE RANDOMIZED IN randomItem.
local QUEST = {}
QUEST.uniqueID = "mnash"
QUEST.name = "Зачистка"
QUEST.desc = "Командир обеспокоен ростом числа незаконных проникновений через охраняемый периметр. Он хочет, чтобы ты зачистил территорию от посторонних лиц. Принеси мне %s." -- If you don't know how it's working, Just check in sh_advhandler.lua in dialogue.
QUEST.quickRewards = {
    currency = 4200,
	    items = {
        { uid = "cw_makarov", amount = 1, data = {} },
		{ uid = "cw_vss", amount = 1, data = {} },
		{ uid = "cw_ak74", amount = 1, data = {} },
		{ uid = "cw_mp5", amount = 1, data = {} },
		{ uid = "cw_ws_mosin", amount = 1, data = {} },
		{ uid = "cw_p99", amount = 1, data = {} },
    }   
}

QUEST.randomItem = { --
    { uid = "pbandit1", min = 1, max = 1 },
	{ uid = "pclearsky", min = 1, max = 1 },
	{ uid = "pfreedom", min = 1, max = 1 },
	{ uid = "pmerc", min = 1, max = 1 },
}

function QUEST:GenerateData( player )
    local tbl = {}
    for i = 0, 0 do
        local idat = table.Random( self.randomItem )
        tbl[ idat.uid ] = math.random( idat.min, idat.max )
    end
    return tbl
end

function QUEST:CanComplete( player, data )
    for uid, num in pairs( data ) do
        if !player:getChar():getInv():hasItem( uid ) then
            return false
        end
    end
    return true
end

function QUEST:RemoveQuestItem( player, data )
    for uid, num in pairs( data ) do
        player:getChar():getInv():remove(player:getChar():getInv():hasItem( uid ):getID(), false, false)
    end
end

function QUEST:PostReward( player, data )
    return true
end

PLUGIN:RegisterQuest( QUEST.uniqueID, QUEST )
---------------------------------
--- HOENYA HIDEOUT QUEST
--- COLELCT ONE ITEM FOR SOMEONE
--- THE ITEM HAS TO BE COLLECTED WILL BE RANDOMIZED IN randomItem.

local QUEST = {}
QUEST.uniqueID = "psi1"
QUEST.name = "Ящик-Ч"
QUEST.desc = "Принеси мне «Чёрный ящик» с разбитого вертолёта Ми-24 на Янтаре. Возвращайся как можно быстрее, информация с ящика не должна достаться посторонним лицам." -- If you don't know how it's working, Just check in sh_advhandler.lua in dialogue.
QUEST.quickRewards = {
    currency = 2500,
    items = {
        { uid = "nopsihelem", amount = 1, data = {} },
    }   
}

--[[QUEST.desc = "Сталкер, принеси мне «Чёрный ящик» с разбитого вертолёта на Янтаре. Я хорошо заплачу и, возможно, поделюсь с тобой информацией о военных." -- If you don't know how it's working, Just check in sh_advhandler.lua in dialogue.
QUEST.quickRewards = {
    currency = 41500,
	items = {}  
}]]

QUEST.randomItem = { --
    { uid = "blackbox", min = 1, max = 1 },
}

function QUEST:GenerateData( player )
    local tbl = {}
    for i = 0, 0 do
        local idat = table.Random( self.randomItem )
        tbl[ idat.uid ] = math.random( idat.min, idat.max )
        print( 'inserted '.. idat.uid )
    end
    return tbl
end

function QUEST:CanComplete( player, data )
    for uid, num in pairs( data ) do
        if !player:getChar():getInv():hasItem( uid ) then
 		    return false
        end
    end
    return true
end

function QUEST:RemoveQuestItem( player, data )
    for uid, num in pairs( data ) do
        player:getChar():getInv():remove(player:getChar():getInv():hasItem( uid ):getID(), false, false)
    end
end

function QUEST:PostReward( player, data )
    print( 'PostReward')
    return true
end

PLUGIN:RegisterQuest( QUEST.uniqueID, QUEST )

---------------------------------
--- BUYER QUEST
--- COLLECT ONE ARTIFACT FOR SOMEONE
---------------------------------
--- HOENYA HIDEOUT QUEST
--- COLELCT ONE ITEM FOR SOMEONE
--- THE ITEM HAS TO BE COLLECTED WILL BE RANDOMIZED IN randomItem.
---------------------------------
--- HOENYA HIDEOUT QUEST
--- COLELCT ONE ITEM FOR SOMEONE
--- THE ITEM HAS TO BE COLLECTED WILL BE RANDOMIZED IN randomItem.

local QUEST = {}
QUEST.uniqueID = "psi2"
QUEST.name = "Починка пси-шлема"
QUEST.desc = "Если вы найдете пси-шлем, то немедленно приступим к калибровке, это будет стоить Вам 40000 рублей. Не сомневайтесь, молодой человек. Калибровка шлема позволяет добиться максимальной защиты от пси-излучения. Вы сможете свободно бродить по всей Зоне, без какого-то ущерба рассудку! Ну что ж, прототип есть у военных, но если Вы собираетесь сотрудничать с ними, то Вам потребуется пропуск ЧЗО." -- If you don't know how it's working, Just check in sh_advhandler.lua in dialogue.
QUEST.quickRewards = {
    currency = -40000,
    items = {
        { uid = "psihelem", amount = 1, data = {} },
    }     
}

QUEST.randomItem = { --
    { uid = "nopsihelem", min = 1, max = 1 },
}

function QUEST:GenerateData( player )
    local tbl = {}
    for i = 0, 0 do
        local idat = table.Random( self.randomItem )
        tbl[ idat.uid ] = math.random( idat.min, idat.max )
        print( 'inserted '.. idat.uid )
    end
    return tbl
end

function QUEST:CanComplete( player, data )
    for uid, num in pairs( data ) do
        if !player:getChar():getInv():hasItem( uid ) then
 		    return false
        end
    end
    return true
end

function QUEST:RemoveQuestItem( player, data )
    for uid, num in pairs( data ) do
        player:getChar():getInv():remove(player:getChar():getInv():hasItem( uid ):getID(), false, false)
    end
end

function QUEST:PostReward( player, data )
    print( 'PostReward')
    return true
end

PLUGIN:RegisterQuest( QUEST.uniqueID, QUEST )