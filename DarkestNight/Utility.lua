-- type: Event, Artifact, Quest, Mystery, Map

Utility = {
    Draw = {
        -- { Target = 'Player' | 'Discard', Type = 'Artifact', Color = 'Blue' }
        Card = function(input)
            if isDeckEmpty(input.Type) == true then
                resupplyDeck(input.Type)
                Wait.time(function() Utility.Draw.Card(input) end, 1.3)
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
    }
}

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


function returnItem(object)
    -- Unstack stacks
    if object.name == 'Custom_Token_Stack' then
        local newObject = object.takeObject()
        object = newObject
    end

    if object.hasTag("Blight") then
        Blights.returnBlight(object)
        return true
    end
    if object.hasTag("Spark") then
        local bag = getObjectsWithAllTags({'Spark', 'Bag'})[1]
        returnSingleItem(object, bag)
        return true
    end
    if object.hasTag("Progress") then
        local bag = getObjectsWithAllTags({'Progress', 'Bag'})[1]
        returnSingleItem(object, bag)
        return true
    end
    if object.hasTag("Time") then
        local bag = getObjectsWithAllTags({'Time', 'Bag'})[1]
        returnSingleItem(object, bag)
        return true
    end
    if object.hasTag("Key") then
        local bag = getObjectsWithAllTags({'Key', 'Bag'})[1]
        returnSingleItem(object, bag)
        return true
    end
    if object.hasTag("Item") then
        returnSingleItem(object, getItemBag())
        return true
    end

    if object.hasTag("Artifact") then
        discardCard({ Card = object, Type = 'Artifact' })
        return true
    end

    if object.hasTag("Mystery") then
        discardCard({ Card = object, Type = 'Mystery', SkipRotation = true })
        return true
    end

    if object.hasTag("Quest") then
        discardCard({ Card = object, Type = 'Quest' })
        return true
    end

    if object.hasTag("Event") then
        discardCard({ Card = object, Type = 'Event' })
        return true
    end
end

function returnSingleItem(object, bag)
    local taken = object.takeObject()
    if taken ~= nil then
        bag.putObject(taken)
    else
        bag.putObject(object)
    end
end

-- ItemName, Color
function dealItem(input)
    if input.ItemName == "Artifact" then
        local zone = getObjectsWithAllTags({'Zone', 'Artifact', 'Draw'})[1]
        local deck = getDeckFromZone(zone)
        deck.deal(1, input.Color)
        return
    end
    if input.ItemName == "Mystery" then
        local zone = getObjectsWithAllTags({'Zone', 'Mystery', 'Draw'})[1]
        local deck = getDeckFromZone(zone)
        deck.deal(1, input.Color)
        return
    end
    if input.ItemName == "Revelation" then
        Darkness.Move.Clues(3)
        return
    end
    getItemFromBag({tag = input.ItemName, color = input.Color})
end

function getItemFromBag(input)
    local starter = getObjectsWithAllTags({input.color, 'Character Sheet', 'Starter'})[1]
    local position = starter.getPosition()

    if input.tag == "Spark" then
        local bag = getObjectsWithAllTags({'Bag', 'Spark'})[1]
        bag.takeObject({
            position = position,
        })
        return
    end

    for _, item in ipairs(getItemBag().getObjects()) do
        if table.inTable(item.tags, input.tag) then
            getItemBag().takeObject({
                guid = item.guid,
                position = {position[1], 2, position[3]},
                rotation = {0,180,0}
            })
            return
        end
    end
    print("There are no remaining " .. input.tag .. " tokens in the supply.")
end