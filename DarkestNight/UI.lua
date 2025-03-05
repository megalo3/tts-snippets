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
    Blights.createStartingBlights(startingBlights)
    Settings.started = true
end

function mapDeckSelected(player, option, id)
    SelectedMapDeck = MapDecks[option + 1]
end

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
    if Settings.started == true then return end
    print('Game difficulty chosen')

    -- Move starting darkness and add cards
    shuffleDecks()
    Darkness.Move.StartingDarkness()
    setDifficultyUninteractable()

    if Settings.mapSelected == false then
        UI.setAttribute('MapPanel', 'active', true)
    end
    for _, color in ipairs(Player.getColors()) do
        closePanel(color, 'difficultyPanelClosedBy', 'DifficultyPanel')
    end
end

function setDifficultyUninteractable()
    UI.setAttribute('DarknessCards', 'interactable', false)
    UI.setAttribute('StartingBlights', 'interactable', false)
    UI.setAttribute('StartingDarkness', 'interactable', false)
    UI.setAttribute('StartingPowerCards', 'interactable', false)
    UI.setAttribute('StartingGrace', 'interactable', false)
    UI.setAttribute('StartingSparks', 'interactable', false)
    UI.setAttribute('StartingHeroes', 'interactable', false)
    UI.setAttribute('IncreaseQuests', 'interactable', false)
    UI.setAttribute('SetDifficulty', 'interactable', false)
end

function startHeroTurnUI()
    print('It is now the Hero Turn.')

    for _, token in ipairs(getObjectsWithAllTags({'Activity'})) do
        token.setRotationValue("Active")
    end
    UI.hide("NecroTurnPanel")
end

function darknessCardsSelectedUI(player, selected) if Settings.started == false then darknessCardsSelected(selected) end end
function startingBlightsSelectedUI(player, selected) if Settings.started == false then startingBlightsSelected(selected) end end
function startingDarknessSelectedUI(player, selected) if Settings.started == false then startingDarknessSelected(selected) end end
function startingPowerCardsSelectedUI(player, selected) if Settings.started == false then startingPowerCardsSelected(selected) end end
function startingGraceSelectedUI(player, selected) if Settings.started == false then startingGraceSelected(selected) end end
function startingSparksSelectedUI(player, selected) if Settings.started == false then startingSparksSelected(selected) end end
function numberOfHeroesSelectedUI(player, selected) if Settings.started == false then numberOfHeroesSelected(selected) end end
function increaseQuestsSelectedUI(player, selected) if Settings.started == false then increaseQuestsSelected(selected) end end
function closeHeroTurnPanelUI(player) closePanel(player.color, 'heroTurnPanelClosedBy', 'HeroTurnPanel') end
function closeActionsPanelUI(player) closePanel(player.color, 'actionsPanelClosedBy', 'ActionsPanel') end
function closeDifficultyPanelUI(player) closePanel(player.color, 'difficultyPanelClosedBy', 'DifficultyPanel') end
function openHeroTurnPanelUI(player) openPanel(player.color, 'heroTurnPanelClosedBy', 'HeroTurnPanel') end
function openActionsPanelUI(player) openPanel(player.color, 'actionsPanelClosedBy', 'ActionsPanel') end
function openDifficultyPanelUI(player) openPanel(player.color, 'difficultyPanelClosedBy', 'DifficultyPanel') end
function createBlightMountainsUI(o, c, a) Blights.createBlight('Mountains') end
function createBlightCastleUI(o, c, a) Blights.createBlight('Castle') end
function createBlightVillageUI(o, c, a) Blights.createBlight('Village') end
function createBlightSwampUI(o, c, a) Blights.createBlight('Swamp') end
function createBlightForestUI(o, c, a) Blights.createBlight('Forest') end
function createBlightRuinsUI(o, c, a) Blights.createBlight('Ruins') end
function createBlightMonasteryUI(o, c, a) Blights.createBlight('Monastery') end
function getItemMountainsUI(o, c, a) Blights.getItem('Mountains',c) end
function getItemCastleUI(o, c, a) Blights.getItem('Castle',c) end
function getItemSwampUI(o, c, a) Blights.getItem('Swamp',c) end
function getItemForestUI(o, c, a) Blights.getItem('Forest',c) end
function getItemRuinsUI(o, c, a) Blights.getItem('Ruins',c) end
function getItemMonasteryUI(o, c, a) Blights.getItem('Monastery',c) end
function increaseDarknessUI() Darkness.Move.Darkness(1) end
function decreaseDarknessUI() Darkness.Move.Darkness(-1) end
function increaseCluesUI() Darkness.Move.Clues(1) end
function decreaseCluesUI() Darkness.Move.Clues(-1) end
function necroIncreaseDarknessUI() Darkness.increaseDarknessConsideringBlights() end
function drawArtifactUI(o, c, a) Utility.Draw.Card({ Target = 'Player', Type = 'Artifact', Color = c }) end
function drawMapUI(o, c, a) Utility.Draw.Card({ Target = 'Discard', Type = 'Map' }) end
function drawMysteryUI(o, c, a) Utility.Draw.Card({ Target = 'Player', Type = 'Mystery', Color = c }) end
function getArtifact(o,c) Utility.Draw.Item({ItemName = 'Artifact', Color = c}) end
function getBottledMagic(o,c) Utility.Draw.Item({ItemName = 'Bottled Magic', Color = c}) end
function getCharm(o,c) Utility.Draw.Item({ItemName = 'Charm', Color = c}) end
function getCursedAshes(o,c) Utility.Draw.Item({ItemName = 'Cursed Ashes', Color = c}) end
function getPsionStone(o,c) Utility.Draw.Item({ItemName = 'Psion Stone', Color = c}) end
function getSkullToken(o,c) Utility.Draw.Item({ItemName = 'Skull Token', Color = c}) end
function getSoothingLyre(o,c) Utility.Draw.Item({ItemName = 'Soothing Lyre', Color = c}) end
function getTomeOfRetraining(o,c) Utility.Draw.Item({ItemName = 'Tome of Retraining', Color = c}) end
function getTreasureChest(o,c) Utility.Draw.Item({ItemName = 'Treasure Chest', Color = c}) end
function getVanishingDust(o,c) Utility.Draw.Item({ItemName = 'Vanishing Dust', Color = c}) end
function getWaystone(o,c) Utility.Draw.Item({ItemName = 'Waystone', Color = c}) end
function getMystery(o,c) Utility.Draw.Item({ItemName = 'Mystery', Color = c}) end
function getRevelation(o,c) Utility.Draw.Item({ItemName = 'Revelation', Color = c}) end
function drawEventUI(o, c, a) Utility.Draw.Event(o, c, a) end
function omenDrawUI(o, c, a) Utility.Draw.OmenEvent(o, c, a) end
function addQuestProgressUI(card) Quests.addProgress(card) end
function addTimeUI(card) Quests.addTime(card) end
function addQuestTimersUI() Quests.addaddQuestTimers() end
function rollQuestUI() Quests.rollQuest() end