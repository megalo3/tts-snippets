TurnPositionKeys = {'advance1','advance2','advance3','advance4','advance5','advance6','advance7'}

-- num,color,selfref
function moveTurnTrack(input)
    if settings.setupComplete == false then return end
    local originalNum = removeColor(input.color)
    table.insert(settings.turnTrack[input.num], input.color)

    local gameBoard = getGameBoard()
    local turnPos = getSnapPositionsWithAnyTagsPositionedToWorld(gameBoard, TurnPositionKeys)
    local pos = turnPos[input.num]

    local token = getObjectsWithAllTags({input.color, 'turnordertoken'})[1]
    token.setPositionSmooth({pos[1], 3, pos[3]})
    Wait.time(function() resetHeights(input.num) end, 1)
    Wait.time(function() resetHeights(originalNum) end, 1)
end

function setAdvanceButtons()
    local gameBoard = getGameBoard()
    local positions = getSnapPositionsWithAnyTags(gameBoard, TurnPositionKeys)
    for index, pos in ipairs(positions) do
        gameBoard.createButton({
            click_function = "moveTrack" ..  index,
            function_owner = Global,
            position       = {pos[1]*-1,pos[2],pos[3]},
            rotation       = {0, 0, 0},
            width          = 125,
            height         = 125,
            color          = {1, 1, 1, 0.5},
            hover_color    = {1, 1, 1, 0.5},
            font_color     = {1, 1, 1},
            tooltip        = 'Advance'
        })
    end
end
function moveTrack1(a,b,c) moveTrack(1,a,b,c,self) end
function moveTrack2(a,b,c) moveTrack(2,a,b,c,self) end
function moveTrack3(a,b,c) moveTrack(3,a,b,c,self) end
function moveTrack4(a,b,c) moveTrack(4,a,b,c,self) end
function moveTrack5(a,b,c) moveTrack(5,a,b,c,self) end
function moveTrack6(a,b,c) moveTrack(6,a,b,c,self) end
function moveTrack7(a,b,c) moveTrack(7,a,b,c,self) end
function moveTrack(num,object,color,altclick,obj)
    moveTurnTrack({num = num,color = color,selfref = self})
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

function resetHeights(spot)
    local gameBoard = getGameBoard()
    local turnPos = getSnapPositionsWithAnyTagsPositionedToWorld(gameBoard, TurnPositionKeys)

    for index, color in ipairs(settings.turnTrack[spot]) do
        local token = getObjectsWithAllTags({color, 'turnordertoken'})[1]
        -- local pos = token.getPosition()
        local pos = turnPos[spot]
        token.setPositionSmooth({pos[1],Positions.TurnOrderY[index],pos[3]})
    end
end

function removeUnusedTurnOrderTokens()
    for _, color in ipairs(getNonSeatedPlayerColors()) do
        local token = getObjectsWithAllTags({color, 'turnordertoken'})[1]
        SetupBag.putObject(token)
    end
    settings.turnTrack[1] = shuffleArray(getSeatedPlayerColors())
end

function setInitialPlayerOrder()
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
    updatePlayerTurnOrder()
    yellowPrint('Randomly selecting starting player...  ' .. newOrder[playerCount] .. '!')
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
    -- removePlayerBoardHexes()
    -- setPlayerBoardInitialHexes()
    local turns = getPlayerTurnOrder()
    Turns.order = turns
    Turns.turn_color = turns[1]
end

function startNewRound()
    updatePlayerTurnOrder()
    moveWhiteDie(Turns.order[1])
end