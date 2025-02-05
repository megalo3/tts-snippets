VictoryPositions = nil

function moveToVictoryNumber(color, number)
    settings.points[color] = settings.points[color] + number
    pawn = getObjectsWithAllTags({color, 'victorytoken'})[1]
    local victoryIndex = settings.points[color]%100
    local verb = "gained "
    if number < 0 then verb = "lost " end
    printToAll(color .. " player " .. verb .. number .. " victory points and has a total of " .. settings.points[color] .. ".", stringColorToRGB(color))
    if victoryIndex == 0 then victoryIndex = 100 end

    if VictoryPositions == nil then
        VictoryPositions = getSortedVictoryPositions()
    end

    local selectedSnap = VictoryPositions[victoryIndex]
    local board = getGameBoard()
    pawn.setPositionSmooth(board.positionToWorld(selectedSnap.position))
end

function getSortedVictoryPositions()
    local board = getGameBoard()
    local snaps = board.getSnapPoints()

    local bottom = {}
    local top = {}
    local left = {}
    local right = {}
    local all = {}

    -- top
    local function sortingFunction(snap1, snap2) return snap1.position.z > snap2.position.z end
    table.sort(snaps, sortingFunction)
    for b = 1, 32 do
        table.insert(bottom, snaps[b])
    end
    local function sortingFunction(snap1, snap2) return snap1.position.x < snap2.position.x end
    table.sort(bottom, sortingFunction)

    -- bottom
    local function sortingFunction(snap1, snap2) return snap1.position.z < snap2.position.z end
    table.sort(snaps, sortingFunction)
    for b = 1, 32 do
        table.insert(top, snaps[b])
    end
    local function sortingFunction(snap1, snap2) return snap1.position.x > snap2.position.x end
    table.sort(top, sortingFunction)

    -- left
    local function sortingFunction(snap1, snap2) return snap1.position.x > snap2.position.x end
    table.sort(snaps, sortingFunction)
    for b = 1, 21 do
        table.insert(left, snaps[b])
    end
    local function sortingFunction(snap1, snap2) return snap1.position.z > snap2.position.z end
    table.sort(left, sortingFunction)

    -- right
    local function sortingFunction(snap1, snap2) return snap1.position.x < snap2.position.x end
    table.sort(snaps, sortingFunction)
    for b = 1, 21 do
        table.insert(right, snaps[b])
    end
    local function sortingFunction(snap1, snap2) return snap1.position.z < snap2.position.z end
    table.sort(right, sortingFunction)

    for b = 17, 31 do
        table.insert(all, bottom[b])
    end
    for b = 2, 20 do
        table.insert(all, left[b])
    end
    for b = 2, 32 do
        table.insert(all, top[b])
    end
    for b = 2, 20 do
        table.insert(all, right[b])
    end
    for b = 1, 16 do
        table.insert(all, bottom[b])
    end

    return all
end

for _, color in ipairs(Colors) do
    _G["clickVictoryTrack" .. color .. '-10'] = function() moveToVictoryNumber(color, -10) end
    _G["clickVictoryTrack" .. color .. '-5'] = function() moveToVictoryNumber(color, -5) end
    _G["clickVictoryTrack" .. color .. '-1'] = function() moveToVictoryNumber(color, -1) end
    _G["clickVictoryTrack" .. color .. '+1'] = function() moveToVictoryNumber(color, 1) end
    _G["clickVictoryTrack" .. color .. '+5'] = function() moveToVictoryNumber(color, 5) end
    _G["clickVictoryTrack" .. color .. '+10'] = function() moveToVictoryNumber(color, 10) end
end

-- color, playerBoard, altPosition
function createVictoryTrackButtons(input)
    local p = getSnapPositionsWithAllTags(input.playerBoard, {'whitedie', input.color})[1]
    for index, num in ipairs{'-10','-5','-1','+1','+5','+10'} do
        local pos = {p[1] * -1 + 0.3*index, p[2]+0.1, p[3] - 0.25}
        if input.altPosition == true then
            pos[1] = pos[1] - 0.6
        end
        input.playerBoard.createButton({
            click_function = "clickVictoryTrack" .. input.color .. num,
            label          = num,
            position       = pos,
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
end