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

for _, color in ipairs(Colors) do
    _G["clickRollDice" .. color] = function() clickRollDice(color) end
end

-- color, playerBoard, altPosition
function createDiceRollButton(input)
    local p = getSnapPositionsWithAllTags(input.playerBoard, {'whitedie', input.color})[1]
    local pos = {p[1] * -1 + 0.3, p[2]+0.1, p[3] - 0.25}
    if input.altPosition == true then
        pos[1] = pos[1] - 0.6
    end
    input.playerBoard.createButton({
        click_function = "clickRollDice" .. input.color,
        label          = "Roll Dice",
        position       = pos,
        rotation       = {0, 0, 0},
        width          = 100,
        height         = 200,
        scale          = {0.5, 0.5, 0.5},
        font_size      = 100,
        color          = {0.2, 0.2, 0.2, 0.8},
        font_color     = {1, 1, 1},
        disabled       = true
    })
    createVictoryTrackButtons(input)
end