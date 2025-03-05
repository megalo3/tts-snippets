function drawEvent(o, color, a)
    local card = drawCard({ Target = 'Discard', Type = 'Event', Color = color })
    fate = Events[card.getName()].FateValue
    if fate == -1 then
        printToAll('The Renewal event was drawn. Reshuffling deck.', stringColorToRGB('Yellow'))
        Wait.time(function()
            resupplyDeck('Event')
            Wait.time(function() drawEvent(o, color) end, 1.3)
        end, 1.3)
        return false
    end

    printToColor('Drew event (' .. card.getName() .. ').', color)
    card.deal(1, color)
end

function omenDraw(o, color, a, firstDrawnCardGuid)
    -- FirstDrawnCard will only exist if the second drawn card caused a reshuffle
    local card1
    if firstDrawnCardGuid == nil then
        card1 = drawCard({ Target = 'Discard', Type = 'Event', Color = color })
    else
        card1 = getObjectFromGUID(firstDrawnCardGuid)
        card1.setLock(false)
    end

    fate1 = Events[card1.getName()].FateValue
    if fate1 == -1 then
        printToAll('The Renewal event was drawn. Reshuffling deck.', stringColorToRGB('Yellow'))
        Wait.time(function()
            resupplyDeck('Event')
            Wait.time(function() omenDraw(o, color) end, 1.3)
        end, 1.3)
        return false
    end

    local card2 = drawCard({ Target = 'Discard', Type = 'Event', Color = color })
    local fate2 = Events[card2.getName()].FateValue
    if fate2 == -1 then
        card1.setLock(true)
        local pos = card1.getPosition()
        card1.setPosition({-10.91, 3, pos[3]})
        printToAll('The Renewal event was drawn. Reshuffling deck.', stringColorToRGB('Yellow'))
        Wait.time(function()
            resupplyDeck('Event')
            Wait.time(function() omenDraw(o, color, a, card1.guid) end, 1.5)
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
end
