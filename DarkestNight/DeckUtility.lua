-- type: Event, Artifact, Quest, Mystery, Map

-- { Target = 'Player' | 'Discard', Type = 'Artifact', Color = 'Blue' }
function drawCard(input)
    if isDeckEmpty(input.Type) == true then
        resupplyDeck(input.Type)
        Wait.time(function() drawCard(input) end, 1.3)
    else
        local topCard = getTopCard(getDrawZone(input.Type))
        if input.Target == 'Discard' then
            discardCard({ Card = topCard, Type = input.Type })
        end
        if input.Target == 'Player' then
            topCard.deal(1, input.Color)
        end
        return topCard
    end
end

function getDiscardPosition(type)
    local discardZone = getDiscardZone(type)
    local discardPosition = discardZone.getPosition()
    return { discardPosition[1], 2.5, discardPosition[3] }
end

function getDrawPosition(type)
    local drawZone = getDrawZone(type)
    local drawPosition = drawZone.getPosition()
    return { drawPosition[1], 2.5, drawPosition[3] }
end

-- { Card = card, Type = 'Artifact', SkipRotation = true }
function discardCard(input)
    input.Card.use_hands = false
    input.Card.setPositionSmooth(getDiscardPosition(input.Type))
    if input.SkipRotation ~= true then
        input.Card.setRotationSmooth({0, 180, 0})
    end
    Wait.condition(function() input.Card.use_hands = true end,
    ||not input.Card.isSmoothMoving(),
    3, function() end)
end

function resupplyDeck(type)
    local supplyLocation = getDrawPosition(type)
    local zone = getObjectsWithAllTags({'Deck', 'Zone', 'Discard', type})[1]
    for _, object in ipairs(zone.getObjects()) do
        if object.type == 'Deck' or object.type == 'Card' then
            object.flip()
            object.setPositionSmooth(supplyLocation)
            Wait.time(function() shuffleSupply(type) end, 1.3)
        end
    end
end

function shuffleSupply(type)
    for _, object in ipairs(getDrawZone(type).getObjects()) do
        if object.type == 'Deck' then
            object.shuffle()
        end
    end
end

function isDeckEmpty(type)
    local zone = getDrawZone(type)
    return #zone.getObjects() == 0
end

function getDiscardDeckTopCardInfo(type)
    return getTopCardInfo(getDiscardZone(type))
end

function getTopCard(zone)
    for _, object in ipairs(zone.getObjects()) do
        if object.type == 'Card' then
            return object
        end
        if object.type == 'Deck' then
            local card = object.takeObject({ flip = true })
            return card
        end
    end
end

function getTopCardInfo(zone)
    for _, object in ipairs(zone.getObjects()) do
        if object.type == 'Card' then
            return object
        end
        if object.type == 'Deck' then
            local cards = object.getObjects()
            return cards[#cards]
        end
    end
end

function getDrawZone(type)
    return getObjectsWithAllTags({'Deck', 'Zone', 'Draw', type})[1]
end

function getDiscardZone(type)
    return getObjectsWithAllTags({'Deck', 'Zone', 'Discard', type})[1]
end

function getDeckFromZone(zone)
    if (zone == nil) then return end
    for _, object in ipairs(zone.getObjects(true)) do
        if (object.type == 'Deck') then
            return object
        end
    end
    return nil
end