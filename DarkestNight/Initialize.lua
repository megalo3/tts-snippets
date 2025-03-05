function setNecroPanel()
    local allComplete = true
    -- Require at least 1 pawn to be set
    if #Settings.pawns == 0 then return end

    for _, pawn in ipairs(Settings.pawns) do
        activityToken = getObjectsWithAllTags({'Activity', pawn.Color})[1]
        if activityToken.getRotationValue() == 'Active' then
            allComplete = false
        end
    end

    if allComplete == true then
        UI.show("NecroTurnPanel")
    end
end

function darknessCardsSelected(player, selected) darknessCardsSelected(selected) end
function startingBlightsSelected(player, selected) startingBlightsSelected(selected) end
function startingDarknessSelected(player, selected) startingDarknessSelected(selected) end
function startingPowerCardsSelected(player, selected) startingPowerCardsSelected(selected) end
function startingGraceSelected(player, selected) startingGraceSelected(selected) end
function startingSparksSelected(player, selected) startingSparksSelected(selected) end
function numberOfHeroesSelected(player, selected) numberOfHeroesSelected(selected) end
function increaseQuestsSelected(player, selected) increaseQuestsSelected(selected) end

function setDifficulty()
    print('Game difficulty chosen')

    -- Move starting darkness and add cards
    moveStartingDarkness()

    if Settings.mapSelected == false then
        UI.setAttribute('MapPanel', 'active', true)
    end
    for _, color in ipairs(Player.getColors()) do
        closePanel(color, 'difficultyPanelClosedBy', 'DifficultyPanel')
    end
end

function shuffleDecks()
    for _, deck in ipairs(getObjectsWithTag('deck')) do
        deck.shuffle()
    end
end

function mapDeckSelected(player, option, id)
    SelectedMapDeck = MapDecks[option + 1]
end

function updateMapTypeName()
    DrawMapScript = getObjectFromGUID('131f29')
    DrawMapScript.UI.setAttribute('mapType', 'text', Settings.mapType)
end

function setMapDeck()
    Settings.mapSelected = true
    UI.setAttribute('MapPanel', 'active', false)

    shuffleDecks()
    Settings.mapType = DeckMapNames[SelectedMapDeck]
    print('Selected "' .. Settings.mapType .. '" map deck.')
    updateMapTypeName()

    if SelectedMapDeck ~= 'Everything' then
        createMapDeck(SelectedMapDeck)
    end

    -- Add starting blights
    local blightDm = Settings.difficultyOptions[2]
    local startingBlights = 0
    if blightDm == 0 then startingBlights = 1 end
    if blightDm == 3 then startingBlights = 2 end
    createStartingBlights(startingBlights)
end

function setCharacters()
    local pawns = {}
    for _, color in ipairs(Colors) do
        local pawn = getStarterPawn(color)
        if pawn != nil then
            table.insert(pawns, {Color = color, Pawn = getStarterPawn(color)})
        end
    end

    highlightPawns()
    setActivityPanel(pawns)

    for _, p in ipairs(pawns) do
        -- Move the pawn to the Monestary
        getObjectsWithAllTags({'Pawn', p['Pawn']})[1].setPositionSmooth(MonestaryPositions[p['Color']])
        dealPlayerCards(p['Color'], p['Pawn'])
        dealCharacterSheet(p['Color'], p['Pawn'])
    end

    -- Use DM Starting Power Cards
    if Settings.difficultyOptions[4] == -2 then
        print('You get to begin with all five starting cards.')
    else
        local startingCardAmount = 'three'
        if Settings.difficultyOptions[4] == -1 then startingCardAmount = 'four' end
        print('Choose ' .. startingCardAmount .. ' of your starting cards, put the other two back in your character deck, and then shuffle it.')
    end
end

function setActivityPanel(pawns)
    for _, pawn in ipairs(pawns) do
        table.insert(Settings.pawns, pawn)
        -- print(pawn.Pawn .. ' ' .. pawn.Color)
    end
end

function getStarterPawn(color)
    local sheetStarterZone = getObjectsWithAllTags({'Character Sheet', 'Zone', color})[1];
    local pawns = {}
    for _, object in ipairs(sheetStarterZone.getObjects(true)) do
        if object.hasTag('Pawn') then
            table.insert(pawns, object)
        end
    end
    if #pawns > 1 then
        print('Only one pawn may be selected per player color.')
        return;
    end
    if pawns[1] == nil then return end
    pawns[1].highlightOn(color)
    return pawns[1].getName()
end

function getActiveCharacters()
    local sheetStarterZones = getObjectsWithAllTags({'Character Sheet', 'Zone'});
    local characters = {}
    for _, zone in ipairs(sheetStarterZones) do
        local color = ''
        if zone.hasTag('Red') then color = 'Red' end
        if zone.hasTag('Green') then color = 'Green' end
        if zone.hasTag('Orange') then color = 'Orange' end
        if zone.hasTag('Blue') then color = 'Blue' end
        if zone.hasTag('Purple') then color = 'Purple' end
        for _, object in ipairs(zone.getObjects(true)) do
            if object.type == 'Card' then
                for _, tag in ipairs(object.getTags()) do
                    if tag ~= 'Character Sheet' then
                        table.insert(characters, { name = tag, color = color })
                    end
                end
            end
        end
    end
    return characters;
end

function highlightPawns()
    for _, character in ipairs(getActiveCharacters()) do
        local pawn = getObjectsWithAllTags({ 'PawnSelect', character.name })[1]
        pawn.highlightOn(character.color)
    end
end

function dealCharacterSheet(color, character)
    local characterSheetDeck = getObjectsWithAllTags({'Character Sheet', 'Deck'})[1];
    local sheetStarterZone = getObjectsWithAllTags({'Character Sheet', 'Zone', color})[1];
    for _, card in ipairs(characterSheetDeck.getObjects(true)) do
        if table.inTable(card.tags, character) then
            characterSheetDeck.takeObject({
                guid = card.guid,
                position = sheetStarterZone.getPosition(),
                callback_function = function(spawnedObject)
                    Wait.time(function() setCharacterSheetTokens(spawnedObject) end, 1.3)
                end
            })
        end
    end

    -- Use DM starting sparks
    if Settings.difficultyOptions[6] == -1 then
        Wait.time(function() getItemFromBag({tag = 'Spark', color = color}) end, 1.3)
        Wait.time(function() getItemFromBag({tag = 'Spark', color = color}) end, 2)
        Wait.time(function() getItemFromBag({tag = 'Spark', color = color}) end, 2.7)
    end
end

function setCharacterSheetTokens(object)
    object.setLock(true)
    local graceBag = getObjectsWithAllTags({'Grace', 'Bag'})[1];
    local secrecyBag = getObjectsWithAllTags({'Secrecy', 'Bag'})[1];
    for _, point in ipairs(object.getSnapPoints()) do
        if table.inTable(point.tags, 'Default Secrecy') then
            secrecyBag.takeObject({
                position = object.positionToWorld(point.position),
                rotation = {0,180,0}
            })
        end

        -- Use DM Starting Grace. A 2 modifier is the same as +1.31 x coords
        local startingGraceModifer = 0
        if Settings.difficultyOptions[5] == -1 then startingGraceModifer = 1.31 end

        if table.inTable(point.tags, 'Default Grace') then
            local gracePos = object.positionToWorld(point.position)
            gracePos[1] = gracePos[1] + startingGraceModifer
            graceBag.takeObject({
                position = gracePos,
                rotation = {0,180,0}
            })
        end
    end
end

function createMapDeck(color)
    local zone = getObjectsWithAllTags({'Map', 'Zone', 'Deck', 'Draw'})[1];
    local deck = getDeckFromZone(zone)

    for _, card in ipairs(deck.getObjects(true)) do
        if table.inTable(card.tags, color) == false then
            deck.takeObject({
                guid = card.guid,
                position = {-30.37, 1.13, 32.43}
            })
        end
    end
end

function dealPlayerCards(color, character)
    local characterDeck = getObjectsWithAllTags({'Characters', 'Deck'})[1];
    local colorDeckZone = getObjectsWithAllTags({'Deck', 'Zone', color})[1];
    for _, card in ipairs(characterDeck.getObjects(true)) do
        if table.inTable(card.tags, character) then
            characterDeck.takeObject({
                guid = card.guid,
                position = colorDeckZone.getPosition()
            })
        end
    end

    Wait.time(function() dealStarterCards(colorDeckZone, color) end, 1.8)
end

function dealStarterCards(zone, color)
    local deck = getDeckFromZone(zone)
    if deck == nil then return end

    local dealt = 1;
    for _, card in ipairs(deck.getObjects(true)) do
        if table.inTable(card.tags, 'Starter') then
            local index = dealt % 4;
            if index == 0 then index = 4 end
            local pos = { Players[color][index], Players['PlayedY'], Players['PlayedZ'][math.ceil(dealt/4)]}
            deck.takeObject({
                guid = card.guid,
                position = pos,
                flip = true
            })
            dealt = dealt + 1
        end
    end
end

function closeHeroTurnPanel(player) closePanel(player.color, 'heroTurnPanelClosedBy', 'HeroTurnPanel') end
function closeActionsPanel(player) closePanel(player.color, 'actionsPanelClosedBy', 'ActionsPanel') end
function closeDifficultyPanel(player) closePanel(player.color, 'difficultyPanelClosedBy', 'DifficultyPanel') end

function openHeroTurnPanel(player) openPanel(player.color, 'heroTurnPanelClosedBy', 'HeroTurnPanel') end
function openActionsPanel(player) openPanel(player.color, 'actionsPanelClosedBy', 'ActionsPanel') end
function openDifficultyPanel(player) openPanel(player.color, 'difficultyPanelClosedBy', 'DifficultyPanel') end

function closePanel(color, tableName, elementId)
    table.insert(Settings[tableName], color)
    showHidePanelsForPlayers(tableName, elementId)
end
function openPanel(color, tableName, elementId)
    table.removeByValue(Settings[tableName], color)
    showHidePanelsForPlayers(tableName, elementId)
end

function showHidePanelForAllPlayers()
    showHidePanelsForPlayers('heroTurnPanelClosedBy', 'HeroTurnPanel')
    showHidePanelsForPlayers('actionsPanelClosedBy', 'ActionsPanel')
    showHidePanelsForPlayers('difficultyPanelClosedBy', 'DifficultyPanel')
end

function showHidePanelsForPlayers(tableName, elementId)
    local visibility = getVisibilityString(invertUIVisibilityTable(Settings[tableName]), true)
    UI.setAttribute(elementId, "visibility", visibility)
    local buttonVisibility = getVisibilityString(Settings[tableName], true)
    UI.setAttribute(elementId .. "Button", "visibility", buttonVisibility)
end

-- Turns a visibility table (a table of players) into a string suitable for the visibility attribute.
function getVisibilityString(visibilityTable, hideForAllIfEmpty)
    local tableSize = #visibilityTable

    -- If the table is empty, hide the UI for everybody if enabled. This is done by setting the visibility to "Nobody". If disabled, everybody will see the UI.
    if hideForAllIfEmpty and tableSize == 0 then
        table.insert(visibilityTable, "Nobody")
    -- Otherwise, make sure "Nobody" is removed if it's not the only value in the table.
    elseif tableSize > 1 then
        table.removeByValue(visibilityTable, "Nobody")
    end

    -- Implode the string, separating by a pipe.
    return table.concat(visibilityTable, "|")
end

-- Inverts a UI visibility table, so all players currently present in it are removed, while all players not present are added.
function invertUIVisibilityTable(visibilityTable)
    local newVisibilityTable = {}

    -- Loop through the available seats.
    for _, value in ipairs(Player.getColors()) do
        -- If they're not currently in the table, add them.
        if not table.inTable(visibilityTable, value) then
            table.insert(newVisibilityTable, value)
        end
    end

    return newVisibilityTable
end




-- Check if a value is in a table.
function table:inTable(value)
    for tableKey, tableValue in ipairs(self) do
        if value == tableValue then
            return true
        end
    end

    return false
end

-- Gets the index of a value in a given table.
function table:indexOf(value)
    for tableKey, tableValue in ipairs(self) do
        if tableValue == value then
            return tableKey
        end
    end
end

-- Removes an element from a table by value.
function table:removeByValue(value)
    local index = table.indexOf(self, value)
    if index then
        table.remove(self, index)
    end

    return self
end

PlayerBoard = nil
SelectedMapDeck = 'Green';
DeckMapNames = {
    Green = 'Simplicity',
    Yellow = 'Hunted',
    Orange = 'Overrun',
    Red = 'Entropy',
    Purple = 'Spiritual Warfare',
    Blue = 'Classic',
    Everything = 'Everything'
}
MapDecks = {'Green', 'Yellow', 'Orange', 'Red', 'Purple', 'Blue', 'Everything'}
Colors = {'Red', 'Orange', 'Green', 'Blue', 'Purple'}
MonestaryPositions = {
    Red = {-12.3, 1.25, 13.50},
    Orange = {-10, 1.25, 13.50},
    Green = {-12.3, 1.25, 11.25},
    Blue = {-10, 1.25, 11.25},
    Purple = {-7.7, 1.25, 12.38}
}
Players = {
    PlayedY = 1.1,
    PlayedZ = {-12.20, -15.55},
    Red = {-29.25, -26.78, -24.34, -21.86},
    Orange = {-15.92, -13.45, -11.01, -8.53},
    Green = {-2.57, -0.10, 2.34, 4.87},
    Blue = {10.44, 12.91, 15.35, 17.83},
    Purple = {23.22, 25.69, 28.13, 30.63},
}