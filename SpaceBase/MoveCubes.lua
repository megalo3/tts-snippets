-- moveToTrack('Credits', 15, color, true)
-- moveRedCredits5 = moveToTrack('Credits', 5, Red, true)
for _, color in ipairs(Colors) do
    for _, track in ipairs({'Credits', 'Income', 'Victory'}) do
        for _, number in ipairs({'-5','-1','+1','+5'}) do
            _G["move" .. color .. track .. number] = function() moveToTrack(track, tonumber(number), color, false) end
        end
    end
end

function moveToTrack(track, number, color, startAtZero)
    local cubeSlotSpacing = 0.41

    local beginningX = Positions.ResourceIncrements[1][1]
    if color == 'Blue' or color == 'Purple' or color == 'Teal' then
        beginningX = Positions.ResourceIncrements[2][1]
    end
    local endX = Positions.ResourceIncrements[1][40]
    if color == 'Blue' or color == 'Purple' or color == 'Teal' then
        endX = Positions.ResourceIncrements[2][40]
    end

    local cubeIndex = 0
    if track == 'Credits' then cubeIndex = 1 end
    if track == 'Income' then cubeIndex = 2 end
    if track == 'Victory' then cubeIndex = 3 end
    local cube = getObjectFromGUID(Guids.PlayerCubes[color][cubeIndex])

    local p = cube.getPosition()

    local startX = p[1]
    if startAtZero == true then startX = beginningX end

    local posX = startX + (cubeSlotSpacing * number)

    if posX > endX then
        posX = posX - (40 * cubeSlotSpacing)
    end
    if posX < beginningX then
        posX = posX + (40 * cubeSlotSpacing)
    end

    cube.setPositionSmooth({posX, p[2], p[3]})
end

function createMoveCubeButtons(color)
    local zone = getObjectFromGUID(Guids.Zones.MoveCubes[color])
    if zone == nil then return end


    for tIndex, track in ipairs({'Victory', 'Income', 'Credits'}) do
        for nIndex, number in ipairs({'+5','+1','-1','-5'}) do

            local pos = {nIndex/2 - 0.05, 0, tIndex/2 - 0.05}

            zone.createButton({
                click_function = "move" .. color .. track .. number,
                function_owner = Global,
                label          = number,
                tooltip        = number .. ' ' .. track,
                position       = pos,
                rotation       = {0,180,0},
                width          = 160,
                height         = 160,
                font_size      = 200,
                color          = {0,0,0},
                font_color     = MoveCubesColors[track],
            })
        end
    end
end