function moveTurnTrack(position, color)
    if settings.setupComplete == false then return end
    local originalNum = removeColor(color)
    table.insert(settings.turnTrack[position], color)

    local turnPos = getAdvancementButtonLocs()
    local pos = turnPos[position]

    local token = getObjectsWithAllTags({color, 'turnordertoken'})[1]
    if token ~= nil then
        token.setPositionSmooth({pos[1], 3, pos[3]})
        Wait.time(function() resetHeights(position) end, 1)
        if position ~= originalNum then
            Wait.time(function() resetHeights(originalNum) end, 1)
        end
    end
end

function setAdvanceButtons()
    local gameBoard = getGameBoard()
    local positions = getSnapPositionsWithAnyTags(gameBoard, {'advance'})
    local function sortingFunction(pos1, pos2) return pos1[3] > pos2[3] end
    table.sort(positions, sortingFunction)

    for colorIndex, color in ipairs(settings.turnTrack[1]) do
        for positionIndex, p in ipairs(positions) do
            local x = p[1]*-1+0.12+(colorIndex%2*0.08)
            if positionIndex > 5 then
                x = x - 0.32
            end
            local z = p[3]+0.12-(colorIndex*0.04)-(colorIndex%2*0.04)
            gameBoard.createButton({
                click_function = "moveTrack" .. color ..  positionIndex,
                function_owner = Global,
                position       = {x, p[2]+0.02, z},
                rotation       = {0, 0, 0},
                width          = 40,
                height         = 40,
                color          = ColorTintAlpha[color],
                hover_color    = ColorTintAlphaHover[color],
                tooltip        = 'Advance ' .. color .. ' to ' .. positionIndex,
            })
        end
    end
end

for _, color in ipairs(Colors) do
    for position = 1, 7 do
        _G['moveTrack' .. color .. position] = function() moveTurnTrack(position, color) end
    end
end

function removeColor(color)
    local returnIndex = 1
    for sindex, spot in ipairs(settings.turnTrack) do
        for vindex, vposColor in ipairs(spot) do
            if vposColor == color then
                returnIndex = sindex
                table.remove(settings.turnTrack[sindex], vindex)
            end
        end
    end
    return returnIndex
end

AdvancementButtonLocs = nil
function getAdvancementButtonLocs()
    if AdvancementButtonLocs == nil then
        local gameBoard = getGameBoard()
        local turnPos = getSnapPositionsWithAnyTagsPositionedToWorld(gameBoard, {'advance'})
        local function sortingFunction(pos1, pos2) return pos1[3] < pos2[3] end
        table.sort(turnPos, sortingFunction)  local gameBoard = getGameBoard()
        AdvancementButtonLocs = turnPos
    end
    return AdvancementButtonLocs
end

function resetHeights(spot)
    local turnPos = getAdvancementButtonLocs()
    for index, color in ipairs(settings.turnTrack[spot]) do
        local token = getObjectsWithAllTags({color, 'turnordertoken'})[1]
        if token ~= nil then
            local pos = turnPos[spot]
            token.setPositionSmooth({pos[1],Positions.TurnOrderY[index],pos[3]})
        end
    end
end

function removeUnusedTurnOrderTokens()
    for index, color in ipairs(getNonSeatedPlayerColors()) do
        if settings.playstyle == 'ai' and index == 1 then
        else
            local token = getObjectsWithAllTags({color, 'turnordertoken'})[1]
            SetupBag.putObject(token)
            token = getObjectsWithAllTags({color, 'victorytoken'})[1]
            SetupBag.putObject(token)
        end
    end
    settings.turnTrack[1] = getSeatedPlayerColors()
end

function setInitialPlayerOrder()
     if settings.playstyle == 'normal' or settings.playstyle == 'ai' then
        local colors = getSeatedPlayerColorsOrdered()
        local playerCount = #colors
        local start = rand(playerCount)
        local newOrder = {}

        for index = start, start + playerCount - 1 do
            local num = index;
            if index > playerCount then
                num = index%playerCount
            end
            table.insert(newOrder, colors[num])
        end

        settings.turnTrack[1] = newOrder
        yellowPrint('Randomly selecting starting player...  ' .. newOrder[playerCount] .. '!')
    elseif settings.playstyle == 'beginnerteamgame' or settings.playstyle == 'advancedteamgame' then
        settings.turnTrack[1] = {'Blue', 'Yellow', 'Purple', 'Red'}
        yellowPrint('Setting teams variant player order to Red -> Purple -> Yellow -> Blue')
    end
    if settings.playstyle == 'beginnersolo' or settings.playstyle == 'advancedsolo' then
        Turns.enable = false
        -- Remove start new round button and helper text
        getObjectFromGUID(Guids.StartNewRoundButton).destruct()
        getObjectFromGUID(Guids.StartNewRoundText).destruct()
    else
        updatePlayerTurnOrder()
    end

end

function getPlayerTurnOrder()
    -- Order by highest spot (7,6,5,4,3,2,1)
    -- Then by highest index (4,3,2,1)
    local order = {}
    for spot = #settings.turnTrack, 1, -1 do
        for index = #settings.turnTrack[spot], 1, -1 do
            table.insert(order, settings.turnTrack[spot][index])
        end
    end
    return order
end

function updatePlayerTurnOrder()
    local turns = getPlayerTurnOrder()
    Turns.order = turns
    Turns.turn_color = getFirstPlayer()
end

function getFirstPlayer()
    local turns = getPlayerTurnOrder()
    local firstPlayer = turns[1]
    if turns[1] == settings.aiPlayerColor then firstPlayer = turns[2] end
    return firstPlayer
end

function moveWhiteDie(color)
    local whiteDie = getObjectsWithTag('whitedie')[1]
    if settings.playstyle == 'ai' then
        whiteDie.setPositionSmooth(getAiWhiteDiePosition())
    else
        local playerBoard = getObjectsWithAllTags({color, 'playerboard'})[1]
        pos = getSnapPositionsWithAllTagsPositionedToWorld(playerBoard, {'whitedie', color})[1]
        whiteDie.setPositionSmooth(pos)
    end
end

function getAiWhiteDieSlot()
    local whiteDie = getObjectsWithTag('whitedie')[1]
    local value = whiteDie.getRotationValue()
    if value < 5 then
        return 1
    else
        return 2
    end
end

function getAiWhiteDiePosition()
    local aiBoard = getObjectsWithAllTags({'aiboard'})[1]
    snaps = getSnapPositionsWithAllTagsPositionedToWorld(aiBoard, {'whitedie'})
    local function sortingFunction(snap1, snap2) return snap1[1] < snap2[1] end
    table.sort(snaps, sortingFunction)
    return raisePosition(snaps[getAiWhiteDieSlot()])
end


function startNewRound()
    if settings.setupComplete == false then return end
    updatePlayerTurnOrder()
    moveWhiteDie(Turns.order[1])
end