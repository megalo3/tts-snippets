isRolling = false
FailedBlightDrawAttempt = 0

function runNecroTurn()
    if isRolling == false then
        rollnecroDie(getNecroLocation())
    end
end

function getNecroLocation()
    local necromancer = getObjectsWithAllTags({'Necromancer', 'Pawn'})[1]
    return findPawnLocation(necromancer)
end

function rollnecroDie(location)
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
        moveNecromancer(dieValue, location)

        return 1
    end
    startLuaCoroutine(Global, "coroutine_monitorDice")
end

function moveNecromancer(dieValue, location)
    local gateCount = blightCount('Gate')
    local dieRollMessage = 'The Necromancer rolls a ' .. dieValue .. '.'
    local detectedDieValue = dieValue
    if gateCount > 0 then
        detectedDieValue = dieValue + gateCount
        dieRollMessage = dieRollMessage .. ' Roll increased to ' .. dieValue .. ' by the Gate Blight(s).'
    end
    print(dieRollMessage)

    local detected = getDetectedCharacters(detectedDieValue)
    local newLocation = ''
    if #detected > 0 then
        local names = ''
        for index, d in ipairs(detected) do
            if index > 1 and index == #detected then
                if #detected > 2 then
                    names = names .. ','
                end
                names = names .. ' and '
            end
            if index > 1 and index != #detected then
                names = names .. ', '
            end

            names = names .. d.getName()
        end
        printToAll(names .. ' detected!', stringColorToRGB('Yellow'))

        -- The Gate Blight causes the Necromancer to teleport to a random detected hero
        if gateCount > 0 then
            local chosenIndex = rand(#detected)
            local chosenCharacter = detected[chosenIndex]
            printToAll('The Necromancer chooses the ' .. chosenCharacter.getName() .. '.', stringColorToRGB('Yellow'))
            newLocation = findPawnLocation(chosenCharacter)
        else
            -- Find the closest pawns
            local closeCharacters = findClosestCharacters(location, detected)
            local chosenIndex = rand(#closeCharacters)
            local chosenCharacter = closeCharacters[chosenIndex]

            -- Pathfind the best route randomly breaking ties
            newLocation = getBestRoute(location, chosenCharacter)
            if #closeCharacters > 1 then
                printToAll('The Necromancer chooses the ' .. chosenCharacter.getName() .. '.', stringColorToRGB('Yellow'))
            end
        end

    else
        -- No characters detected
        newLocation = LocationDirection[location][dieValue]
    end

    if gateCount > 0 then
        printToAll('The Necromancer uses the Gate Blight to teleport to the ' .. newLocation .. '.', stringColorToRGB('Green'))
    else
        printToAll('The Necromancer ' .. movesOrStays(location, newLocation) .. ' the ' .. newLocation, stringColorToRGB('Green'))
    end

    drawCard({ Target = 'Discard', Type = 'Map' })
    local necromancer = getObjectsWithAllTags({'Necromancer', 'Pawn'})[1]
    necromancer.setPositionSmooth(LocationPosition[newLocation])
    deployBlight(newLocation)

    -- Increase Quests DM
    if Settings.difficultyOptions[8] == 1 then
        Wait.time(function()
            local info = getMapCardInfo()
            if info.Quest ~= '' then
                print(info.Quest)
                local zone = getObjectsWithAllTags({'Zone', 'Quest'})[1]
                local deck = getDeckFromZone(zone)
                deck.takeObject({
                    position = LocationPosition[info.Quest],
                    flip = true
                })
            end
        end, 1.45)
    end
end

function movesOrStays(location, newLocation)
    local movesOrStays = 'moves to'
    if location == newLocation then
        movesOrStays = 'stays in'
    end
    return movesOrStays
end

function rand(number)
    return math.ceil(math.random() * number)
end

function getBestRoute(necroLocation, pawn)
    local pawnLocation = findPawnLocation(pawn)
    -- If the Necromancer is already at the location, he stays there
    if necroLocation == pawnLocation then return necroLocation end
    -- The Village is one away from everything
    if necroLocation == 'Village' then return pawnLocation end
    local path = LocationPathfinding[necroLocation][pawnLocation]
    -- If the path doesn't exist, the Village is the closest
    if path == nil then return 'Village' end
    if #path == 2 then
        printToAll('The Necromancer randomly chooses between equidistant detected characters.', stringColorToRGB('Green'))
        return path[rand(2)]
    end
    return path[1]
end

function findClosestCharacters(necroLocation, characters)
    local closeLocations = LocationProximity[necroLocation]
    local closeCharacters = {}
    local sameLocationCharacters = {}
    for _, character in ipairs(characters) do
        local location = findPawnLocation(character)
        if location == necroLocation then
            table.insert(sameLocationCharacters, character)
        end
        if includes(closeLocations, location) then
            table.insert(closeCharacters, character)
        end
    end

    if #closeCharacters == 0 then
        closeCharacters = characters
    end
    if #sameLocationCharacters > 0 then
        return sameLocationCharacters
    end
    return closeCharacters
end

function getDetectedCharacters(die)
    local boardZone = getObjectsWithAllTags({'Board', 'Zone'})[1]
    local detected = {}
    for _, object in ipairs(boardZone.getObjects()) do
        local character = object.getName()
        if object.hasTag('Pawn') and character != 'Necromancer' then
            if notInMonastery(object) then
                local secrecy = getCharacterSecrecy(character)
                if die > secrecy then
                    table.insert(detected, object)
                end
            end
        end
    end
    return detected
end

function notInMonastery(character)
    return 'Monastery' != findPawnLocation(character)
end

function deployBlight(newLocation)
    local waitTime = 1.3
    if isDeckEmpty('Map') then waitTime = waitTime + 1.3 end
    Wait.time(function() attemptDeployBlight(newLocation)  end, waitTime)
end

function attemptDeployBlight(newLocation)
    local didDeploy = createBlight(newLocation)
    if didDeploy == false then
        FailedBlightDrawAttempt = FailedBlightDrawAttempt + 1
        if FailedBlightDrawAttempt < 3 then
            printToAll('Drawing a new map card.', stringColorToRGB('Green'))
            drawCard({ Target = 'Discard', Type = 'Map' })
            return deployBlight(newLocation)
        else
            printToAll('Three map cards have been drawn with no available blight tokens. Create a blight of your choice.', stringColorToRGB('Yellow'))
        end
    else
        -- Map draw succeeded
        FailedBlightDrawAttempt = 0
        print('It is now the Hero Turn.')

        for _, token in ipairs(getObjectsWithAllTags({'Activity'})) do
            token.setRotationValue("Active")
        end
    end
end

function getCharacterSecrecy(character)
    local characterSheet = getObjectsWithAllTags({'Character Sheet', character})[1]
    local token = getSecrecyToken(characterSheet)
    return getSecrecyValue(characterSheet, token)
end

function getSecrecyToken(sheet)
    local pos = sheet.getPosition()
    local hitList = Physics.cast({
        origin       = pos,
        direction    = {0,1,0},
        type         = 3,
        size         = { 7.69, 1, 5.11},
        max_distance = 1
    })

    for _, value in ipairs(hitList) do
        if value.hit_object.hasTag('Secrecy') then
            return value.hit_object
        end
    end
end

function getSecrecyValue(sheet, token)
    local position = round(sheet.positionToLocal(token.getPosition())[1], 2)
    for index, value in ipairs(SecrecyPositions) do
        if value == position then
            return index - 1
        end
    end
    return 0
end

-- Lua doesn't have a round function!
function round(number, places)
    local mult = 10^(places or 0)
    return math.floor(number * mult + 0.5) / mult
end

function includes(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return true end
    end
    return false
end

SecrecyPositions = {.90, .73, .55, .38, .2, .02, -0.15, -0.33, -0.51, -0.68}

-- Either he's already in the location or he goes through the village
LocationPathfinding = {
    Mountains = {
        Castle = { 'Castle' },
        Swamp = { 'Village', 'Castle' }
    },
    Castle = {
        Mountains = { 'Mountains' },
        Ruins = { 'Village', 'Swamp' },
        Swamp = { 'Swamp' }
    },
    Swamp = {
        Castle = { 'Castle' },
        Ruins = { 'Ruins' },
        Mountains = { 'Village', 'Castle' }
    },
    Forest = {
        Swamp = { 'Village', 'Ruins' },
        Ruins = { 'Ruins' }
    },
    Ruins = {
        Forest = { 'Forest' },
        Castle = { 'Village', 'Swamp' },
        Swamp = { 'Swamp' }
    }
}
-- Only locations that are 1 away. Everything else is 2
LocationProximity = {
    Mountains = { 'Village', 'Castle' },
    Castle = { 'Mountains', 'Village', 'Swamp' },
    Swamp = { 'Castle', 'Village', 'Ruins' },
    Forest = { 'Village', 'Ruins' },
    Ruins = { 'Forest', 'Village', 'Swamp' },
    Village = { 'Mountains', 'Castle', 'Swamp', 'Forest', 'Ruins' }
}
Locations = {'Mountains', 'Monastery', 'Forest', 'Castle', 'Village', 'Swamp', 'Ruins'}
LocationPosition = {
    Mountains = {-7.91, 2, 19.40},
    Castle = {10.48, 2, 18.57},
    Village = {-0.79, 2, 12.62},
    Swamp = {9, 2, 12.59},
    Forest = {-1.68, 2, 6.24},
    Ruins = {8.57, 2, 6.18}
}
LocationDirection = {
    Mountains = {
        'Castle',
        'Village',
        'Mountains',
        'Village',
        'Castle',
        'Mountains'
    },
    Castle = {
        'Swamp',
        'Village',
        'Mountains',
        'Castle',
        'Village',
        'Castle'
    },
    Village = {
        'Mountains',
        'Ruins',
        'Forest',
        'Castle',
        'Swamp',
        'Village'
    },
    Swamp = {
        'Ruins',
        'Village',
        'Castle',
        'Swamp',
        'Village',
        'Swamp'
    },
    Forest = {
        'Village',
        'Ruins',
        'Forest',
        'Village',
        'Ruins',
        'Forest'
    },
    Ruins = {
        'Forest',
        'Swamp',
        'Village',
        'Ruins',
        'Village',
        'Ruins'
    }
}