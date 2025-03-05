function onLoad(saveData)
    addHotkey("Return Token", function(playerColor, object, pointerPosition, isKeyUp)
        if isKeyUp == true then return end
        if object ~= nil then
            returnItem(object)
        end
    end, true)

    printToAll('Go to Options -> Game Keys and add a hotkey for returning tokens.', stringColorToRGB('Yellow'))

    -- Load the save data, if present.
    if saveData and saveData ~= "" then
       Settings = JSON.decode(saveData)
    end
    -- print(JSON.encode(Settings))
    showHidePanelForAllPlayers()
    updateMapTypeName()

    math.randomseed(os.time())

    PlayerBoard = getObjectFromGUID('65a138')

    -- Set items uninteractable
    for key, uninteractableObject in ipairs(getObjectsWithTag('Uninteractable')) do
        uninteractableObject.interactable = false
    end

    highlightPawns()
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