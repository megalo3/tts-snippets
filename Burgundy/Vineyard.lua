function setVineyards()
    if settings.components.vineyards == false then
        for _, vineyard in ipairs(getObjectsWithTag('vineyard')) do
            SetupBag.putObject(vineyard)
        end
        return
    end

    local vines = shuffleArray(Vines)

    -- Set 2-3 Player Board
    if settings.playercount < 4 then
        local vine4p = getObjectFromGUID(Guids.Boards.vineyard4p)
        local pos = vine4p.getPosition()
        vine4p.setLock(false)
        SetupBag.putObject(vine4p)
        local vine23p = SetupBag.takeObject({ guid = Guids.Boards.vineyard23p, position = pos })
        vine23p.setLock(true)

        -- If it is a 2-3 player game, limit randomness
        if coerceBoolean(settings.rules.vineyardrandomness) == true then
            -- Remove one color in a 3 player game
            removeVineColor(vines)
            if settings.playercount == 2 then
                -- Remove a second color if only 2 players
                removeVineColor(vines)
            end
        end
        settings.availableVines = vines
    end

    for index, color in ipairs(getSeatedPlayers()) do
        local token = getObjectsWithAllTags({vines[index], 'vinebonus'})[1]
        token.setPositionSmooth(Positions.PlayerVine[color])
    end

    Wait.time(function() resupplyVineyards() end, 2)
end

-- Remove 1 chosen color of grapes from the game – each double hex tile containing at least one grape (16 double hexes) and each vine bonus tile in that color. Place theremoved components back into the game box. If you are instructed to do something with all double hex tiles/vine bonus tiles, skip the ones you have removed.
function removeVineColor(colors)
    local color = colors[1]
    yellowPrint('Removing ' .. color .. ' vines.')
    table.remove(colors, 1)
    for _, object in ipairs(getObjectsWithAllTags({color, 'vinebonus'})) do
        destroyObject(object)
    end

    local bag = getObjectFromGUID(Guids.Bags.vineyard)
    local guidsToRemove = {}
    for _, object in ipairs(bag.getObjects()) do
        if has_value(object.tags, color) then
            table.insert(guidsToRemove, object.guid)
        end
    end
    for index, guid in ipairs(guidsToRemove) do
        destroyObject(bag.takeObject({guid = guid}))
    end
end

function resupplyVineyards()
    -- Vineyard Depot
    -- 4 player game, fill all 6 depot
    -- 2 or 3 player game, fill spots 1, 3, and 5

    -- Vineyard Store
    -- 3 or 4 player game, place 3 tiles on the store
    -- 2 player, place 1 tile on the store

    if settings.components.vineyards == false then return end
    local zone = getObjectFromGUID(Guids.Zones.vineyard)
    for _, object in ipairs(zone.getObjects()) do
        SetupBag.putObject(object)
    end

    local bag = getObjectFromGUID(Guids.Bags.vineyard)

    local depot = getObjectFromGUID(Guids.Boards.vineyarddepot)
    local snaps = depot.getSnapPoints()
    for index, snap in ipairs(snaps) do
        if #bag.getObjects() == 0 then return end
        if settings.playercount == 4 or index % 2 == 1 then
            local pos = depot.positionToWorld(snap.position)
            local tile = bag.takeObject()
            tile.setPosition({pos[1],pos[2]+2,pos[3]})
            tile.setRotation({0,90,0})
        end
    end

    local store = getObjectFromGUID(Guids.Boards.vineyard4p)
    if settings.playercount < 4 then
        store = getObjectFromGUID(Guids.Boards.vineyard23p)
    end
    local snaps = store.getSnapPoints()
    for index, snap in ipairs(snaps) do
        if settings.playercount > 2 or index == 2 then
            local pos = store.positionToWorld(snap.position)
            local tile = bag.takeObject()
            tile.setPosition({pos[1],pos[2]+2,pos[3]})
            tile.setRotation({0,180,0})
        end
    end
end