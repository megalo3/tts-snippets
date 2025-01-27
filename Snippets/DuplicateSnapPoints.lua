function duplicateSnapPoints()
    local points = getObjectFromGUID('1baac0').getSnapPoints()
    local characterDeck = getObjectsWithAllTags({'Quest', 'Deck'})[1];
    for index, card in ipairs(characterDeck.getObjects(true)) do
        local obj = characterDeck.takeObject({
            position = {-16.28, (index / 10)+1, 29.68}
        })
        obj.setSnapPoints(points)
    end
end