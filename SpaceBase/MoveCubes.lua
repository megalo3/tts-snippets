-- moveToTrack('Credits', 15, color, true)
-- moveRedCredits5 = moveToTrack('Credits', 5, Red, true)
for _, color in ipairs(Colors) do
    for _, track in ipairs({'Credits', 'Income', 'Victory'}) do
        for _, number in ipairs({1,5}) do
            _G["move" .. color .. track .. number] = function(_,_,altClick)

                local verb = 'gained '
                local value = number
                if altClick == true then
                    verb = 'spent '
                    value = value * -1
                end

                settings.Points[color][track] = settings.Points[color][track] + value

                printToAll(color .. ' player ' .. verb .. math.abs(value) .. ' ' .. track .. ' to a total of ' .. settings.Points[color][track] .. '.', stringColorToRGB(color))

                moveTrack(track, color)
            end
        end
    end
end

function moveTrack(track, color)
    local points = settings.Points[color][track]

    local slot = points%40
    if slot == 0 and points > 1 then
        slot = 40
    end
    local positionsIndex = 1
    if color == 'Blue' or color == 'Purple' or color == 'Teal' then
        positionsIndex = 2
    end

    local positionX = Positions.ResourceIncrements[positionsIndex][slot+1]
    local cubeIndex = 0
    if track == 'Credits' then cubeIndex = 1 end
    if track == 'Income' then cubeIndex = 2 end
    if track == 'Victory' then cubeIndex = 3 end
    local cube = getObjectFromGUID(Guids.PlayerCubes[color][cubeIndex])
    local p = cube.getPosition()
    p[1] = positionX
    cube.setPositionSmooth(p)
end

function createMoveCubeButtons(color)
    local zone = getObjectFromGUID(Guids.Zones.MoveCubes[color])
    if zone == nil then return end


    for tIndex, track in ipairs({'Victory', 'Income', 'Credits'}) do
        for nIndex, number in ipairs({5,1}) do

            local pos = {nIndex/1.95 - 0.9, 0, tIndex/2.5 - 0.08}

            zone.createButton({
                click_function = "move" .. color .. track .. number,
                function_owner = Global,
                label          = '+' .. number,
                tooltip        = 'Add ' .. number .. ' ' .. track,
                position       = pos,
                rotation       = {0,180,0},
                width          = 240,
                height         = 160,
                font_size      = 100,
                color          = MoveCubesColors[track],
                font_color     = MoveCubesColorsText[track],
            })
        end
    end
end