function setTradeGoods()
    local board = getGameBoard()
    local tgbag = getObjectsWithTag('tradegoodbag')[1]
    local snaps = board.getSnapPoints()
    for _, snap in ipairs(snaps) do
        if #snap.tags > 0 then
            if snap.tags[1] == 'tgslota' or snap.tags[1] == 'tgslotb' or snap.tags[1] == 'tgslotc' or snap.tags[1] == 'tgslotd' or snap.tags[1] == 'tgslote' then
                local pos = board.positionToWorld(snap.position)
                for a = 1,5 do
                    local tile = tgbag.takeObject({
                        position = {pos[1], 1+a/1.5, pos[3]
                    }})
                    tile.addTag(snap.tags[1])
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