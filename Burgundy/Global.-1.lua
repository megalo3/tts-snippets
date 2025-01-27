test = require("YellowPrint")
-- require("DataScript.99734f")

settings = {
    playercount = 1,
    playstyle = 'normal',
    gameboard = '34p',
    aimodes = {
        a = false,
        b = false,
        c = false,
        d = false,
    },
    randomboard = true,
    boards = {
        b0110 = true,
        b1118 = false,
        b1922 = false,
        b2330 = false,
    },
    availableBoards = {1,2,3,4,5,6,7,8,9,10},
    availableVines = {},
    components = {
        shields = false,
        traderoutes = false,
        vineyards = false,
        monastery2728 = true,
        cranes = true,
        whitecastles = true,
        geese = true,
        inns = true,
    },
    rules = {
        castleplacement = false,
        borderposts = false,
        vineyardrandomness = true,
        advancedsolo = false,
    },
    mapNumberIndex = {
        Red = 1,
        Blue = 1,
        Yellow = 1,
        Purple = 1
    },
    setupComplete = false,
    phase = 'A'
}


function onLoad(saveState)
    print(test)
    DataScript = getObjectFromGUID('99734f')
    Guids = DataScript.getTable('Guids')
    MapScript = getObjectFromGUID(Guids.Scripts.map)
    SetupBag = getObjectFromGUID(Guids.Bags.setup)

    local loadedData = JSON.decode(saveState)
    if loadedData ~= nil then
        -- settings = loadedData
    end

    math.randomseed(os.time())
    -- Set items uninteractable
    for key, object in ipairs(getObjectsWithTag('noninteractable')) do
        object.interactable = false
    end

    getObjectFromGUID(Guids.Scripts.gameboard).call('setPlayerBoardDuchyButtons')

    if settings.setupComplete == true then
        setupMenu('false')
    end

    -- setupMenu('false')
end

function onSave()
    return JSON.encode(settings)
end

function onPlayerTurn(player, previous_player)
    -- resupplyVineyards()
    -- switchGameBoard()
end

function setup()
    setupMenu('false')
    local playerCount = #(getSeatedPlayers())
    if settings.playstyle == 'ai'then
        playerCount = playerCount + 1
    end
    if playerCount > 4 then
        playerCount = 4
    end
    settings.playercount = playerCount

    if settings.rules.castleplacement == false then
        SetupBag.putObject(getObjectFromGUID(Guids.Text.boardrule))
    end

    removeUnusedTurnOrderTokens()
    getObjectFromGUID(Guids.Scripts.hexes).call('setIncludedHexes')
    Wait.time(function() getObjectFromGUID(Guids.Scripts.vineyard).call('setVineyards') end, 0.5)
    Wait.time(function() getObjectFromGUID(Guids.Scripts.traderoute).call('setTradeRoutes') end, 1.0)
    Wait.time(function() getObjectFromGUID(Guids.Scripts.gameboard).call('setPlayerBoards') end, 1.5)
    Wait.time(function() getObjectFromGUID(Guids.Scripts.gameboard).call('setGameBoard') end, 2.0)
    Wait.time(function() settings.setupComplete = true end, 3.0)
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







-- UTILITY
-- {tab, val}
function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function has_any_value(tab, values)
    for _, value in ipairs(values) do
        if has_value(tab, value) then
            return true
        end
    end
    return false
end

function coerceBoolean(value)
    if value == 'True' then return true end
    if value == 'False' then return false end
    return value
end

function tableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

-- function yellowPrint(message)
--     printToAll(message, stringColorToRGB('Yellow'))
-- end

-- function GreenPrint(message)
--     printToAll(message, stringColorToRGB('Green'))
-- end

function getSeatedPlayerColors()
    local playerColors = {}
    for _, player in ipairs(Player.getPlayers()) do
        if has_value(Colors, player.color) == true then
            table.insert(playerColors, player.color)
        end
    end
    return playerColors
end

function round(a)
    return math.floor(a+0.5)
end