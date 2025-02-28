function switchGameBoard()
    local board34p = getObjectFromGUID(Guids.Boards.mainboard34p)
    local board2p = getObjectFromGUID(Guids.Boards.mainboard2p)
    if board34p ~= nil then
        board34p.setLock(false)
        SetupBag.putObject(board34p)
        local board2p = SetupBag.takeObject({
            guid = Guids.Boards.mainboard2p,
            position = {0,0.97,0},
            rotation = {0,180,0},
            smooth = false
        })
        board2p.setLock(true)
    else
        board2p.setLock(false)
        SetupBag.putObject(board2p)
        local board34p = SetupBag.takeObject({
            guid = Guids.Boards.mainboard34p,
            position = {0,0.97,0},
            rotation = {0,180,0},
            smooth = false
        })
        board34p.setLock(true)
    end
end

function setShields()
    -- Remove Shield #2 if playing AI
    if settings.playstyle == 'ai' then
        local shield2 = ShieldBag.takeObject({guid = Guids.Shield2})
        SetupBag.putObject(shield2)
    end
    if settings.components.shields == true then
        local tgplacements = {'tgplace11','tgplace21','tgplace31','tgplace41','tgplace51','tgplace61'}
        if settings.playercount == 3 or settings.playercount == 4 then
            table.insert(tgplacements, 'tgplace22')
            table.insert(tgplacements, 'tgplace42')
            table.insert(tgplacements, 'tgplace62')
        end
        if settings.playercount == 4 then
            table.insert(tgplacements, 'tgplace12')
            table.insert(tgplacements, 'tgplace32')
            table.insert(tgplacements, 'tgplace52')
        end

        local gameBoard = getGameBoard()
        local snaps = gameBoard.getSnapPoints()
        local waitCounter = 1

        for _, snap in ipairs(snaps) do
            if #snap.tags > 0 then
                if has_any_value(snap.tags, tgplacements) then
                    Wait.time(function()
                        local pos = gameBoard.positionToWorld(snap.position)
                        local shield = ShieldBag.takeObject({position = pos})
                        shield.setRotationSmooth({0, snap.rotation.y - 180, 0})
                        shield.addTag('shield')
                    end, waitCounter * DeploySpeed)
                    waitCounter = waitCounter + 1
                end
            end
        end
    else
        SetupBag.putObject(ShieldBag)
    end
end

function setPlayerBoards()
    setNormalPlayerBoards()
    setSoloPlayerBoards()
    setTeamPlayerBoards()
    updateHandLocations()
end

function setNormalPlayerBoards()
    local playerCount = #(getSeatedPlayers())
    if settings.playstyle == 'normal' or settings.playstyle == 'ai' then
        setPlayerDuchyNumber()
        removeUnusedPlayerBoards()
        if settings.playstyle == 'ai' and playerCount == 4 then
            settings.playstyle = 'normal'
            redPrint('You cannot play Chateauma with 4 players. Setting up the game normally.')
        end
        if settings.playstyle == 'ai' and playerCount < 4 then
            setAiPlayerBoard()
            -- Players random first player. The Châteauma is always the last player.
            -- Add AI player token back to order track
            if settings.aimodes.c == true then
                settings.turnTrack[1] = tableConcat(settings.turnTrack[1],{settings.aiPlayerColor})
            else
                settings.turnTrack[1] = tableConcat({settings.aiPlayerColor},settings.turnTrack[1])
            end
        end
    else
        removePlayerDuchies()
    end
end

function setSoloPlayerBoards()
    if settings.playstyle == 'beginnersolo' then
        local board = SetupBag.takeObject({guid = Guids.Boards.beginnersolo, position = {30.00, 0.97, -14.00}, rotation = {0,180,0}})
        board.setLock(true)
    end
    if settings.playstyle == 'advancedsolo' then
        local board = SetupBag.takeObject({guid = Guids.Boards.advancedsolo, position = {30.00, 0.97, -14.00}, rotation = {0,180,0}})
        board.setLock(true)
    end
end

function setTeamPlayerBoards()
    if settings.playstyle == 'beginnerteamgame' then
        local board = SetupBag.takeObject({guid = Guids.Boards.teams31pb, position = {34.5, 0.97, 0}})
        board.setRotation({0,180,0})
        board.setLock(true)
        board = SetupBag.takeObject({guid = Guids.Boards.teams31yr, position = {-34.5, 0.97, 0}})
        board.setRotation({0,180,0})
        board.setLock(true)
    end
    if settings.playstyle == 'advancedteamgame' then
        local board = SetupBag.takeObject({guid = Guids.Boards.teams32pb, position = {34.5, 0.97, 0}})
        board.setRotation({0,180,0})
        board.setLock(true)
        board = SetupBag.takeObject({guid = Guids.Boards.teams32yr, position = {-34.5, 0.97, 0}})
        board.setRotation({0,180,0})
        board.setLock(true)
    end
end

function updateHandLocations()
    if settings.playstyle == 'beginnerteamgame' or settings.playstyle == 'advancedteamgame' or settings.playstyle == 'beginnersolo' or settings.playstyle == 'advancedsolo' then
        local hand = getObjectFromGUID(Guids.Hands.Red)
        hand.setPosition({-26.5,3.35, -36})
        hand.setRotation({0,0,0})
        hand = getObjectFromGUID(Guids.Hands.Yellow)
        hand.setPosition({-42,3.35, -36})
        hand.setRotation({0,0,0})
        hand = getObjectFromGUID(Guids.Hands.Blue)
        hand.setPosition({42.5,3.35, -36})
        hand = getObjectFromGUID(Guids.Hands.Purple)
        hand.setPosition({27,3.35, -36})
    end
end

function setGameBoard()
    settings.gameboard = '2p'
    if settings.playercount > 2 then
        settings.gameboard = '34p'
    end
    if settings.playstyle == 'beginnersolo' or settings.playstyle == 'advancedsolo' then
        settings.gameboard = '2p'
    end
     if settings.playstyle == 'beginnerteamgame' or settings.playstyle == 'advancedteamgame' then
        settings.gameboard = '34p'
    end

    -- Switch to the 3-4 player board
    if settings.gameboard == '34p' then
        local board2p = getObjectFromGUID(Guids.Boards.mainboard2p)
        board2p.setLock(false)
        SetupBag.putObject(board2p)
        local board34p = SetupBag.takeObject({
            guid = Guids.Boards.mainboard34p,
            position = {0,0.97,0},
            rotation = {0,180,0},
            smooth = false
        })
        board34p.setLock(true)
    end

    setTradeGoods()
    Wait.time(function()
       deployTradeGoods('tgslota')
    end, DeploySpeed * 2.1)

    supplyGameBoardHexes()
    setVictoryTokens()
    setAdvanceButtons()
    resetHeights(1)
    Wait.time(function() setShields() end, 1)
end

function getGameBoard()
    if settings.gameboard == '2p' then return getObjectFromGUID(Guids.Boards.mainboard2p) end
    return getObjectFromGUID(Guids.Boards.mainboard34p)
end

function setVictoryToken(board, snap, color)
    if has_value(snap.tags, color) then
        local pos = board.positionToWorld(snap.position)
        SetupBag.takeObject({guid = Guids.Tokens[color .. '234'], position = pos})
        SetupBag.takeObject({guid = Guids.Tokens[color .. '567'], position = {pos[1], 1.5, pos[3]}})
    end
end

function setVictoryTokens()
    local board = getGameBoard()
    local snaps = board.getSnapPoints()
    local waitCounter = 1

    for _, snap in ipairs(snaps) do
        if #snap.tags > 0 and not has_value(snap.tags, 'victory100') then
            Wait.time(function()
                if settings.rules.borderpostscoring == true then
                    setVictoryToken(board, snap, 'borderpost')
                end
                setVictoryToken(board, snap, 'Tan')
                setVictoryToken(board, snap, 'Red')
                setVictoryToken(board, snap, 'Blue')
                setVictoryToken(board, snap, 'Black')
                setVictoryToken(board, snap, 'Green')
                setVictoryToken(board, snap, 'Yellow')
            end, waitCounter * DeploySpeed)
        waitCounter = waitCounter + 1
        end
    end
end

function setPlayerDuchyNumber()
    -- Loop through all players and set board numbers
    for _, color in ipairs(getSeatedPlayerColors()) do
        if (settings.randomboard) then
            settings.mapNumberIndex[color] = rand(#settings.availableBoards)
        end
        local playerBoard = getObjectsWithAllTags({color, 'playerboard'})[1]
        setMap(settings.mapNumberIndex[color], color, playerBoard)
    end
end

function removeUnusedPlayerBoards()
    for _, color in ipairs(getNonSeatedPlayerColors()) do
        removePlayerDuchy(color)
    end
end

function getAiBoardGuid()
    local guid = Guids.Boards.aiboard35
    if settings.aimodes.a == true or settings.aimodes.b == true or settings.aimodes.d == true then
        guid = Guids.Boards.aiboard36
    end
    return guid
end

function setAiPlayerBoard()
    local nonSeated = getNonSeatedPlayerColors()
    if #nonSeated < 1 then return end
    settings.aiPlayerColor = nonSeated[1]
    local aiBoard = SetupBag.takeObject({
        guid = getAiBoardGuid(),
        position = Positions.PlayerBoards[settings.aiPlayerColor],
        rotation = {0,180,0},
        smooth = false
    })
    aiBoard.setLock(true)
end

function removePlayerDuchy(color)
    despawnNumberTiles(color)
    for _, item in ipairs(getObjectsWithAllTags({'playerboard', color})) do
        item.setLock(false)
        SetupBag.putObject(item)
    end
    for _, item in ipairs(getObjectsWithAllTags({'victory100', color})) do
        item.setLock(false)
        SetupBag.putObject(item)
    end
    for _, item in ipairs(getObjectsWithAllTags({'vineyard', color})) do
        item.setLock(false)
        SetupBag.putObject(item)
    end
end

function setPlayerBoardDuchyButtons()
    for _, color in ipairs(Colors) do
        local board = getObjectsWithAllTags({color, 'playerboard'})[1]
        if board ~= nil then
            board.setVar('Color', color)
            setDuchyButtons(board)
        end
    end
end

function removePlayerDuchies()
    for _, color in ipairs(Colors) do
        removePlayerDuchy(color)
    end
end