Colors = {'Red', 'Yellow', 'Green', 'Blue'}

resupplyInProgress = false

startPlayerCard = nil
tileBag = nil
gameLoaded = false
discardBag = nil
jokerBag = nil
gardenExpansionBag = nil

-- Round 1, 2, 3, 4, Supply
ExpansionLocations = {
    {-9.38, 1.06, 0.39},
    {15.70, 1.23, 4.51},
    {15.70, 1.23, 0.39},
    {15.71, 1.23, -3.79},
    {9.77, 1.24, 0.43}
}

DeployTileZone = 'dd6520'

function onLoad()
    math.randomseed(os.time())
    -- Set items uninteractable
    for key, object in ipairs(getObjectsWithTag('noninteractable')) do
        object.interactable = false
    end
    for key, object in ipairs(getObjectsWithTag('Joker')) do
        object.locked = false
    end

    startPlayerCard = getObjectFromGUID('f39ae8')
    tileBag = getObjectFromGUID('4fd8a3')
    tileBag.shuffle()
    discardBag = getObjectFromGUID('8babe8')
    jokerBag = getObjectFromGUID('b1989a')
    gardenExpansionBag = getObjectFromGUID('8d465f')

    if (startPlayerCard.hasTag('started')) then
        UI.hide('StartPanel')
    end
    gameLoaded = true

    setLockTileButtons()

    addHotkey("Return Token", function(playerColor, object, pointerPosition, isKeyUp)
        if isKeyUp == true then return end
        if object ~= nil then
            returnItem(object)
        end
    end, true)
    printToAll('Go to Options -> Game Keys and add a hotkey for returning tiles.', stringColorToRGB('Yellow'))
end

function onObjectEnterScriptingZone(zone, card)
    -- Only act if dropped in the rotate drop zone
    if (zone.guid != '7050f3' and zone.guid != '3ab246') then return end

    local rotation = card.getRotation()
    card.setRotationSmooth({0, rotation[2] + 60, 0}, true, true)
end

-- The game always starts on the Red player's turn. If there is no Red player,
-- the turn automatically switches to the next player. If a Red player exists,
-- onPlayerTurnEnd will not trigger.
function onPlayerTurnEnd(color)

end

function tryObjectRotate(object, spin, flip, player_color, old_spin, old_flip)
    if object.hasTag('gardenexpansion') then
        -- 0 is face up, 180 is face down
        if flip == 0 then
            object.tooltip = true
        end
        if flip == 180 then
            object.tooltip = false
        end

        -- Allow flipping
        if flip ~= old_flip then return true end

        local customRotation = object.getVar('customRotation')
        if customRotation == nil then
            customRotation = 180
        end

        customRotation = (customRotation + 60) % 360
        object.setVar('customRotation', customRotation)

        local r = object.getRotation()
        object.setRotationSmooth({r[1], customRotation, r[3]}, false, true)
        return false
    end
    return true
end

function start()
    -- Give the starter card "Started" tag to know on load if this is loading a saved game
    startPlayerCard.addTag('started')

    if (not hasPlayerSelectedColors()) then
        print('At least two players must select a color before starting the game.')
        return
    end

    local playerCount = #getSeatedPlayers()

    if (playerCount < 2) then
        print('Azul Queen\'s Garden is 2 to 4 players.')
        return
    end

    -- 4+ player count
    local stackCount = 8;
    if (playerCount == 3) then stackCount = 7 end
    if (playerCount == 2) then stackCount = 5 end

    local expansionBag = getObjectFromGUID('8d465f')
    expansionBag.shuffle()

    for c=1,4 do
        for k=1,stackCount do
            expansionBag.takeObject({
                position = {x=ExpansionLocations[c][1], y=k+1, z=ExpansionLocations[c][3]},
                smooth = true,
                rotation = {180,0,0}
            })
        end
    end

    local leftoverCount = #expansionBag.getObjects()
    -- Move leftover garden expansions to spot 5
    for k=1,leftoverCount do
        expansionBag.takeObject({
            position = {x=ExpansionLocations[5][1], y=k+1, z=ExpansionLocations[5][3]},
            smooth = true,
            rotation = {180,0,0}
        })
    end
    Wait.time(function()
        getObjectFromGUID('7e2574').setPositionSmooth({
            ExpansionLocations[5][1], leftoverCount+2, ExpansionLocations[5][3]
        })
    end, 1.5)

    UI.hide('StartPanel')
    gameStarted = true

end

function returnItem(object)
    if object.locked == true then return end
    if object.hasTag('coloredtile') then
        discardBag.putObject(object)
    end
    if object.hasTag('gardenexpansion') then
        gardenExpansionBag.putObject(object)
    end
    if object.hasTag('Joker') then
        jokerBag.putObject(object)
    end

end

function hasPlayerSelectedColors()
    hasPlayerColors = false;
    for key,value in ipairs(getSeatedPlayers()) do
        if (isPlayerColor(value)) then
            hasPlayerColors = true
        end
    end
    return hasPlayerColors
end

function isPlayerColor(value)
    isColor = false
    for key, color in ipairs(Global.getVar('Colors')) do
        if (color == value) then isColor = true end
    end
    return isColor
end

function setLockTileButtons()
    for index, guid in ipairs({'848999', '6ac068', 'ecbaf8', '09e63e'}) do
        local zone = getObjectFromGUID(guid)
        local params = {
            click_function = "lockTiles",
            function_owner = Global,
            label          = "Lock Tiles",
            position       = {0, -0.2, 0.485},
            rotation       = {0, 0, 0},
            width          = 800,
            height         = 230,
            font_size      = 150,
            color          = {0.5, 0.5, 0.5, 0.9},
            font_color     = {1, 1, 1},
            scale          = {.1, .1, .1},
            tooltip        = "Lock placed tiles. Right click to unlock.",
        }
        if index <= 2 then
            params.rotation[2] = 180
            params.position[3] = -0.485
        end
        zone.createButton(params)
    end
end

function lockTiles(obj, color, alt_click)
    for key, object in ipairs(obj.getObjects()) do
        object.setLock(alt_click == false)
    end
end