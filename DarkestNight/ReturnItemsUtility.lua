function returnItem(object)
    -- Unstack stacks
    if object.name == 'Custom_Token_Stack' then
        local newObject = object.takeObject()
        object = newObject
    end

    if object.hasTag("Blight") then
        returnBlight(object)
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
        moveClues(3)
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