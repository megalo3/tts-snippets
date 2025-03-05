function rollQuest()
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

        addQuest(dieValue)

        return 1
    end
    startLuaCoroutine(self, "coroutine_monitorDice")
end

function addQuest(number)
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
end