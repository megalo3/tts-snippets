function setIncludedHexes()
    local settings = Global.getTable('settings')
    if settings.components.geese == false then
        SetupBag.putObject(BlackBag.takeObject({guid = Guids.Hexes.geese}))
    end
    if settings.components.cranes == false then
        SetupBag.putObject(BlackBag.takeObject({guid = Guids.Hexes.crane}))
    end
    if settings.components.whitecastles == false then
        SetupBag.putObject(BlackBag.takeObject({guid = Guids.Hexes.blackwhitecastle}))
        SetupBag.putObject(BlackBag.takeObject({guid = Guids.Hexes.blackwhitecastle2}))
        SetupBag.putObject(BuildingBag.takeObject({guid = Guids.Hexes.whitecastle1}))
        SetupBag.putObject(BuildingBag.takeObject({guid = Guids.Hexes.whitecastle2}))
        SetupBag.putObject(BuildingBag.takeObject({guid = Guids.Hexes.whitecastle3}))
        SetupBag.putObject(BuildingBag.takeObject({guid = Guids.Hexes.whitecastle4}))
        SetupBag.putObject(BuildingBag.takeObject({guid = Guids.Hexes.whitecastle5}))
        SetupBag.putObject(BuildingBag.takeObject({guid = Guids.Hexes.whitecastle6}))
    end
    if settings.components.monastery2728 == false then
        local monasteryBag = getObjectFromGUID(Guids.Bags.monastery)
        SetupBag.putObject(monasteryBag.takeObject({guid = Guids.Hexes.monastery27}))
        SetupBag.putObject(monasteryBag.takeObject({guid = Guids.Hexes.monastery28}))
    end
    if settings.components.inns == false then
        SetupBag.putObject(getObjectFromGUID(Guids.Bags.inn))
    end
end

function removeGameBoardHexes()
    local zone = getObjectFromGUID(Guids.Zones.gameboard)
    for _, object in ipairs(zone.getObjects()) do
        if not object.hasTag('inn') then
            SetupBag.putObject(object)
        end
    end
end

function removePlayerBoardHexes()
    for _, obj in ipairs(getObjectsWithTag('Map')) do
        destroyObject(obj)

    end
end

function supplyGameBoardHexes()
    local settings = Global.getTable('settings')

    GameBoard = getGameBoard()
    local snaps = GameBoard.getSnapPoints()

    local waitCounter = 1
    for _, snap in ipairs(snaps) do
        if #snap.tags > 0 then
            local deployHex = true

            if settings.playercount == 3 then
                if has_value(snap.tags, 'fourplayer') then
                    deployHex = false
                end

                local isPhaseACE = settings.phase == 'A' or settings.phase == 'C' or settings.phase == 'E'
                if has_value(snap.tags, 'threeplayerbd') and isPhaseACE then
                    deployHex = false
                end
            end

            if deployHex then
                local bag = nil
                if has_value(snap.tags, 'building') then bag = getObjectFromGUID(Guids.Bags.building) end
                if has_value(snap.tags, 'monastery') then bag = getObjectFromGUID(Guids.Bags.monastery) end
                if has_value(snap.tags, 'blackmarket') then bag = getObjectFromGUID(Guids.Bags.blackmarket) end
                if has_value(snap.tags, 'inn') and settings.phase ~= 'E' then bag = getObjectFromGUID(Guids.Bags.inn) end
                if has_value(snap.tags, 'livestock') then bag = getObjectFromGUID(Guids.Bags.livestock) end
                if has_value(snap.tags, 'castle') then bag = getObjectFromGUID(Guids.Bags.castle) end
                if has_value(snap.tags, 'mine') then bag = getObjectFromGUID(Guids.Bags.mine) end
                if has_value(snap.tags, 'Ship') then bag = getObjectFromGUID(Guids.Bags.Ship) end

                if bag ~= nil then
                    Wait.time(function()
                        local pos = GameBoard.positionToWorld(snap.position)
                        pos[2] = 1.5
                        local hex = bag.takeObject({position = pos, rotation = {0, snap.rotation.y - 180, 0}})
                        if Descriptions[hex.getName()] ~= nil then
                            hex.setDescription(Descriptions[hex.getName()])
                        end
                    end, waitCounter * DeploySpeed)
                    waitCounter = waitCounter + 1
                end
            end
        end
    end
end

function setPlayerBoardInitialHexes()
    for _, color in ipairs(Colors) do
        local playerboard = getObjectsWithAllTags({color, 'playerboard'})[1]
        sampleToken = SetupBag.takeObject({guid = Guids.AllHexesToken, position = {-17.50, 1.02, 46.93}, smooth = false})
        spawnNumberTiles(playerboard)
        SetupBag.putObject(sampleToken)
    end
end

function flipDoubleHex(object)
    local rotationY = round(object.getRotation()[2])
    local position = object.getPosition()
    object.setRotationSmooth({0, rotationY + 180, 0})
    local c = 1.76
    local radians = rotationY * math.pi/180
    local a = c * math.sin(radians)
    local b = c * math.cos(radians)
    position = {
        position[1] + b,
        1.2,
        position[3] - a,
    }
    object.setPositionSmooth(position)
end