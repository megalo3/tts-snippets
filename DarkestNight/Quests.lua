Quests = {
    rollQuest = function()
        local necroDie = getObjectsWithAllTags({'Necromancer', 'Die'})[1];
        necroDie.roll()

        isRolling = true
        function coroutine_monitorDice()
            repeat
                local allRest = true
                if necroDie ~= nil and necroDie.resting == false then
                    allRest = false
                end
                coroutine.yield(0)
            until allRest == true

            isRolling = false
            local dieValue = necroDie.getRotationValue()

            Quests.addQuest(dieValue)

            return 1
        end
        startLuaCoroutine(self, "coroutine_monitorDice")
    end,

    addQuest = function(number)
        local direction = LocationDirection['Village']
        local location = direction[number]
        print('Spawning a quest in the ' .. location .. '.')
        local pos = LocationPosition[location]

        local zone = getObjectsWithAllTags({'Quest', 'Zone'})[1];
        local deckObj = getDeckFromZone(zone)
        local deck = getObjectFromGUID(deckObj.guid)
        deck.takeObject({
            position = {pos[1],pos[2],pos[3]},
            flip = true
        })
    end,

    addTime = function(card)
        print('Adding time to ' .. card.getName() .. ' quest.')
        Quests.addToken(card, 'Time')
    end,

    addQuestTimers = function()
        print('Adding time to quests.')
        local zone = getObjectsWithAllTags({'Zone', 'Board', 'Quest'})[1]
        local cards = zone.getObjects()
        for _, card in ipairs(cards) do
            Quests.addToken(card, 'Time')
        end
    end,

    addToken = function(card, valueType)
        if card.type =='Card' then
            local value = Quests.getCardValue(card, valueType)
            local count = Quests.getTokenCount(card, valueType) + 1
            if count >= value then
                if valueType == 'Time' then
                    printToAll('Quest "' .. card.getName() .. '" has expired!', stringColorToRGB('Yellow'))
                end
                if valueType == 'Progress' then
                    printToAll('Quest "' .. card.getName() .. '" has been successfully completed!', stringColorToRGB('Yellow'))
                end
            end
            -- Get tokens on top of card
            -- See if the quest will expire with the next token added
            local pos = Quests.getTokenPosition(card, valueType)
            local bag = nil;
            if valueType == 'Time' then bag = getTimeBag() end
            if valueType == 'Progress' then bag = getProgressBag() end
            bag.takeObject({
                position = {pos[1], 2, pos[3]},
                rotation = {0,180,0}
            })
        end
    end,

    addProgress = function(card)
        print('Adding progress to ' .. card.getName() .. ' quest.')
        Quests.addToken(card, 'Progress')
    end,

    getCardValue = function(card, valueType)
        local progress = 0;
        local qtime = 0;
        for p, t in (card.getDescription()):gmatch "(%d);%s?Time:%s?(%d)" do
            progress = p
            qtime = t
        end
        if valueType == 'Progress' then return tonumber(progress) end
        if valueType == 'Time' then return tonumber(qtime) end
    end,

    getTokenCount = function(card, valueType)
        local pos = Quests.getTokenPosition(card, valueType)
        local hitList = Physics.cast({
            origin       = pos,
            direction    = {0,1,0},
            type         = 3,
            size         = { 1.3, 1, 3.10},
            max_distance = 1
        })

        local timeCount = 0;
        local progressCount = 0;

        for key, value in ipairs(hitList) do
            if value.hit_object.hasTag('Time') then
                if (value.hit_object.name == 'Custom_Token_Stack') then
                    timeCount = value.hit_object.getQuantity()
                else
                    timeCount = 1
                end
            end
            if value.hit_object.hasTag('Progress') then
                if (value.hit_object.name == 'Custom_Token_Stack') then
                    progressCount = value.hit_object.getQuantity()
                else
                    progressCount = 1
                end
            end
        end

        if valueType == 'Time' then return timeCount end
        if valueType == 'Progress' then return progressCount end
    end,

    getTokenPosition =     function(card, valueType)
        local pos = card.getPosition()
        pos[3] = pos[3]+1
        if valueType == 'Time' then pos[1] = pos[1]+0.8 end
        if valueType == 'Progress' then pos[1] = pos[1]-0.8 end
        return pos
    end
}
