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
    function supplyWorker(playerBoard, workerAmount)
        local workerPos = getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {'worker'})[1]
        local rotation = {0,180,0}
        for i = 1, workerAmount do
            WorkerBag.takeObject({position = workerPos, rotation = rotation})
        end
    end

    function supplyTradeGoods(playerBoard)
        local tradeGoodBag = getObjectsWithTag('tradegoodbag')[1]
        local rotation = {0,150,0}
        if settings.playstyle == 'beginnerteamgame' or settings.playstyle == 'advancedteamgame' or settings.playstyle == 'beginnersolo' or settings.playstyle == 'advancedsolo' then rotation = {0,0,0} end
        for _, tradeGoodPos in ipairs(getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {'tradegood'})) do
            tradeGoodBag.takeObject({position = tradeGoodPos, rotation = rotation})
        end
    end

    function supplyCastle(playerBoard)
        local castleBag = getObjectFromGUID(Guids.Bags.castle)
        local storagePos
        if settings.playstyle == 'beginnerteamgame' then
            storagePos = getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {'castle'})[1]
        else
            storagePos = getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {'storage'})[1]
        end
        castleBag.takeObject({position = storagePos, rotation = {0,180,0}})
    end

    function supplyCoin(playerBoard)
        local coinBag = getObjectFromGUID(Guids.Bags.coin)
        local storagePos = getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {'coin'})[1]
        coinBag.takeObject({position = storagePos, rotation = {0,180,0}})
        if settings.playstyle == 'beginnerteamgame' or settings.playstyle == 'advancedteamgame' then
            coinBag.takeObject({position = storagePos, rotation = {0,180,0}})
        end
    end

    function supplyDice(playerBoard, color)
        local playerDicePos = getSnapPositionsWithAnyTagsPositionedToWorld(playerBoard, {color})
        local function sortingFunction(pos1, pos2) return pos1[3] > pos2[3] end
        table.sort(playerDicePos, sortingFunction)
        local playerDie = getObjectFromGUID(Guids.PlayerDie)
        local rotation = {0,330,0}
        if settings.playstyle == 'beginnersolo' or settings.playstyle == 'advancedsolo' then rotation = {0,30,0} end
        local function spawnDie(position)
            spawnObject({
                type = 'Die_6_Rounded',
                position = position,
                rotation = rotation,
                callback_function = function(die)
                    die.setColorTint(ColorTint[color])
                    die.setTags({color, 'playerdice'})
                end
            })
        end
        spawnDie(playerDicePos[1])
        spawnDie(playerDicePos[2])
    end

    if settings.playstyle == 'beginnersolo' then
        supplyBoard(getObjectFromGUID(Guids.Boards.beginnersolo), 2, {'Yellow'})
    elseif settings.playstyle == 'advancedsolo' then
        supplyBoard(getObjectFromGUID(Guids.Boards.advancedsolo), 2, {'Yellow'})
    elseif settings.playstyle == 'beginnerteamgame' then
        supplyBoard(getObjectFromGUID(Guids.Boards.teams31yr), 3, {'Yellow', 'Red'})
        supplyBoard(getObjectFromGUID(Guids.Boards.teams31pb), 5, {'Purple', 'Blue'})
    elseif settings.playstyle == 'advancedteamgame' then
        supplyBoard(getObjectFromGUID(Guids.Boards.teams32yr), 3, {'Yellow', 'Red'})
        supplyBoard(getObjectFromGUID(Guids.Boards.teams32pb), 5, {'Purple', 'Blue'})
    else
        local order = getPlayerTurnOrder()
        for index, color in ipairs(order) do
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

function supplyBoard(playerBoard, workerAmount, colors)
    supplyWorker(playerBoard, workerAmount)
    supplyTradeGoods(playerBoard)
    supplyCastle(playerBoard)
    supplyCoin(playerBoard)
    for _, color in ipairs(colors) do
        supplyDice(playerBoard, color)
    end
end