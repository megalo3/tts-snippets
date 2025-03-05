

Locations = {'Mountains', 'Castle', 'Village', 'Swamp', 'Forest', 'Ruins', 'Monastery'}
-- Locations = {'Mountains', 'Monastery', 'Forest', 'Castle', 'Village', 'Swamp', 'Ruins'}
LocationPositions = {
    Mountains = {-6.16, 2, 19.53},
    Castle = {8.46, 2, 18.52},
    Village = {1.30, 2, 12.55},
    Swamp = {12.35, 2, 12.55},
    Forest = {-7.25, 2, 5.35},
    Ruins = {10.68, 2, 5.96},
    Monastery = {-12.84, 2, 12.65}
}
LocationPosition = {
    Mountains = {-7.91, 2, 19.40},
    Castle = {10.48, 2, 18.57},
    Village = {-0.79, 2, 12.62},
    Swamp = {9, 2, 12.59},
    Forest = {-1.68, 2, 6.24},
    Ruins = {8.57, 2, 6.18}
}
LocationVertices = {
    Monastery = {
        {-14.45, 18.19},
        {-4.98,15.13},
        {-4.98, 9.92},
        {-14.46, 6.97}
    },
    Mountains = {
        {-14.50, 21.83},
        {1.27, 21.91},
        {1.28, 17.29},
        {-4.98,15.13},
        {-14.45, 18.19}
    },
    Castle = {
        {1.27, 21.91},
        {17.00, 21.96},
        {16.96, 18.30},
        {7.31, 15.11},
        {1.28, 17.29}
    },
    Village = {
        {-4.98,15.13},
        {1.28, 17.29},
        {7.31, 15.11},
        {7.27, 10.03},
        {1.29, 7.75},
        {-4.98, 9.92}
    },
    Swamp = {
        {7.31, 15.11},
        {16.96, 18.30},
        {17.04, 6.85},
        {7.27, 10.03}
    },
    Forest = {
        {-14.46, 6.97},
        {-4.98, 9.92},
        {1.29, 7.75},
        {1.24, 3.52},
        {-14.53, 3.52}
    },
    Ruins = {
        {1.29, 7.75},
        {7.27, 10.03},
        {17.04, 6.85},
        {17.04, 3.51},
        {1.24, 3.52}
    }
}

-- Either he's already in the location or he goes through the village
LocationPathfinding = {
    Mountains = {
        Castle = { 'Castle' },
        Swamp = { 'Village', 'Castle' }
    },
    Castle = {
        Mountains = { 'Mountains' },
        Ruins = { 'Village', 'Swamp' },
        Swamp = { 'Swamp' }
    },
    Swamp = {
        Castle = { 'Castle' },
        Ruins = { 'Ruins' },
        Mountains = { 'Village', 'Castle' }
    },
    Forest = {
        Swamp = { 'Village', 'Ruins' },
        Ruins = { 'Ruins' }
    },
    Ruins = {
        Forest = { 'Forest' },
        Castle = { 'Village', 'Swamp' },
        Swamp = { 'Swamp' }
    }
}
-- Only locations that are 1 away. Everything else is 2
LocationProximity = {
    Mountains = { 'Village', 'Castle' },
    Castle = { 'Mountains', 'Village', 'Swamp' },
    Swamp = { 'Castle', 'Village', 'Ruins' },
    Forest = { 'Village', 'Ruins' },
    Ruins = { 'Forest', 'Village', 'Swamp' },
    Village = { 'Mountains', 'Castle', 'Swamp', 'Forest', 'Ruins' }
}

LocationDirection = {
    Mountains = {
        'Castle',
        'Village',
        'Mountains',
        'Village',
        'Castle',
        'Mountains'
    },
    Castle = {
        'Swamp',
        'Village',
        'Mountains',
        'Castle',
        'Village',
        'Castle'
    },
    Village = {
        'Mountains',
        'Ruins',
        'Forest',
        'Castle',
        'Swamp',
        'Village'
    },
    Swamp = {
        'Ruins',
        'Village',
        'Castle',
        'Swamp',
        'Village',
        'Swamp'
    },
    Forest = {
        'Village',
        'Ruins',
        'Forest',
        'Village',
        'Ruins',
        'Forest'
    },
    Ruins = {
        'Forest',
        'Swamp',
        'Village',
        'Ruins',
        'Village',
        'Ruins'
    }
}