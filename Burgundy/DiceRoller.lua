RollInProgress = {
    White = false,
    Red = false,
    Purple = false,
    Blue = false,
    Yellow = false
}

function clickRollDice(color)
    local settings = Global.getTable('settings')
    rollPlayerDice(color)

    -- Only roll the white die if the color is first player
    local turnOrder = getPlayerTurnOrder()
    if color == 'aicolor' then color = settings.aiPlayerColor end
    if turnOrder[1] ~= color and not (settings.playstyle == 'beginnersolo' or settings.playstyle == 'advancedsolo') then return end
    rollWhiteDie(color)
end

function getDieValue(die)
    if (die.tag == 'Dice') then
        return die.getRotationValue()
    end
    return 0
end

function rollPlayerDice(color)
    local board = 'playerboard'
    if color == 'aicolor' then
        board = 'aiboard'
        color = settings.aiPlayerColor
    end

    local playerDicePos = getPlayerBoardDicePositions(color, board)
    local playerDice = getObjectsWithAllTags({'playerdice', color})
    for _, d in ipairs(playerDice) do
        d.roll()
    end

    function coroutine_monitorDice()
        repeat
            local allRest = true
            for _, die in ipairs(playerDice) do
                if die ~= nil and die.resting == false then
                    allRest = false
                end
            end
            coroutine.yield(0)
        until allRest == true

        local values = {}
        for _, diee in ipairs(playerDice) do
            table.insert(values, getDieValue(diee))
        end

        RollInProgress[color] = false
        messages = {color .. ' player rolled '}
        table.insert(messages, values[1])
        if values[2] ~= nil then
            table.insert(messages, ' and ' .. values[2])
        end
        table.insert(messages, '.')
        printToAll(table.concat(messages), stringColorToRGB(color))

        if color == settings.aiPlayerColor then
            local slot = getAiWhiteDieSlot()
            playerDice[1].setPositionSmooth(raisePosition(playerDicePos[slot]))
        else
            for i,die in ipairs(playerDice) do
                playerDice[i].setPositionSmooth(raisePosition(playerDicePos[i]))
            end
        end
        return 1
    end

    if RollInProgress[color] == false then
        startLuaCoroutine(self, "coroutine_monitorDice")
        RollInProgress[color] = true
    end
end

function rollWhiteDie(playerColor)
    local die = getObjectsWithTag('whitedie')[1]
    die.roll()

    function coroutine_monitorWhiteDie()
        repeat
            local rest = true
            if die.resting == false then
                rest = false
            end
            coroutine.yield(0)
        until rest == true

        local value = getDieValue(die)
        RollInProgress.White = false
        yellowPrint('Deploying a trade good to depot ' .. value .. '.')
        moveWhiteDie(playerColor)
        deployTradeGood(value)
        return 1
    end

    if RollInProgress.White == false then
        startLuaCoroutine(self, "coroutine_monitorWhiteDie")
        RollInProgress.White = true
    end
end