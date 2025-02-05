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
    local position = board.positionToWorld(selectedSnap.position)
    position[2] = 5
    pawn.setPositionSmooth(position)
    pawn.setRotationSmooth(({0,0,0}))
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