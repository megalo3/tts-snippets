WorkshopId = '3281151120'

settings = {
    playercount = 1,
    playstyle = 'normal',
    gameboard = '2p',
    aimodes = {
        a = false,
        b = false,
        c = false,
        d = false,
    },
    aiPlayerColor = '',
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
        vineyardrandomness = true,
        borderpostscoring = false
    },
    mapNumberIndex = {
        Red = 1,
        Blue = 1,
        Yellow = 1,
        Purple = 1
    },
    setupComplete = false,
    phase = 'A',
    turnTrack = {
        {'Blue', 'Yellow', 'Purple', 'Red'},
        {},
        {},
        {},
        {},
        {},
        {}
    }
}
DeploySpeed = 0.18
Guids = {
    Boards = {
        mainboard2p = '61fa13',
        mainboard34p = 'ed5016',
        beginnersolo = '5b998f',
        advancedsolo = 'cca96f',
        teams31pb = '76c053',
        teams31yr = 'c8e5f5',
        teams32pb = 'edc374',
        teams32yr = '158d3a',
        aiboard35 = '8b4626',
        aiboard36 = '977deb',
        vineyarddepot = 'b4e585',
        vineyard23p = '9806c3',
        vineyard4p = '56368e',
        traderoute4 = 'd3eb55',
        traderoute3 = 'ef6fcf',
        traderoute2 = 'fc3766',
    },
    Decks = {
        aibasic = 'a36dac',
        aivineyard = '4c280f'
    },
    AllHexesToken = '6cb7b0',
    Bags = {
        building = 'ff455f',
        monastery = '22d394',
        blackmarket = '3a779f',
        inn = '341be2',
        livestock = 'b6e19b',
        castle = '27d3a4',
        mine = '622583',
        Ship = 'c878c8',
        traderoute = '423ed9',
        vineyard = '6394c8',
        shield = 'bf2a10',
        setup = 'f8f2fb',
        worker = '240f8b',
        coin = 'c94dda'
    },
    Zones = {
        gameboard = '82f251',
        vineyard = '58f596',
        aideck = '71e23f'
    },
    Hands = {
        Red = '727836',
        Yellow = 'd8a545',
        Purple = '306b40',
        Blue = 'c071ab'
    },
    Tokens = {
        borderpost234 = 'f992d9',
        borderpost567 = 'c4e8c1',
        Black234 = 'd3def9',
        Black567 = 'da5205',
        Tan234 = '63ddde',
        Tan567 = 'e222a9',
        Blue234 = 'bdd6b1',
        Blue567 = '6a872e',
        Green234 = 'ae90fc',
        Green567 = '24718a',
        Red234 = 'e6dabb',
        Red567 = 'a64643',
        Yellow234 = 'b66475',
        Yellow567 = '3b87f1'
    },
    Hexes = {
        geese = 'c15c04',
        blackwhitecastle = '22533c',
        blackwhitecastle2 = 'e2df18',
        whitecastle1 = '3b5397',
        whitecastle2 = '9172cb',
        whitecastle3 = '376df4',
        whitecastle4 = '1276a4',
        whitecastle5 = 'ed3b0c',
        whitecastle6 = '3ab130',
        crane = 'e24eaa',
        monastery27 = '786989',
        monastery28 = 'b2387b'
    },
    Scripts = {
        vineyard = '5147db',
        utility = '47fd87',
        map = '97996f',
        round = 'ecde2b',
        gameboard = '300972',
        traderoute = '7669dc',
        hexes = '70daf0',
        tradegood = '4887fd',
        data = '99734f',
        turntrack = '335c88'
    },
    Text = {
        phase = '21f255',
        boardrule = '923383',
        borderscoring = '7d9ac6'
    },
    PlayerDie = '8fe639',
    AiCheatSheet = '3e20e0',
    Shield2 = '6b83d8'
}

Positions = {
    TurnOrder12 = {
        {0,0,0},
        {-0.83, 0, 2.35},
        {-0.72, 0, 4.85},
        {-0.69, 0, 7.30},
        {-1.10, 0, 9.55},
        {-1.72, 0, 11.55},
        {-1.72, 0, 13.95},
    },
    TurnOrder34 = {
        {0.14,0,0.13},
        {-0.7, 0, 2.48},
        {-0.58, 0, 4.94},
        {-0.52, 0, 7.36},
        {-0.95, 0, 9.51},
        {-1.52, 0, 11.45},
        {-1.52, 0, 13.75},
    },
    TurnOrderY = {
        1.20,
        1.57,
        1.93,
        2.30,
    },
    PlayerBoards = {
        Red = {-30.00, 0.97, -14.00},
        Blue = {30.00, 0.97, -14.00},
        Purple = {-30.00, 0.97, 17.44},
        Yellow = {30.00, 0.97, 17.44}
    },
    PlayerVine = {
        Red = {-49.08, 1.5, -6.61},
        Yellow = {42.85, 1.5, 25},
        Purple = {-49.08, 1.5, 25},
        Blue = {42.85, 1.5, -6.61}
    }
}

Vines = {'Orange', 'Yellow', 'Green', 'Red', 'Black', 'Blue'}

Descriptions = {}
Descriptions['Bank'] = 'When you place a bank in your duchy, immediately gain 2 silver coins from the supply.'
Descriptions['Boarding House'] = 'When you place a boarding house in your duchy, immediately gain 4 worker tokens from the supply.'
Descriptions["Carpenter's Workshop"] = "When you place a carpenter's workshop in your duchy, you may immediately take a beige building tile from any of the six depots on the game board (except the central black depot) and place it on an empty key space in the bottom right of your player board."
Descriptions['Castle'] = 'Whenever you place a castle tile in your duchy, you immediately take an additional action, just as if you had another die with your choice of result at your disposal.'
Descriptions['Church'] = 'When you place a church in your duchy, you may immediately take a mine (gray), monastery (yellow), or castle (burgundy) tile from any of the six depots on the game board (except the central black depot) and place it on an empty key space in the bottom right of your player board.'
Descriptions['Crane'] = 'When you place a crane in your duchy, you may immediately trigger the effect of any building (beige) tile you want, even if that building is not in your duchy.\n\nFor example, you could sell goods (warehouse), or gain 2 silver coins (bank), or take a castle tile from the game board (church), etc.\n\n Additionally, during final scoring at the end of the game, the crane counts as a building of your choice for the corresponding monastery tiles (16-23 + 29).\n\nThis may be a different building from the one you triggered when placing the crane.'
Descriptions['Geese'] = 'When you place the two geese in your duchy, you score 2 victory points as normal, plus victory points for one other type of livestock that is in the same pasture. Later, whenever you place another livestock tile in the same pasture, you score 2 victory points for the geese tile. In addition, geese count as additional type of livestock for monastery tiles #7 and #24.\n\nExample: Carla places the geese tile on a pasture that already has a 2 and a 3 cow tile. Carla scores 2+2+3 = 7 victory points. During a later turn, she places a 4 pig tile in the same pasture and scores 4+2 = 6 victory points.'
Descriptions['Inn'] = "At the beginning of each phase, place one inn on the indicated space next to the central black depot. Unlike other hex tiles, inns are not removed from the board at the end of each phase. If there is already an inn next to the central black depot, stack the new one on top.\n\nLike every other hex tile from the black depot, inns may be bought by paying 2 silver coins, and placed on a key space on the player's board.\n\nAn inn may be placed on any empty hex space on your duchy (according to the regular rules). However, you may only place up to one inn per color area!\n\nThe inn itself has no effect, its only function is to complete an area.\n\nImportant: By placing an inn, you increase the size of that area by 1. A 9-space area scores 45 victory points."
Descriptions['Livestock'] = 'Whenever you place a livestock tile in your duchy, you immediately score victory points. Each tile shows 2-4 livestock, which is the amount of victory points you score.\n\nAdditionally, if you already have at least one other tile with the same livestock in the same pasture (a contiguous area of green hex spaces), you also score victory points for those other tiles.'
Descriptions['Mine'] = 'Mines are tiles with no immediate effect when they are placed. At the end of each phase you gain one silver coin from the supply for each mine in your duchy.'
Descriptions['Market'] = 'When you place a market in your duchy, you may immediately take a ship (blue) or livestock (green) tile from any of the six depots (except the central black depot) and place it on an empty key space in the bottom right of your player board.'
Descriptions['Monastery 1'] = 'You are no longer limited to one building (beige) tile per type in each of your towns. In other words, you may build more than one building of the same type within a single town.'
Descriptions['Monastery 2'] = 'For each mine you have placed, you gain a worker in addition to the silver coin at the end of each phase.'
Descriptions['Monastery 3'] = 'You gain 2 silver coins instead of 1 whenever you sell goods (either when taking the die action or when placing a warehouse).'
Descriptions['Monastery 4'] = 'Whenever you sell a type of goods (either when taking the die action or when placing a warehouse), you gain a worker in addition to the silver coin you normally receive.'
Descriptions['Monastery 5'] = 'Whenever you place a ship tile, in addition to taking all goods tiles from a depot of your choice, you may also take all goods tiles from an adjacent depot.'
Descriptions['Monastery 6'] = 'Once per turn, you may spend 2 worker tokens to immediately take a building (beige) tile from any of the six depots on the game board (except the central black depot) and place it on an empty key space in the bottom right of your player board.'
Descriptions['Monastery 7'] = 'Whenever you place a livestock tile, in addition to the usual bonus for existing livestock of the same type in the same pasture, you also score 1 victory point for each livestock tile that scores at that time.\n\nExample: Ben places a 3 sheep tile on the pasture that already contains a 4 sheep tile: He gains (3+1) + (4+1) = 9 victory points. If he places a 2 pig tile, he gets 3 victory points.'
Descriptions['Monastery 8'] = 'Whenever you use a worker to change the result of a die, you may add or subtract 2 instead of 1.\n\nExample: To change a 3 to a 6, Carla only needs to use 2 workers instead of 3.'
Descriptions['Monastery 9'] = 'Whenever you want to place a building (beige) tile in your duchy, you may change the die result by 1 (just as if you were using a worker).'
Descriptions['Monastery 10'] = 'Whenever you want to place a ship or a livestock tile (blue and green tiles) in your duchy, you may change the die result by 1 (just as if you were using a worker).'
Descriptions['Monastery 11'] = 'Whenever you want to place a castle, mine, or monastery tile (burgundy, gray, and yellow tiles) in your duchy, you may change the die result by 1 (just as if you were using a worker).'
Descriptions['Monastery 12'] = 'Whenever you want to take a hex tile from the game board, you may change the die result by 1 (just as if you were using a worker).'
Descriptions['Monastery 13'] = 'Whenever you use the "Take 2 worker tokens" action, you gain 1 silver coin in addition to the 2 worker tokens from the supply.\n\nNote: This and the next tile have no effect when placing a Boarding house.'
Descriptions['Monastery 14'] = 'Whenever you use the "Take 2 worker tokens" action, you gain 4 worker tokens instead of the usual 2.'
Descriptions['Monastery 15'] = 'At the end of the game, you score 2 victory points for each different type of goods tile in your sold goods pile. Unsold goods are ignored.\n\nNote: You may look at your sold goods pile at any time during the game.\n\nExample: Dario has sold the following goods tiles: 4x red, 3x purple, 3x pink and 1x orange. He scores 4 types x 2 = 8 victory points.'
Descriptions['Monastery 16'] = 'At the end of the game, you score 4 victory points for each Warehouse that you placed in your duchy.'
Descriptions['Monastery 17'] = 'At the end of the game, you score 4 victory points for each Watchtower that you placed in your duchy.'
Descriptions['Monastery 18'] = "At the end of the game, you score 4 victory points for each Carpenter's Workshop that you placed in your duchy."
Descriptions['Monastery 19'] = 'At the end of the game, you score 4 victory points for each Church that you placed in your duchy.'
Descriptions['Monastery 20'] = 'At the end of the game, you score 4 victory points for each Market that you placed in your duchy.'
Descriptions['Monastery 21'] = 'At the end of the game, you score 4 victory points for each Boarding House that you placed in your duchy.'
Descriptions['Monastery 22'] = 'At the end of the game, you score 4 victory points for each Bank that you placed in your duchy.'
Descriptions['Monastery 23'] = 'At the end of the game, you score 4 victory points for each Town Hall that you placed in your duchy.'
Descriptions['Monastery 24'] = 'At the end of the game, you score 4 victory points for each different livestock type that you placed in your duchy.\n\nExample: Anna has placed 3 sheep, 1 cow, and 1 pig tile in her duchy. At the end of the game she scores 3 types x 4 = 12 victory points.'
Descriptions['Monastery 25'] = 'At the end of the game, you score 1 victory point for each goods tile you sold. Unsold goods are ignored.\n\nExample: If Dario had placed this tile as well, he would score 11 additional victory points.\n\nExample: Dario has sold the following goods tiles: 4x red, 3x purple, 3x pink and 1x orange. He scores 4 types x 2 = 8 victory points.'
Descriptions['Monastery 26'] = 'At the end of the game, you score 3 victory points for each bonus tile (large and small) you own.'
Descriptions['Monastery 27'] = 'If your turn order marker is in a stack with other markers, it is always placed on top. This applies both actively and passively (i.e. whenever another marker is moved onto the same space, yours is placed on top).'
Descriptions['Monastery 28'] = 'If this tile is in your duchy, you can buy workers from the supply at any time. 2 workers cost 1 silver coin.'
Descriptions['Monastery 29'] = 'At the end of the game, you score 4 victory points for each White Castle that you placed in your duchy.'
Descriptions['Ships'] = 'Take all goods from 1 depot. Advance 1 space on the turn order track.'
Descriptions['Town Hall'] = 'When you place a town hall in your duchy, you may immediately choose a second hex tile from your storage and place it in your duchy. Placing the tile triggers its effect, as usual.'
Descriptions['Watchtower'] = 'When you place a watchtower in your duchy, you immediately score 4 victory points.'
Descriptions['Warehouse'] = ' When you place a warehouse in your duchy, you may immediately (without having to use a die) choose a type of goods tile you own and sell that stack, just as if you had taken the “Sell goods” action.'
Descriptions['White Castle'] = "When you place a white castle in your duchy, immediately take an action using the current result of the white die. You are allowed to use workers to change the rolled number (don't change the actual white die result)."

Colors = {'Yellow','Purple','Red','Blue'}
ColorTint = {
    Red = {0.96, 0.5, 0.35},
    Yellow = {0.8, 0.71, 0.16},
    Purple = {0.57, 0.47, 0.73},
    Blue = {0.38, 0.58, 0.87}
}
ColorTintAlpha = {
    Red = {0.96, 0.5, 0.35, 0.85},
    Yellow = {0.8, 0.71, 0.16, 0.85},
    Purple = {0.57, 0.47, 0.73, 0.85},
    Blue = {0.38, 0.58, 0.87, 0.85}
}
ColorTintAlphaHover = {
    Red = {0.96, 0.5, 0.35, 1},
    Yellow = {0.8, 0.71, 0.16, 1},
    Purple = {0.57, 0.47, 0.73, 1},
    Blue = {0.38, 0.58, 0.87, 1}
}
-- ColorTint = {
--     Red = 'F57F59',
--     Yellow = 'CBB529',
--     Purple = '9178BA',
--     Blue = '6095DE'
-- }
Phases = {'A', 'B', 'C', 'D', 'E'}

MapStates = {
    y1 = 1,y2 = 2,y3 = 3,y4 = 4,y5 = 5,y6 = 6,
    t1 = 7,t2 = 8,t3 = 9,t4 = 10,t5 = 11,t6 = 12,
    g1 = 13,g2 = 14,g3 = 15,g4 = 16,g5 = 17,g6 = 18,
    e1 = 19,e2 = 20,e3 = 21,e4 = 22,e5 = 23,e6 = 24,
    b1 = 25,b2 = 26,b3 = 27,b4 = 28,b5 = 29,b6 = 30,
    r1 = 31,r2 = 32,r3 = 33,r4 = 34,r5 = 35,r6 = 36
}
MapNumbers = {
    {'6','5','4','3'},
    {'2','1','6','5','4'},
    {'5','4','3','1','2','3'},
    {'6','1','2','6','5','4','1'},
    {'2','5','4','3','1','2'},
    {'6','1','2','5','6'},
    {'3','4','1','3'}
}
MapColors = {
    -- #1
    {
        {'g','r','r','y'},
        {'g','g','r','y','t'},
        {'g','g','t','y','t','t'},
        {'b','b','b','r','b','b','b'},
        {'t','t','e','t','t','g'},
        {'t','e','y','t','t'},
        {'e','y','y','t'}
    },
    -- #2
    {
        {'y','y','y','r'},
        {'t','t','b','g','e'},
        {'e','t','t','b','g','b'},
        {'r','t','b','r','y','t','b'},
        {'y','b','t','g','y','t'},
        {'t','t','g','t','e'},
        {'g','g','t','r'}
    },
    -- #3
    {
        {'g','g','g','g'},
        {'b','b','r','b','b'},
        {'t','e','y','y','b','t'},
        {'t','t','y','r','y','t','t'},
        {'t','t','y','y','t','t'},
        {'r','g','e','e','r'},
        {'t','g','b','t'}
    },
    -- #4
    {
        {'r','t','b','t'},
        {'g','g','t','b','b'},
        {'t','g','t','b','r','e'},
        {'g','g','g','y','y','e','b'},
        {'t','r','y','t','t','y'},
        {'t','e','t','y','t'},
        {'b','t','y','r'}
    },
    -- #5
    {
        {'g','t','t','b'},
        {'g','g','t','e','e'},
        {'t','r','y','b','b','b'},
        {'t','t','g','y','r','t','t'},
        {'y','r','g','y','b','t'},
        {'t','g','t','r','b'},
        {'y','y','t','e'}
    },
    -- #6
    {
        {'y','y','r','b'},
        {'y','t','t','b','t'},
        {'g','g','e','b','t','t'},
        {'y','t','t','r','b','t','t'},
        {'y','t','t','e','b','t'},
        {'y','e','g','g','b'},
        {'r','g','g','r'}
    },
    -- #7
    {
        {'y','r','r','b'},
        {'y','g','g','g','b'},
        {'b','e','t','t','e','g'},
        {'b','y','t','t','t','g','t'},
        {'t','y','t','t','g','t'},
        {'t','b','e','y','t'},
        {'b','r','r','y'}
    },
    -- #8
    {
        {'t','t','b','t'},
        {'t','r','y','r','t'},
        {'t','y','e','y','y','b'},
        {'b','g','y','e','g','y','b'},
        {'b','g','g','e','g','t'},
        {'t','r','g','r','t'},
        {'t','b','t','t'}
    },
    -- #9
    {
        {'t','t','r','y'},
        {'t','t','g','g','b'},
        {'t','t','g','g','b','b'},
        {'r','y','y','e','b','r','y'},
        {'b','b','y','e','t','g'},
        {'y','t','t','t','g'},
        {'e','r','t','t'}
    },
    -- #10
    {
        {'b','t','g','r'},
        {'g','b','t','g','t'},
        {'g','g','g','t','y','t'},
        {'t','t','t','t','t','y','r'},
        {'y','y','e','y','e','b'},
        {'t','t','e','y','b'},
        {'r','b','b','r'}
    },
    -- #11
    {
        {'t','t','t','t'},
        {'y','y','r','g','g'},
        {'y','y','b','b','g','g'},
        {'r','t','t','t','t','t','r'},
        {'b','g','g','y','y','e'},
        {'b','b','r','e','e'},
        {'b','t','t','t'}
    },
    -- #12
    {
        {'g','g','g','g'},
        {'t','t','t','g','t'},
        {'b','e','e','r','t','t'},
        {'b','r','b','g','b','b','e'},
        {'b','y','t','t','y','r'},
        {'y','y','t','y','t'},
        {'y','r','t','t'}
    },
    -- #13
    {
        {'t','t','y','t'},
        {'e','r','y','y','t'},
        {'e','t','y','y','y','r'},
        {'r','g','t','g','g','g','t'},
        {'t','e','r','b','g','t'},
        {'t','b','t','b','g'},
        {'b','b','t','b'}
    },
    -- #14
    {
        {'e','t','t','b'},
        {'t','r','e','r','t'},
        {'t','g','g','e','g','t'},
        {'y','t','g','y','g','t','b'},
        {'y','t','g','t','t','b'},
        {'y','r','b','r','b'},
        {'y','t','t','b'}
    },
    -- #15
    {
        {'e','y','y','r'},
        {'r','y','t','t','g'},
        {'b','g','t','t','t','g'},
        {'b','g','e','t','t','t','g'},
        {'b','b','e','b','b','g'},
        {'y','r','t','t','r'},
        {'y','y','t','t'}
    },
    -- #16
    {
        {'t','t','t','t'},
        {'r','y','y','y','g'},
        {'y','t','y','y','g','g'},
        {'t','t','e','e','r','b','b'},
        {'t','e','b','b','g','g'},
        {'r','t','t','t','g'},
        {'b','b','t','r'}
    },
    -- #17
    {
        {'y','y','r','t'},
        {'b','b','t','t','t'},
        {'t','b','g','g','g','r'},
        {'t','t','r','e','g','g','y'},
        {'b','b','b','g','e', 'y'},
        {'t','t','r','e','y'},
        {'t','y','t','t'}
    },
    -- #18
    {
        {'t','t','t','t'},
        {'t','t','r','b','b'},
        {'g','g','g','r','b','b'},
        {'e','e','e','r','t','t','t'},
        {'b','b','r','y','y','t'},
        {'y','y','g','g','t'},
        {'y','y','g','t'}
    },
    -- #19
    {
        {'t','g','t','r'},
        {'g','g','g','y','e'},
        {'r','g','e','b','e','t'},
        {'y','y','t','b','b','t','b'},
        {'y','t','t','y','t','b'},
        {'t','g','t','y','r'},
        {'r','t','t','b'}
    },
    -- #20
    {
        {'t','t','t','r'},
        {'r','t','t','e','e'},
        {'y','y','g','e','y','y'},
        {'b','b','g','t','y','g','g'},
        {'t','b','t','g','g','r'},
        {'t','r','b','t','t'},
        {'t','b','b','y'}
    },
    -- #21
    {
        {'r','e','e','b'},
        {'r','t','t','e','b'},
        {'t','t','t','y','t','g'},
        {'t','t','r','g','t','t','g'},
        {'b','g','g','y','r','g'},
        {'y','t','t','y','b'},
        {'y','b','y','b'}
    },
    -- #22
    {
        {'y','y','t','t'},
        {'y','r','t','r','t'},
        {'t','b','t','t','b','t'},
        {'t','t','e','e','e','b','t'},
        {'t','y','g','y','y','g'},
        {'b','r','g','r','g'},
        {'b','b','g','g'}
    },
    -- #23
    {
        {'r','t','t','r'},
        {'y','y','y','y','y'},
        {'b','g','t','t','b','g'},
        {'t','b','t','t','t','g','e'},
        {'t','b','t','t','g','e'},
        {'r','b','y','g','r'},
        {'e','b','g','t'}
    },
    -- #24
    {
        {'t','t','t','r'},
        {'t','e','y','y','t'},
        {'t','e','e','g','y','t'},
        {'r','b','b','g','y','y','t'},
        {'b','b','b','g','y','r'},
        {'b','b','b','b','t'},
        {'t','r','t','t'}
    },
    -- #25
    {
        {'r','t','t','y'},
        {'e','g','t','t','g'},
        {'t','t','r','g','g','g'},
        {'y','t','t','e','b','b','g'},
        {'y','y','y','r','b','b'},
        {'b','t','t','y','e'},
        {'b','t','t','r'}
    },
    -- #26
    {
        {'b','r','r','t'},
        {'b','b','y','t','t'},
        {'b','b','b','t','t','t'},
        {'g','g','e','e','e','y','y'},
        {'g','t','g','g','t','y'},
        {'t','t','g','y','t'},
        {'r','t','y','r'}
    },
    -- #27
    {
        {'e','e','y','y'},
        {'y','t','t','b','t'},
        {'r','y','t','y','b','r'},
        {'g','g','g','y','t','t','e'},
        {'g','b','b','t','t','t'},
        {'g','b','b','t','t'},
        {'g','r','r','t'}
    },
    -- #28
    {
        {'t','t','t','b'},
        {'y','y','r','t','b'},
        {'b','t','t','e','t','t'},
        {'r','t','t','e','g','b','r'},
        {'y','t','e','g','b','b'},
        {'y','t','r','y','y'},
        {'g','g','g','g'}
    },
    -- #29
    {
        {'t','t','e','b'},
        {'t','g','g','t','t'},
        {'t','r','t','y','r','t'},
        {'b','b','t','r','y','t','b'},
        {'g','g','t','y','b','b'},
        {'e','g','r','t','y'},
        {'g','y','y','e'}
    },
    -- #30
    {
        {'b','b','y','e'},
        {'b','t','y','y','b'},
        {'g','t','t','t','t','r'},
        {'r','b','r','g','g','g','g'},
        {'t','t','t','y','t','r'},
        {'t','t','y','y','t'},
        {'e','g','b','e'}
    }
}