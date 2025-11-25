function setupMenu(value)
    UI.setAttribute('optionsMenu1', 'active', value)
    UI.setAttribute('optionsMenu2', 'active', value)
    UI.setAttribute('optionsMenu3', 'active', value)
end

function updateStartingPlayerMenu()
    local nonSeated = {table.unpack(getSeatedPlayerColors())}
    local name = 'StartingPlayer-'
    if has_value(nonSeated, 'White') then
        name = name .. 'w'
        settings.playerTurn = 'White'
    end
    if has_value(nonSeated, 'Pink') then
        name = name .. 'p'
        if settings.playerTurn == '' then settings.playerTurn = 'Pink' end
    end
    if has_value(nonSeated, 'Orange') then
        name = name .. 'o'
        if settings.playerTurn == '' then settings.playerTurn = 'Orange' end
    end
    if has_value(nonSeated, 'Yellow') then name = name .. 'y' end
    UI.setAttribute(name, 'active', 'true')
end

function startingPlayerMenu(value)
    if value == 'true' then updateStartingPlayerMenu() end
    UI.setAttribute('startPlayerMenu', 'active', value)
    UI.setAttribute('startPlayerMenuButtons', 'active', value)
end

function gatherItemsMenu(value)
    UI.setAttribute('gatherItemsMenu', 'active', 'true')
end

function scorePadMenu(value)
    setAllTotals()
    UI.setAttribute('ScorepadMenu', "visibility", "")
end

function uiToggle(player, value, id)
    if id == 'beginner' or id == 'intermediate' or id == 'advanced' then
        if value == 'True' then
            settings.difficulty = id
        end
    else
        if value == 'True' then
            settings[id] = true
        else
            settings[id] = false
        end
    end
end

function scoreChange(player, value, id)
    scoreChange({ id = id, value = value })
end

-- Inverts a UI visibility table, so all players currently present in it are removed, while all players not present are added.
function invertUIVisibilityTable(visibilityTable)
    local newVisibilityTable = {}

    -- Loop through the available seats.
    for _, value in ipairs(Player.getColors()) do
        -- If they're not currently in the table, add them.
        print(value)
        print(JSON.encode(visibilityTable))
        if not table.inTable(visibilityTable, value) then
            table.insert(newVisibilityTable, value)
        end
    end

    print(JSON.encode(newVisibilityTable))
    return newVisibilityTable
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

function closePanel(color)
    table.insert(settings.scorePadPanelClosedBy, color)
    showHidePanelsForPlayers('ScorepadMenu')
end
function openPanel(color)
    table.removeByValue(settings.scorePadPanelClosedBy, color)
    showHidePanelsForPlayers('ScorepadMenu')
end

function showHidePanelsForPlayers()
    local visibility = getVisibilityString(invertUIVisibilityTable(settings.scorePadPanelClosedBy), true)
    UI.setAttribute('ScorepadMenu', "visibility", visibility)
    local buttonVisibility = getVisibilityString(settings.scorePadPanelClosedBy, true)
    UI.setAttribute('ScorepadMenu' .. "Button", "visibility", buttonVisibility)
end

function openScorePadPanelUI(player) openPanel(player.color) end
function closeScorePadUI(player) closePanel(player.color) end