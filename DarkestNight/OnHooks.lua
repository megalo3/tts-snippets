LocationAreas = {}

function onLoad(saveData)
    for _, location in ipairs(Data.Location.Areas) do
        LocationAreas[location] = getPolygonArea(location)
    end

    addHotkey("Return Token", function(playerColor, object, pointerPosition, isKeyUp)
        if isKeyUp == true then return end
        if object ~= nil then
            Utility.returnItem(object)
        end
    end, true)

    printToAll('Go to Options -> Game Keys and add a hotkey for returning tokens.', stringColorToRGB('Yellow'))

    -- Load the save data, if present.
    if saveData and saveData ~= "" then
       Settings = JSON.decode(saveData)
    end
    showHidePanelForAllPlayers()
    updateMapTypeName()

    math.randomseed(os.time())

    PlayerBoard = getObjectFromGUID('65a138')

    -- Set items uninteractable
    for key, uninteractableObject in ipairs(getObjectsWithTag('Uninteractable')) do
        uninteractableObject.interactable = false
    end

    highlightPawns()

    if Settings.started == true then
        setDifficultyUninteractable()
    end
end

function onObjectNumberTyped(object,  player_color,  number)
    if object.type == 'Deck' then
        if number > 9 then
            print("Sorry. You can only draw a maximum of 9 cards.")
            return true
        end
        object.deal(number, player_color)
        return true
    end
end

function onObjectRotate(object, spin, flip, player_color, old_spin, old_flip)
    if flip ~= old_flip then
        if object.hasTag('Activity') then
            Wait.time(function() setNecroPanel() end, .35)
        end
    end
end

-- Called when the game is saved.
function onSave()
    -- Save the game's Settings.
    return JSON.encode(Settings)
end

function addQuestProgress(card) Quests.addProgress(card) end
function addTime(card) Quests.addTime(card) end
function onObjectSpawn(object)
    if object.hasTag("Quest") and object.type == 'Card' then
        object.createButton({
            click_function = "addQuestProgress",
            function_owner = Global,
            label          = "+",
            position       = {-0.8,0.25,-.35},
            rotation       = {0,0,0},
            width          = 125,
            height         = 125,
            font_size      = 100,
            color          = {0/255,255/255,130/255,0.9},
            font_color     = {95/255,120/255,0/255,1},
        })
        object.createButton({
            click_function = "addTime",
            function_owner = Global,
            label          = "+",
            position       = {0.8,0.25,-.35},
            rotation       = {0,0,0},
            width          = 125,
            height         = 125,
            font_size      = 100,
            color          = {0/255,255/255,130/255,0.9},
            font_color     = {95/255,120/255,0/255,1},
        })
    end
end

isMonitoring = false
function onObjectRandomize(object, color)
    if isMonitoring == true then return end
    isMonitoring = true
    waitMonitor(color)
end