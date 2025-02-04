function setTradeGoods()
    local board = getGameBoard()
    local tgbag = getObjectsWithTag('tradegoodbag')[1]
    local snaps = board.getSnapPoints()
    local waitCounter = 1

    for _, snap in ipairs(snaps) do
        if #snap.tags > 0 then
            if snap.tags[1] == 'tgslota' or snap.tags[1] == 'tgslotb' or snap.tags[1] == 'tgslotc' or snap.tags[1] == 'tgslotd' or snap.tags[1] == 'tgslote' then
                local pos = board.positionToWorld(snap.position)
                for a = 1,5 do
                    Wait.time(function()
                        local tile = tgbag.takeObject({
                            position = {pos[1], 1+a/1.5, pos[3]
                        }})
                        tile.addTag(snap.tags[1])
                    end, waitCounter * DeploySpeed)
                    waitCounter = waitCounter + 0.1
                end
            end
        end
    end
end

function deployTradeGoods(phase)
    local board = getGameBoard()
    local tiles = getObjectsWithTag(phase)
    local snaps = board.getSnapPoints()
    local count = 1
    for _, snap in ipairs(snaps) do
        if (#snap.tags > 0) then
            if (snap.tags[1] == 'tgslot1' or snap.tags[1] == 'tgslot2' or snap.tags[1] == 'tgslot3' or snap.tags[1] == 'tgslot4' or snap.tags[1] == 'tgslot5') then
                local pos = board.positionToWorld(snap.position)
                tiles[count].setPositionSmooth(pos)
                tiles[count].addTag(snap.tags[1])
                count = count + 1
            end
        end
    end
end

function deployTradeGood(depot)
    local board = getGameBoard()
    local phaseTag = 'tgslot' .. string.lower(settings.phase)
    local tradeGoods = getObjectsWithAllTags({phaseTag})

    if #tradeGoods > 0 then
        local function sortingFunction(good1, good2) return good1.getPosition()[3] < good2.getPosition()[3] end
        table.sort(tradeGoods, sortingFunction)

        local tileValue = tradeGoods[1].getRotationValue()
        local placeTag = 'tgplace' .. depot .. tileValue
        local pos = getSnapPositionsWithAnyTagsPositionedToWorld(board, {placeTag})[1]
        pos[2] = 2

        tradeGoods[1].setPositionSmooth(pos)
        if depot == 4 or depot == 1 then
            tradeGoods[1].setRotationSmooth({0, 150, 0})
        end
        if depot == 6 or depot == 3 then
            tradeGoods[1].setRotationSmooth({0, 210, 0})
        end
        tradeGoods[1].removeTag(phaseTag)
    end
end