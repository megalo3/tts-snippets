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

function darknessCardsSelectedUI(player, selected) darknessCardsSelected(selected) end
function startingBlightsSelectedUI(player, selected) startingBlightsSelected(selected) end
function startingDarknessSelectedUI(player, selected) startingDarknessSelected(selected) end
function startingPowerCardsSelectedUI(player, selected) startingPowerCardsSelected(selected) end
function startingGraceSelectedUI(player, selected) startingGraceSelected(selected) end
function startingSparksSelectedUI(player, selected) startingSparksSelected(selected) end
function numberOfHeroesSelectedUI(player, selected) numberOfHeroesSelected(selected) end
function increaseQuestsSelectedUI(player, selected) increaseQuestsSelected(selected) end

function setMapDeckUI()
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

function mapDeckSelected(player, option, id)
    SelectedMapDeck = MapDecks[option + 1]
end

function closeHeroTurnPanelUI(player) closePanel(player.color, 'heroTurnPanelClosedBy', 'HeroTurnPanel') end
function closeActionsPanelUI(player) closePanel(player.color, 'actionsPanelClosedBy', 'ActionsPanel') end
function closeDifficultyPanelUI(player) closePanel(player.color, 'difficultyPanelClosedBy', 'DifficultyPanel') end

function openHeroTurnPanelUI(player) openPanel(player.color, 'heroTurnPanelClosedBy', 'HeroTurnPanel') end
function openActionsPanelUI(player) openPanel(player.color, 'actionsPanelClosedBy', 'ActionsPanel') end
function openDifficultyPanelUI(player) openPanel(player.color, 'difficultyPanelClosedBy', 'DifficultyPanel') end

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

function setDifficultyUI()
    print('Game difficulty chosen')

    -- Move starting darkness and add cards
    shuffleDecks()
    moveStartingDarkness()

    if Settings.mapSelected == false then
        UI.setAttribute('MapPanel', 'active', true)
    end
    for _, color in ipairs(Player.getColors()) do
        closePanel(color, 'difficultyPanelClosedBy', 'DifficultyPanel')
    end
end
