WorkshopID = '2961940791'

function getClueToken()
    return getObjectsWithAllTags({'Search', 'Token'})[1]
end
function getDarknessToken()
    return getObjectsWithAllTags({'Darkness', 'Token'})[1]
end
function getTimeBag()
    return getObjectsWithAllTags({'Bag', 'Time'})[1]
end
function getProgressBag()
    return getObjectsWithAllTags({'Bag', 'Progress'})[1]
end
function getItemBag()
    return getObjectsWithAllTags({'Item', 'Bag'})[1]
end
function getBlightBoard()
    return getObjectFromGUID('2f4bb6')
end

Settings = {
    difficultyOptions = {0,0,0,0,0,0,0,0},
    heroTurnPanelClosedBy = {"Nobody"},
    actionsPanelClosedBy = {"Nobody"},
    difficultyPanelClosedBy = {"Nobody"},
    mapSelected = false,
    mapType = 'Everything',
    pawns = {},
    started = false
}

PlayerBoard = nil
SelectedMapDeck = 'Green';
DeckMapNames = {
    Green = 'Simplicity',
    Yellow = 'Hunted',
    Orange = 'Overrun',
    Red = 'Entropy',
    Purple = 'Spiritual Warfare',
    Blue = 'Classic',
    Everything = 'Everything'
}
MapDecks = {'Green', 'Yellow', 'Orange', 'Red', 'Purple', 'Blue', 'Everything'}
Colors = {'Red', 'Orange', 'Green', 'Blue', 'Purple'}
MonestaryPositions = {
    Red = {-12.3, 1.25, 13.50},
    Orange = {-10, 1.25, 13.50},
    Green = {-12.3, 1.25, 11.25},
    Blue = {-10, 1.25, 11.25},
    Purple = {-7.7, 1.25, 12.38}
}
Players = {
    PlayedY = 1.1,
    PlayedZ = {-12.20, -15.55},
    Red = {-29.25, -26.78, -24.34, -21.86},
    Orange = {-15.92, -13.45, -11.01, -8.53},
    Green = {-2.57, -0.10, 2.34, 4.87},
    Blue = {10.44, 12.91, 15.35, 17.83},
    Purple = {23.22, 25.69, 28.13, 30.63},
}