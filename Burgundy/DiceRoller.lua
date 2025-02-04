RollInProgress = false

function clickRollWhiteDie(_, color)
    local die = getObjectsWithTag('whitedie')[1]
    die.roll()
    local playerDice = getObjectsWithAllTags({'playerdice', color})
    for _, d in ipairs(playerDice) do
        d.roll()
    end

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
        yellowPrint('The white die is a ' .. value)
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

function createWhiteRollButton(playerBoard, color)
    local p = getSnapPositionsWithAllTags(playerBoard, {'whitedie', color})[1]
    playerBoard.createButton({
        click_function = "clickRollWhiteDie",
        function_owner = Global,
        label          = "Roll Dice",
        position       = {p[1] * -1 + 0.3, p[2]+0.1, p[3] - 0.25},
        rotation       = {0, 0, 0},
        width          = 500,
        height         = 200,
        scale          = {0.5, 0.5, 0.5},
        font_size      = 100,
        color          = {0.2, 0.2, 0.2, 0.8},
        font_color     = {1, 1, 1},
        disabled       = true
    })
end

function deleteWhiteRollButton(playerBoard)
    playerBoard.removeButton(1)
end