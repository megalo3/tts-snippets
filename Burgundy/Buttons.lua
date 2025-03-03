for _, color in ipairs(Colors) do
    _G["clickRollDice" .. color]                = function() clickRollDice(color) end
    _G["clickVictoryTrack" .. color .. '-10']   = function() moveToVictoryNumber(color, -10) end
    _G["clickVictoryTrack" .. color .. '-5']    = function() moveToVictoryNumber(color, -5) end
    _G["clickVictoryTrack" .. color .. '-1']    = function() moveToVictoryNumber(color, -1) end
    _G["clickVictoryTrack" .. color .. '+1']    = function() moveToVictoryNumber(color, 1) end
    _G["clickVictoryTrack" .. color .. '+5']    = function() moveToVictoryNumber(color, 5) end
    _G["clickVictoryTrack" .. color .. '+10']   = function() moveToVictoryNumber(color, 10) end
end
_G["clickRollDiceaicolor"]                = function() clickRollDice('aicolor') end

-- color, playerBoard, altPosition
function createDiceRollButton(input)
    local isAiBoard = false
    if input.color == 'aicolor' then isAiBoard = true end

    local p = getSnapPositionsWithAllTags(input.playerBoard, {'whitedie', input.color})[1]

    local pos = {p[1] * -1 + 0.9, p[2]+0.1, p[3] - 0.45}
    if input.altPosition == true then
        pos[1] = pos[1] - 1.8
    end

    if isAiBoard == true then
        pos[1] = pos[1] + 3.4
        pos[3] = pos[3] - 2.3
    end

    input.playerBoard.createButton({
        click_function = "clickRollDice" .. input.color,
        label          = "Roll",
        position       = pos,
        rotation       = {0, 0, 0},
        width          = 300,
        height         = 200,
        scale          = {0.5, 0.5, 0.5},
        font_size      = 100,
        color          = {0.2, 0.2, 0.2, 0.8},
        font_color     = {1, 1, 1},
        disabled       = true
    })
    createVictoryTrackButtons(input, p)
end

-- color, playerBoard, altPosition
function createVictoryTrackButtons(input, p)
    local isAiBoard = false
    if input.color == 'aicolor' then isAiBoard = true end

    local color = input.color
    if input.color == 'aicolor' and settings.aiPlayerColor ~= '' then color = settings.aiPlayerColor end

    for index, num in ipairs{'-10','-5','-1','+1','+5','+10'} do
        local pos = {p[1] * -1 + 0.9, p[2]+0.1, p[3] + 0.75 - 0.15*index}
        if input.altPosition == true then
            pos[1] = pos[1] - 1.8
        end
        if isAiBoard == true then
            pos[1] = pos[1] + 3.4
            pos[3] = pos[3] - 2.3
        end
        input.playerBoard.createButton({
            click_function = "clickVictoryTrack" .. color .. num,
            label          = num .. " VP",
            tooltip        = "Score " .. num .. " VP",
            position       = pos,
            rotation       = {0, 0, 0},
            width          = 500,
            height         = 200,
            scale          = {0.3, 0.3, 0.3},
            font_size      = 100,
            color          = ColorTintAlpha[color],
            font_color     = {1, 1, 1},
            disabled       = true
        })
    end
end