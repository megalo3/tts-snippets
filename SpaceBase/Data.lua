settings = {
    lightSpeeed = false,
    shyPluto = false,
    biodome = false,
    terraProxima = false,
    genesis = false,
    dreadnaught = false,
    johnDClaire = false,
    deadReckoning = false,
    worldEater = false,
    started = false
}

CameraStates = {
    Red = {
        position = {
            x = -16.5583878,
            y = -2.5,
            z = -14
        },
        pitch = 90,
        yaw = 0,
        distance = 20
    },
    Orange = {
        position = {
            x = -16.5583878,
            y = -2.5,
            z = 0
        },
        pitch = 90,
        yaw = 0,
        distance = 20
    },
    Yellow = {
        position = {
            x = -16.5583878,
            y = -2.5,
            z = 11
        },
        pitch = 90,
        yaw = 0,
        distance = 20
    },
    Blue = {
        position = {
            x = 14.5,
            y = -2.5,
            z = 0
        },
        pitch = 90,
        yaw = 0,
        distance = 20
    },
    Purple = {
        position = {
            x = 14.5,
            y = -2.5,
            z = -14
        },
        pitch = 90,
        yaw = 0,
        distance = 20
    },
    Teal = {
        position = {
            x = 14.5,
            y = -2.5,
            z = 11
        },
        pitch = 90,
        yaw = 0,
        distance = 20
    },
    Green = {
        position = {
            x = -16.5583878,
            y = -2.5,
            z = 23
        },
        pitch = 90,
        yaw = 0,
        distance = 20
    },
    Multi = {
        position = {
            x = -1,
            y = -2.5,
            z = 0
        },
        pitch = 90,
        yaw = 0,
        distance = 15
    },
}

Colors = {'Red', 'Orange', 'Yellow', 'Green', 'Teal', 'Blue', 'Purple'}

SectorDeckColors = {
    {0, 1, 0},
    {1, 1, 0},
    {1, 0, 1},
    {0.5, 1, 0}
}

SectorDealZones = {}
SectorDealZones[1] = {'2f6af8', '3fd8b0', '4faee4', '6f1ab7', '4e14f6', 'f45664'}
SectorDealZones[2] = {'f2a756', 'dcbd86', '1aae77', 'd39780', 'dd4e5a', '44ebd0'}
SectorDealZones[3] = {'abf34d', '3c1ec6', '3454b5', 'a406ac', 'ad25a1', '6d85cc'}
SectorDealZones[4] = {'dc07d3', 'eedc3f', 'ebe528'}

SectorX = {-2.19, -0.76, 0.67, 2.10, 3.53, 4.96}
SectorY = {3.05, -0.49, -3.89, -7.29}

ResupplySectorInProgress = {false, false, false, false}
ResupplyInProgress = false

AutoRollZones = {
    Red = '9e1e40',
    Orange = '4de647',
    Yellow = 'f90ed4',
    Green = 'c22c7b',
    Blue = '31f9ef',
    Teal = '340eb2',
    Purple = 'f44f1f'
}

DiceTags = {
    'bonus roll',
    'charge',
    'credits',
    'income',
    'pluto',
    'ship',
    'victory points',
    'proxima'
}


Guids = {
    DiceRoller = '64e216',
    PlayerBoards = {
        Red = {
            '4b3a9e', 'df0dd7', 'dd9a11', '65e693', '0e0d58', '0e6cb8',
            '2186ff', 'bcd42b', '8cdd7c', 'b88daf', 'e8fe84', 'e0e383', '4f95ef'
        },
        Orange = {
            'c1f6ed', '218833', 'b6a3bb', '23b599', '3340bf', '4fed4b',
            '173f6b', '1ed112', '465b50', 'fd8fa4', 'fb44d6', 'e8ed28', '4af7c0'
        },
        Yellow = {
            '7db764', '462f81', '3dce1c', '96e4dd', 'f5949f', 'a5c289',
            '73947c', '8d8f04', '68129e', '217d9b', '53edce', 'b0f3c1', 'c2ae00'
        },
        Blue = {
            'b5ad97', '00d6f0', '4c499b', '4c8fac', '428bf0', '727bf9',
            '9c866a', '737b97', 'e4f4a6', '5b61f4', 'a9957e', '716f2c', '85f58b'
        },
        Purple = {
            'dd2ded', 'a8a985', '9c4b0c', '64b697', '33a93a', '667627',
            'a01003', '88a32c', '2c9482', '4d4260', '34871c', 'fea48b', 'd382e6'
        },
        Green = {
            '8b8731', 'c79482', 'e4427a', '243526', '524465', '54b0f0',
            '8be4cc', '7bbda6', 'fefad9', 'e991c5', '0d2e0f', '640746', 'd7fe96'
        },
        Teal = {
            'd3cbf1', '0ff5c6', 'd10c8e', '4bec1d', '4a4a95', 'e24447',
            'cf439d', '130dd5', '704b4f', '0443ff', '5e5b05', 'f2289f', '3b4252'
        }
    },
    PlayerCubes = {
      Red = {'c3fad2', 'e3d8bd', '866851'},
      Orange = {'5e6458', 'cb0bf7', '583ef4'},
      Yellow = {'c0f66c','b2271a','19bd7d'},
      Blue = {'8a2f0c', '7e81ce', '70c25d'},
      Purple = {'204671', '9c1b52', 'e4c4f9'},
      Green = {'60da38', 'a7be6e', 'f1e307'},
      Teal = {'46faa7', '671fa8', '0c1379'}
    },
    DeploySections = {
        Red = {
            '1e91c0', '0a9a51', '7132c1', 'ce2d11', 'a60744', '9172b3',
            '052e97', '0ff00e', 'b9ad35', 'd12f6a', 'b668f0', 'd49bb4', 'a6e439'
        },
        Orange = {
            '4f84b3', '14f65b', '6ee3a4', 'a96c73', '40e87d', '0db2ae',
            'b68952', 'c8bf64', 'c1e65c', '2160f9', '741b75', 'f53898', '28c06d'
        },
        Yellow = {
            '3606da', 'f5bb44', '6afbe6', '74912e', 'a1c3be', '29a023',
            '1e1664', '1e17d8', '3f603e', 'bd8b7d', '63c219', 'db0d1b', '610a68'
        },
        Blue = {
            'c42ac6', '9271b3', 'c1cca0', 'ae787c', '42aa9b', '447f81',
            '469ac7', '60ead7', '343588', '7de7bf', 'cd5412', '175990', 'e0ac22'
        },
        Purple = {
            '671ba5', '69e7bd', '26c451', '9ddcc1', '7e1222', '91e5e6',
            'c433fe', '17894d', '93d12e', 'e37bb3', '4bf917', '4af6a4', 'c865bb'
        },
        Green = {
            '0c51dc', 'f1c60d', 'c3a004', 'e6f5cb', 'd82032', 'c4e8dd',
            'c8c991', '644a2f', '8c7e8e', '9fd723', 'ead3c7', '3d1adc', 'f8d748'
        },
        Teal = {
            '0a0cd8', '0c7fa9', '78e6a6', 'c65120', '3bfe34', 'a59662',
            'f46e79', '2ed802', 'b38166', '647645', '106c41', '5e27c9', '904f6b'
        }
    },
    Zones = {
        Discard = {
            Red = 'c08c97',
            Orange = '97166b',
            Yellow = '2bb649',
            Blue = '7da947',
            Purple = '82f36f',
            Green = 'd159d1',
            Teal = '7cd0b3'
        }
    },
    Deployments = {
        Tall = {'c08c9b', '5b4153', 'e2a4c6', 'c572af', 'b0e8f8', '1394ec', '07b1d1', '3e70aa', 'ed5be4', 'ef6e02', '949f67', 'f1e719'},
        Taller = {'11d1fc', 'f0d126', 'ce3512', 'd1d0ea', '66ac96', '1bc92b', '8fadea', '3a81fe', '65d15a', '233671', '26f271', '1aa4c6', 'eb14a4', 'd0a0ae', '3a3ad8', 'c17f91', 'e540c8', '5aa245', '5aa245', '52d0f8', 'e27613',
        -- 6/7 player start cards
        '65d15a', 'd1d0ea', '11d1fc', 'eb14a4', '3a81fe', '66ac96', '233671', '1aa4c6',
        '8fadea', '1bc92b', 'ce3512', 'd0a0ae', 'f0d126', '26f271'
        },
        Tall2 = {'36ddd9', '82370d', '71c3e0', 'a8cb0f', '4cde5d', 'f1df7e', '8669dd', 'd02079', '5c9d9b', '80ce3d', 'dbb1b2', '734b3c', 'dce6d9', 'c58ec7', '397d1b'}
    },
    Decks = {
        Sectors = {'0124ec', 'e5c908', '0ed9c0'}
    },
    AutoRollDisplay = {
        Red = '5acb43',
        Orange = '56e44d',
        Yellow = '2d7101',
        Green = '3a5253',
        Blue = '2c9227',
        Teal = 'cfed10',
        Purple = '59757b'
    },
    Bags = {
        Expansions = 'c295b6'
    },
    Expansions = {
        DreadnaughtDeck = 'fd5137',
        ShyPluto = {
            RedBag = '9c8343',
            PinkBag = 'd9970b',
            PilotBags = {
                Red = '70922d',
                Orange = '4e3b9a',
                Yellow = '5e8e30',
                Green = '29345b',
                Blue = '66d5fe',
                Teal = '9b1908',
                Purple = 'e03c21'
            },
            Sectors = {'fc7e02', '2a65b9', '32d0c5'}
        },
        Biodome = {
            Sectors = {'3a8b4d', '8fc6fd', 'd02425'},
            Colony = 'c6d40a'
        },
        Proxima = {
            Sectors = {'60f919', '9d5ed1', 'e34f48'},
            UpgradeDeck = 'fce0af',
            Colony = 'bb983f',
            OrangeDiceBag = '75b043',
            ShipDie = '7a3f02',
            PilotBag = '5c53c2',
            HelpText = '21ef47',
            Rulebook = 'd0f016'
        },
        JohnDClaire = {
            Sector3 = '572c1c',
            Title = '3343b4'
        },
        DeadReckoning = {
            Title = 'ccba7a',
            Sector1 = '3f3948'
        },
        Genesis = {
            Sectors = {'8d2d9f', 'ff6a84', '68c9e4'},
            Colony = '8969bf'
        }
    }
}

heightIncrement = -0.01
heightFirst = 1.17

Positions = {
    SectorXIncrements = {0, 1.42, 2.82, 4.21, 5.95, 7.35, 8.74, 10.14, 11.87, 13.27, 14.66, 16.07, 18.19},
    ResourceIncrements = {
        {
            -24.45,
            -24.03,-23.63,-23.23,-22.81,-22.44,-22.01,-21.61,-21.21,-20.82,-20.40,
            -20.00,-19.49,-19.10,-18.69,-18.29,-17.90,-17.49,-17.10,-16.70,-16.30,
            -15.90,-15.50,-15.11,-14.71,-14.31,-13.91,-13.42,-13.03,-12.65,-12.26,
            -11.89,-11.50,-11.11,-10.73,-10.35, -9.98, -9.59, -9.20, -8.83, -8.44
        },
        {
            8.55,
            8.98,  9.37, 9.77,10.19,10.58,10.98,11.39,11.79,12.18,12.18,
            13.00,13.49,13.90,14.31,14.71,15.10,15.51,15.90,16.30,16.70,
            17.10,17.50,17.89,18.29,18.69,19.09,19.58,19.97,20.35,20.74,
            21.11,21.50,21.89,22.25,22.65,23.02,23.41,23.80,24.17,24.56
        }
    },
    Cards = {
        Red = { up = -10.9, right = -24.74, orig = -11.03 },
        Orange = { up = 1.1, right = -24.74, orig = 0.97 },
        Yellow = { up = 13.12, right = -24.74, orig = 12.97 },
        Blue = { up = 1.1, right = 8.26, orig = 0.97 },
        Purple = { up = -10.9, right = 8.26, orig = -11.03 },
        Green = { up = 25.12, right = -24.74, orig = 24.97 },
        Teal = { up = 13.12, right = 8.26, orig = 12.97 }
    },
    -- Starter Card Positions
    Starters = {
        Red = {-22.42, 4, -16.78},
        Orange = {-22.42, 4, -5.22},
        Yellow = {-22.42, 4, 6.80},
        Green = {-22.42, 4, 18.80},
        Purple = {10.26, 4, -16.41},
        Blue = {10.26, 4, -5.22},
        Teal = {10.26, 4, 6.80}
    }
}
-- 0,
-- 0.42,  0.40,  0.40,  0.42,  0.37,  0.43,  0.40,  0.40,  0.39,  0.42,
-- 0.40,  0.51,  0.39,  0.41,  0.40,  0.39,  0.41,  0.39,  0.40,  0.40,
-- 0.40,  0.40,  0.39,  0.40,  0.40,  0.40,  0.49,  0.39,  0.38,  0.39,
-- 0.37,  0.39,  0.39,  0.38,  0.38,  0.37,  0.39,  0.39,  0.37,  0.39



selectedStartingPlayer = 'Red'

ShyPlutoDiceY = 1.25
ShyPlutoDiceX = {-1.68, -0.89, -0.10, 0.71, 1.48, 2.29}
ShyPlutoDiceZ = 19.61
ShyPlutoDiceZone = '3f8721'
ShyPlutoButton = '3c5547'
StartPlayerCard = 'ede71b'
ColonyCardsZone = 'ebc15a'