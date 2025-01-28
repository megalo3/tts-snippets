require("Burgundy.Data")
require("Burgundy.Setup")
require("Burgundy.Utility")
require("Burgundy.Map")
require("Burgundy.Hexes")
require("Burgundy.Vineyard")
require("Burgundy.TradeRoute")
require("Burgundy.GameBoard")
require("Burgundy.Round")
require("Burgundy.TradeGood")
require("Burgundy.TurnTrack")

function onLoad(saveState)
    SetupBag = getObjectFromGUID(Guids.Bags.setup)
    BlackBag = getObjectFromGUID(Guids.Bags.blackmarket)
    BuildingBag = getObjectFromGUID(Guids.Bags.building)
    ShieldBag = getObjectFromGUID(Guids.Bags.shield)
    TradeRouteBag = getObjectFromGUID(Guids.Bags.traderoute)
    WorkerBag = getObjectFromGUID(Guids.Bags.worker)

    setPlayerBoardDuchyButtons()

    local loadedData = JSON.decode(saveState)
    if loadedData ~= nil then
        -- settings = loadedData
    end

    math.randomseed(os.time())
    -- Set items uninteractable
    for key, object in ipairs(getObjectsWithTag('noninteractable')) do
        object.interactable = false
    end

    if settings.setupComplete == true then
        setupMenu('false')
        setAdvanceButtons()
    end
end

function onSave()
    return JSON.encode(settings)
end

function onPlayerTurn(player, previous_player)
end

function setupMenu(value)
    UI.setAttribute('optionsMenu1', 'active', value)
    UI.setAttribute('optionsMenu2', 'active', value)
    UI.setAttribute('optionsMenu3', 'active', value)
end

function uiToggle(player,value,id)
    local case = {
        aimoda = function() settings.aimodes.a = coerceBoolean(value) end,
        aimodb = function() settings.aimodes.b = coerceBoolean(value) end,
        aimodc = function() settings.aimodes.c = coerceBoolean(value) end,
        aimodd = function() settings.aimodes.d = coerceBoolean(value) end,
        randomboard = function() settings.randomboard = coerceBoolean(value) end,
        boards0110 = function() boardOptionsChange('b0110', value) end,
        boards1118 = function() boardOptionsChange('b1118', value) end,
        boards1922 = function() boardOptionsChange('b1922', value) end,
        boards2330 = function() boardOptionsChange('b2330', value) end,
        shields = function() settings.components.shields = coerceBoolean(value) end,
        traderoutes = function() settings.components.traderoutes = coerceBoolean(value) end,
        vineyards = function() settings.components.vineyards = coerceBoolean(value) end,
        monastery2728 = function() settings.components.monastery2728 = coerceBoolean(value) end,
        cranes = function() settings.components.cranes = coerceBoolean(value) end,
        whitecastles = function() settings.components.whitecastles = coerceBoolean(value) end,
        geese = function() settings.components.geese = coerceBoolean(value) end,
        inns = function() settings.components.inns = coerceBoolean(value) end,
        castleplacement = function() settings.rules.castleplacement = coerceBoolean(value) end,
        borderposts = function() settings.rules.borderposts = coerceBoolean(value) end,
        vineyardrandomness = function() settings.rules.vineyardrandomness = coerceBoolean(value) end,
    }
    case[id]()
end

function playStyleSelected(player, option)
    if option == 'Normal Game' then
        settings.playstyle = 'normal'
    end
    if option == 'Max 3 Players and AI Player' then
        settings.playstyle = 'ai'
    end
    if option == 'Solo Game (Beginner)' then
        settings.playstyle = 'beginnersolo'
        settings.gameboard = '2p'
    end
    if option == 'Solo Game (Advanced)' then
        settings.playstyle = 'advancedsolo'
        settings.gameboard = '2p'
    end
    if option == 'Team Game (2v2, Beginner)' then
        settings.playstyle = 'beginnerteamgame'
        settings.gameboard = '34p'
    end
    if option == 'Team Game (2v2, Advanced)' then
        settings.playstyle = 'advancedteamgame'
        settings.gameboard = '34p'
    end
 end

function boardOptionsChange(board, value)
    settings.boards[board] = coerceBoolean(value)
    local availableBoards = {}
    if settings.boards.b0110 == true then
        availableBoards = {1,2,3,4,5,6,7,8,9,10}
    end
    if settings.boards.b1118 == true then
        availableBoards = tableConcat(availableBoards, {11,12,13,14,15,16,17,18})
    end
    if settings.boards.b1922 == true then
        availableBoards = tableConcat(availableBoards, {19,20,21,22})
    end
    if settings.boards.b2330 == true then
        availableBoards = tableConcat(availableBoards, {23,24,25,26,27,28,29,30})
    end
    settings.availableBoards = availableBoards
end