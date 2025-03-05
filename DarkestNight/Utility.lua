



Utility = {
    Draw = {
        -- type: Event, Artifact, Quest, Mystery, Map
        Event = function(o, color, a)
            local card = Utility.Draw.Card({ Target = 'Discard', Type = 'Event', Color = color })
            fate = Events[card.getName()].FateValue
            if fate == -1 then
                printToAll('The Renewal event was drawn. Reshuffling deck.', stringColorToRGB('Yellow'))
                Wait.time(function()
                    Utility.resupplyDeck('Event')
                    Wait.time(function() Utility.Draw.Event(o, color) end, 1.3)
                end, 1.3)
                return false
            end

            printToColor('Drew event (' .. card.getName() .. ').', color)
            card.deal(1, color)
        end,

        OmenEvent = function(o, color, a, firstDrawnCardGuid)
            -- FirstDrawnCard will only exist if the second drawn card caused a reshuffle
            local card1
            if firstDrawnCardGuid == nil then
                card1 = Utility.Draw.Card({ Target = 'Discard', Type = 'Event', Color = color })
            else
                card1 = getObjectFromGUID(firstDrawnCardGuid)
                card1.setLock(false)
            end

            fate1 = Events[card1.getName()].FateValue
            if fate1 == -1 then
                printToAll('The Renewal event was drawn. Reshuffling deck.', stringColorToRGB('Yellow'))
                Wait.time(function()
                    Utility.resupplyDeck('Event')
                    Wait.time(function() Utility.Draw.OmenEvent(o, color) end, 1.3)
                end, 1.3)
                return false
            end

            local card2 = Utility.Draw.Card({ Target = 'Discard', Type = 'Event', Color = color })
            local fate2 = Events[card2.getName()].FateValue
            if fate2 == -1 then
                card1.setLock(true)
                local pos = card1.getPosition()
                card1.setPosition({-10.91, 3, pos[3]})
                printToAll('The Renewal event was drawn. Reshuffling deck.', stringColorToRGB('Yellow'))
                Wait.time(function()
                    Utility.resupplyDeck('Event')
                    Wait.time(function() Utility.Draw.OmenEvent(o, color, a, card1.guid) end, 1.5)
                end, 1.3)
                return false
            end

            local keep = card2
            local discard = card1
            if fate1 >= fate2 then
                keep = card1
                discard = card2
            end
            printToColor('Drawing two events and keeping the one with the higher fate value (' .. keep.getName() .. ').', color)
            keep.deal(1, color)
        end,

        -- { Target = 'Player' | 'Discard', Type = 'Artifact', Color = 'Blue' }
        Card = function(input)
            if Utility.isDeckEmpty(input.Type) == true then
                Utility.resupplyDeck(input.Type)
                Wait.time(function() Utility.Draw.Card(input) end, 1.3)
            else
                local topCard = Utility.getTopCard(Utility.getDrawZone(input.Type))
                if input.Target == 'Discard' then
                    Utility.discardCard({ Card = topCard, Type = input.Type })
                end
                if input.Target == 'Player' then
                    topCard.deal(1, input.Color)
                end
                return topCard
            end
        end,

        -- ItemName, Color
        Item = function(input)
            if input.ItemName == "Artifact" then
                local zone = getObjectsWithAllTags({'Zone', 'Artifact', 'Draw'})[1]
                local deck = Utility.getDeckFromZone(zone)
                deck.deal(1, input.Color)
                return
            end
            if input.ItemName == "Mystery" then
                local zone = getObjectsWithAllTags({'Zone', 'Mystery', 'Draw'})[1]
                local deck = Utility.getDeckFromZone(zone)
                deck.deal(1, input.Color)
                return
            end
            if input.ItemName == "Revelation" then
                Darkness.Move.Clues(3)
                return
            end
            Utility.Draw.ItemFromBag({tag = input.ItemName, color = input.Color})
        end,

        ItemFromBag = function(input)
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
    },

    getDiscardPosition = function(type)
        local discardZone = Utility.getDiscardZone(type)
        local discardPosition = discardZone.getPosition()
        return { discardPosition[1], 2.5, discardPosition[3] }
    end,

    getDrawPosition = function(type)
        local drawZone = Utility.getDrawZone(type)
        local drawPosition = drawZone.getPosition()
        return { drawPosition[1], 2.5, drawPosition[3] }
    end,

    -- { Card = card, Type = 'Artifact', SkipRotation = true }
    discardCard = function(input)
        input.Card.use_hands = false
        input.Card.setPositionSmooth(Utility.getDiscardPosition(input.Type))
        if input.SkipRotation ~= true then
            input.Card.setRotationSmooth({0, 180, 0})
        end
        Wait.condition(function() input.Card.use_hands = true end,
        ||not input.Card.isSmoothMoving(),
        3, function() end)
    end,

    resupplyDeck = function(type)
        local supplyLocation = Utility.getDrawPosition(type)
        local zone = getObjectsWithAllTags({'Deck', 'Zone', 'Discard', type})[1]
        for _, object in ipairs(zone.getObjects()) do
            if object.type == 'Deck' or object.type == 'Card' then
                object.flip()
                object.setPositionSmooth(supplyLocation)
                Wait.time(function() Utility.shuffleSupply(type) end, 1.3)
            end
        end
    end,

    shuffleSupply = function(type)
        for _, object in ipairs(Utility.getDrawZone(type).getObjects()) do
            if object.type == 'Deck' then
                object.shuffle()
            end
        end
    end,

    isDeckEmpty = function(type)
        local zone = Utility.getDrawZone(type)
        return #zone.getObjects() == 0
    end,

    getDiscardDeckTopCardInfo = function(type)
        return Utility.getTopCardInfo(Utility.getDiscardZone(type))
    end,

    getTopCard = function(zone)
        for _, object in ipairs(zone.getObjects()) do
            if object.type == 'Card' then
                return object
            end
            if object.type == 'Deck' then
                local card = object.takeObject({ flip = true })
                return card
            end
        end
    end,

    getTopCardInfo = function(zone)
        for _, object in ipairs(zone.getObjects()) do
            if object.type == 'Card' then
                return object
            end
            if object.type == 'Deck' then
                local cards = object.getObjects()
                return cards[#cards]
            end
        end
    end,

    getDrawZone = function(type)
        return getObjectsWithAllTags({'Deck', 'Zone', 'Draw', type})[1]
    end,

    getDiscardZone = function(type)
        return getObjectsWithAllTags({'Deck', 'Zone', 'Discard', type})[1]
    end,

    getDeckFromZone = function(zone)
        if (zone == nil) then return end
        for _, object in ipairs(zone.getObjects(true)) do
            if (object.type == 'Deck') then
                return object
            end
        end
        return nil
    end,

    returnItem = function(object)
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
            Utility.returnSingleItem(object, bag)
            return true
        end
        if object.hasTag("Progress") then
            local bag = getObjectsWithAllTags({'Progress', 'Bag'})[1]
            Utility.returnSingleItem(object, bag)
            return true
        end
        if object.hasTag("Time") then
            local bag = getObjectsWithAllTags({'Time', 'Bag'})[1]
            Utility.returnSingleItem(object, bag)
            return true
        end
        if object.hasTag("Key") then
            local bag = getObjectsWithAllTags({'Key', 'Bag'})[1]
            Utility.returnSingleItem(object, bag)
            return true
        end
        if object.hasTag("Item") then
            Utility.returnSingleItem(object, getItemBag())
            return true
        end

        if object.hasTag("Artifact") then
            Utility.discardCard({ Card = object, Type = 'Artifact' })
            return true
        end

        if object.hasTag("Mystery") then
            Utility.discardCard({ Card = object, Type = 'Mystery', SkipRotation = true })
            return true
        end

        if object.hasTag("Quest") then
            Utility.discardCard({ Card = object, Type = 'Quest' })
            return true
        end

        if object.hasTag("Event") then
            Utility.discardCard({ Card = object, Type = 'Event' })
            return true
        end
    end,

    returnSingleItem = function(object, bag)
        local taken = object.takeObject()
        if taken ~= nil then
            bag.putObject(taken)
        else
            bag.putObject(object)
        end
    end
}