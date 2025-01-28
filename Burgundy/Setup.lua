function setup()
    setupMenu('false')
    local playerCount = #(getSeatedPlayers())
    if settings.playstyle == 'ai'then
        playerCount = playerCount + 1
    end
    if playerCount > 4 then
        playerCount = 4
    end
    settings.playercount = playerCount

    if settings.rules.castleplacement == false then
        SetupBag.putObject(getObjectFromGUID(Guids.Text.boardrule))
    end
    if settings.rules.borderpostscoring == false then
        SetupBag.putObject(getObjectFromGUID(Guids.Text.borderscoring))
    end

    setIncludedHexes()
    removeUnusedTurnOrderTokens()
    setInitialPlayerOrder()
    Wait.time(function() setVineyards() end, 0.5)
    Wait.time(function() setTradeRoutes() end, 1.0)
    Wait.time(function() setPlayerBoards() end, 1.5)
    Wait.time(function() setGameBoard() end, 2.0)
    Wait.time(function() giveStartingItems() end, 3.0)
    Wait.time(function() settings.setupComplete = true end, 3.0)
end

function giveStartingItems()
    local function supplyWorker(playerBoard, workerAmount)
        local workerPos = getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {'worker'})[1]
        local rotation = {0,180,0}
        for i = 1, workerAmount do
            WorkerBag.takeObject({position = workerPos, rotation = rotation})
        end
    end

    local function supplyAiTradeGoods(playerBoard)
        -- Get 1 of each type of good and place on each trade good spot
        local tradeGoodBag = getObjectsWithTag('tradegoodbag')[1]
        for _, key in ipairs({'tradegood1','tradegood2','tradegood3','tradegood4','tradegood5','tradegood6'}) do
            for _, tradeGoodPos in ipairs(getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {key})) do
                local tradeGuid = getObjectGuidWithTag(tradeGoodBag, key)
                tradeGoodBag.takeObject({position = tradeGoodPos, guid = tradeGuid})
            end
        end
    end

    local function supplyTradeGoods(playerBoard)
        local tradeGoodBag = getObjectsWithTag('tradegoodbag')[1]
        local rotation = {0,150,0}
        if settings.playstyle == 'beginnerteamgame' or settings.playstyle == 'advancedteamgame' or settings.playstyle == 'beginnersolo' or settings.playstyle == 'advancedsolo' then rotation = {0,0,0} end
        for _, tradeGoodPos in ipairs(getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {'tradegood'})) do
            tradeGoodBag.takeObject({position = tradeGoodPos, rotation = rotation})
        end
    end

    local function supplyCastle(playerBoard)
        local castleBag = getObjectFromGUID(Guids.Bags.castle)
        local storagePos
        if settings.playstyle == 'beginnerteamgame' then
            storagePos = getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {'castle'})[1]
        else
            storagePos = getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {'storage'})[1]
        end
        castleBag.takeObject({position = storagePos, rotation = {0,180,0}})
    end

    local function supplyCoin(playerBoard)
        local coinBag = getObjectFromGUID(Guids.Bags.coin)
        local storagePos = getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {'coin'})[1]
        coinBag.takeObject({position = storagePos, rotation = {0,180,0}})
        if settings.playstyle == 'beginnerteamgame' or settings.playstyle == 'advancedteamgame' then
            coinBag.takeObject({position = storagePos, rotation = {0,180,0}})
        end
    end

    local function supplyDice(playerBoard, color, amount)
        local playerDicePos = getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {color})
        local function sortingFunction(pos1, pos2) return pos1[3] > pos2[3] end
        table.sort(playerDicePos, sortingFunction)
        local playerDie = getObjectFromGUID(Guids.PlayerDie)
        local rotation = {0,330,0}
        if settings.playstyle == 'beginnersolo' or settings.playstyle == 'advancedsolo' then rotation = {0,30,0} end
        local function spawnDie(position)
            spawnObject({
                type = 'Die_6_Rounded',
                position = {position[1],position[2]+1,position[3]},
                rotation = rotation,
                callback_function = function(die)
                    die.setColorTint(ColorTint[color])
                    die.setTags({color, 'playerdice'})
                end
            })
        end
        for i = 1, amount do
            spawnDie(playerDicePos[i])
        end
    end

    local function supplyAiDeck(p)
        local aiDeckPosition = {p[1]-12.6, 1.1, p[3]-10.8}
        local aiDeckZone = getObjectFromGUID(Guids.Zones.aideck)
        aiDeckZone.setPosition(aiDeckPosition)
        local aiDeckGuid = Guids.Decks.aibasic
        if settings.components.vineyards == true then
            aiDeckGuid = Guids.Decks.aivineyard
        end

        local aiDeck = SetupBag.takeObject({guid = aiDeckGuid, position = aiDeckPosition, rotation = {0,180,180}})
        aiDeck.shuffle()
        local castleCardGuid = getObjectGuidWithTag(aiDeck, 'castle')
        Wait.time(function()
            aiDeck.takeObject({
                guid = castleCardGuid,
                position = {aiDeckPosition[1]+7.15, 1.1, aiDeckPosition[3]},
                flip = true,
                callback_function = function(spawnedObject)
                    local castlePos = getSnapPositionsWithAnyTagsPositionedToWorld(spawnedObject, {'castle'})[1]
                    local castleBag = getObjectFromGUID(Guids.Bags.castle)
                    castleBag.takeObject({position = castlePos, rotation = {0,180,0}})
                end
            })
        end, 2)
        Wait.time(function()
            aiDeck.takeObject({position = {aiDeckPosition[1]+12.86, 1.1, aiDeckPosition[3]}, flip = true})
        end, 2.4)
    end

    local function supplyAiBoard()
        getObjectFromGUID(Guids.Hands[settings.aiPlayerColor]).setPosition({0.00, -15.00, 0.00})

        local aiBoard = getObjectFromGUID(getAiBoardGuid())
        supplyAiTradeGoods(aiBoard)
        supplyCastle(aiBoard)
        supplyCoin(aiBoard)
        supplyDice(aiBoard, settings.aiPlayerColor, 1)
        local p = aiBoard.getPosition()
        supplyAiDeck(p)

        if settings.aimodes.a == true then
            local modeAPositions = getSnapPositionsWithAnyTagsPositionedToWorld(aiBoard, {'modea'})
            local blackBag = getObjectFromGUID(Guids.Bags.blackmarket)
            for _, modeAPos in ipairs(modeAPositions) do
                blackBag.takeObject({
                    position = modeAPos,
                    rotation = {0,180,180}
                })
            end
        end

        if settings.aimodes.b == true then
            getObjectFromGUID(Guids.Bags.mine).takeObject({
                position = getSnapPositionsWithAnyTagsPositionedToWorld(aiBoard, {'mine'})[1],
                rotation = {0,180,0}
            })
            getObjectFromGUID(Guids.Bags.castle).takeObject({
                position = getSnapPositionsWithAnyTagsPositionedToWorld(aiBoard, {'castle'})[1],
                rotation = {0,180,0}
            })
            getObjectFromGUID(Guids.Bags.building).takeObject({
                position = getSnapPositionsWithAnyTagsPositionedToWorld(aiBoard, {'building'})[1],
                rotation = {0,180,0}
            })
        end

        SetupBag.takeObject({guid = Guids.AiCheatSheet, position = {p[1], 1.1, p[3]+13.5}, rotation = {0,180,0}})
    end

    local function supplyBoard(playerBoard, workerAmount, colors)
        supplyWorker(playerBoard, workerAmount)
        supplyTradeGoods(playerBoard)
        supplyCastle(playerBoard)
        supplyCoin(playerBoard)
        for _, color in ipairs(colors) do
            supplyDice(playerBoard, color, 2)
        end
    end

    if settings.playstyle == 'ai' then
        supplyAiBoard()
    end
    if settings.playstyle == 'beginnersolo' then
        supplyBoard(getObjectFromGUID(Guids.Boards.beginnersolo), 2, {'Yellow'})
        moveWhiteDie('Yellow')
    elseif settings.playstyle == 'advancedsolo' then
        supplyBoard(getObjectFromGUID(Guids.Boards.advancedsolo), 2, {'Yellow'})
        moveWhiteDie('Yellow')
    elseif settings.playstyle == 'beginnerteamgame' then
        supplyBoard(getObjectFromGUID(Guids.Boards.teams31yr), 3, {'Yellow', 'Red'})
        supplyBoard(getObjectFromGUID(Guids.Boards.teams31pb), 5, {'Purple', 'Blue'})
        moveWhiteDie('Yellow')
    elseif settings.playstyle == 'advancedteamgame' then
        supplyBoard(getObjectFromGUID(Guids.Boards.teams32yr), 3, {'Yellow', 'Red'})
        supplyBoard(getObjectFromGUID(Guids.Boards.teams32pb), 5, {'Purple', 'Blue'})
        moveWhiteDie('Yellow')
    else
        local order = getPlayerTurnOrder()
        for index, color in ipairs(order) do
            if settings.aiPlayerColor ~= color then
                local playerBoard = getObjectsWithAllTags({color, 'playerboard'})[1]
                supplyBoard(playerBoard, index, {color})

                if index == 1 then
                    -- Give first player the white die
                    yellowPrint('Giving the ' .. color .. ' player the white die, 3 trade goods, 1 castle, and 1 worker.')
                    moveWhiteDie(color)
                else
                    yellowPrint('Giving the ' .. color .. ' player 3 trade goods, 1 castle, and ' .. index .. ' workers.')
                end
            end
        end
    end
end