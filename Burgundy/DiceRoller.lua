RollInProgress = false

function clickRollDice(color)
    local settings = Global.getTable('settings')
    local playerDice = getObjectsWithAllTags({'playerdice', color})
    for _, d in ipairs(playerDice) do
        d.roll()
    end

    -- Only roll the white die if the color is first player
    if Turns.order[1] ~= color and not (settings.playstyle == 'beginnersolo' or settings.playstyle == 'advancedsolo') then return end

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
        RollInProgress = false
        yellowPrint('Deploying a trade good to depot ' .. value .. '.')
        deployTradeGood(value)
        return 1
    end


    if RollInProgress == false then
        startLuaCoroutine(self, "coroutine_monitorWhiteDie")
        RollInProgress = true
    end
end

function getDieValue(die)
    if (die.tag == 'Dice') then
        return die.getRotationValue()
    end
    return 0
end