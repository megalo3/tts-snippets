function removeCharacters()
    local removeBag = getObjectsWithAllTags({'Bag', 'Remove'})[1];
    local characterSheetDeck = getObjectsWithAllTags({'Character Sheet', 'Deck'})[1];
    local characterDeck = getObjectsWithAllTags({'Characters', 'Deck'})[1];
    for _, pawn in ipairs(removeBag.getObjects(true)) do

        -- Remove character from Settings.pawns
            for index, settingsPawn in ipairs(Settings.pawns) do
            if settingsPawn.Pawn == pawn.name then
                table.remove(Settings.pawns, index)
            end
        end

        local characterSheet = getObjectsWithAllTags({'Character Sheet', pawn.name})[1];
        if characterSheet != nil then
            characterSheet.setLock(false)
            characterSheetDeck.putObject(characterSheet)
            for _, card in ipairs(getObjectsWithAllTags({pawn.name})) do
                characterDeck.putObject(card)
            end
        end
    end
    Wait.time(function() deleteExtraTokens() end, .5)
end

function deleteExtraTokens()
    local characterSheetZones = getObjectsWithAllTags({'Character Sheet', 'Zone'});
    local secrecyBag = getObjectsWithAllTags({'Bag', 'Secrecy'})[1];
    local graceBag = getObjectsWithAllTags({'Bag', 'Grace'})[1];
    for _, zone in ipairs(characterSheetZones) do
        local graceToken = nil
        local secrecyToken = nil
        local hasCard = false
        for _, object in ipairs(zone.getObjects()) do
            if object.name == 'Card' then hasCard = true end
            if object.getName() == 'Grace' then graceToken = object end
            if object.getName() == 'Secrecy' then secrecyToken = object end
        end
        if hasCard == false then
            if graceToken != nil then
                graceBag.putObject(graceToken)
            end
            if secrecyToken != nil then
                secrecyBag.putObject(secrecyToken)
            end
        end
    end
end