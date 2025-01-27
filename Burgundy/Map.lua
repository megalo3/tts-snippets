function setDuchyButtons(obj)
    obj.setLock(true)
    local color = getTagColor(obj)
    local objectPosition = obj.getPosition()
    local x = objectPosition[1]
    local y = objectPosition[3]
    obj.UI.setXml([[<Text id="mapnumber" fontSize="16" rotation="0 0 180" position="0 180 -1" color="#DDDDDD">Map 1</Text>]])
    obj.createButton({
        click_function = "changeDuchyPositive",
        function_owner = self,
        label          = "+",
        position       = {.4, .1, 1.8},
        rotation       = {0, 0, 0},
        width          = 70,
        height         = 70,
        font_size      = 80,
        color          = {0.5, 0.5, 0.5},
        font_color     = {1, 1, 1},
    })
    obj.createButton({
        click_function = "changeDuchyNegative",
        function_owner = self,
        label          = "-",
        position       = {-0.4, .1, 1.8},
        rotation       = {0, 0, 0},
        width          = 70,
        height         = 70,
        font_size      = 80,
        color          = {0.5, 0.5, 0.5},
        font_color     = {1, 1, 1},
    })

    function changeDuchyPositive(obj) changeDuchy(obj, 'positive') end
    function changeDuchyNegative(obj) changeDuchy(obj, 'negative') end

    function changeDuchy(obj, direction)
        local settings = Global.getTable('settings')
        local color = getTagColor(obj)
        local value = settings.mapNumberIndex[color]

        if direction == 'negative' and value > 1 then
            settings.mapNumberIndex[color] = value - 1
        end
        if direction == 'positive' and value < #settings.availableBoards then
            settings.mapNumberIndex[color] = value + 1
        end
        Global.setTable('settings', settings)
        setMap(settings.mapNumberIndex[color], color, obj)
    end

    return color
end

function getAvailableMapNumbers()
    local boards = Global.getTable('settings').availableBoards
end

function spawnNumberTiles(obj)
    local color = getTagColor(obj)
    local mapCheck = getObjectsWithAllTags({color, 'map-slot-11'})
    if #mapCheck > 0 then return false end

    local objectPosition = obj.getPosition()
    local x = objectPosition[1]
    local y = objectPosition[3]

    startX = x - 6.2
    startY = y + 4.5
    if isReverse(color) then
        startY = y - 4.5
        startX = x + 6.2
    end
    hStep = 1.76
    vStep = 1.53

    sampleToken = getObjectFromGUID(Global.getTable('Guids').AllHexesToken)

    local map = MapColors[1]

    for b = 1,#map do
        for a = 1, #map[b] do
            local xSkipStep = {2,1,1,0,1,1,2}

            local x = startX + (hStep * (a-1+xSkipStep[b])) + (((b+1)%2) * hStep/2)
            local y = startY - vStep * (b-1)
            if isReverse(color) then
                x = startX - (hStep * (a-1+xSkipStep[b])) - (((b+1)%2) * hStep/2)
                y = startY + vStep * (b-1)
            end
            local tokenTypeColor = map[b][a]
            local tokenTypeNumber = MapNumbers[b][a]
            local tokenType = tokenTypeColor .. tokenTypeNumber

            local cloned = sampleToken.clone({position = {x,0,y}})

            if isReverse(color) then
                cloned.setRotation({0.00, 330.00, 0.00})
            else
                cloned.setRotation({0.00, 150.00, 0.00})
            end

            if MapStates[tokenType] ~= 1 then
                cloned = cloned.setState(MapStates[tokenType])
            end
            cloned.setLock(true)
            cloned.addTag('Map')

            cloned.addTag('map-slot-' .. b .. a)
            cloned.addTag(color)
        end
    end
end

function despawnNumberTiles()
    for key, object in ipairs(getObjectsWithTag('Map')) do
        object.destruct()
    end
end

-- value, color, obj
function setMap(value, color, obj)
    local mapNumber = Global.getTable('settings').availableBoards[value]
    local map = MapColors[tonumber(mapNumber)]

    for b = 1,#map do
        for a = 1,#map[b] do
            local mapTileTag = 'map-slot-' .. b .. a
            local tokenTypeColor = map[b][a]
            local tokenTypeNumber = MapNumbers[b][a]
            local tokenType = tokenTypeColor .. tokenTypeNumber
            local mapTile = getObjectsWithAllTags({mapTileTag, color})[1]
            local stateId = MapStates[tokenType]
            if mapTile.getStateId() ~= stateId then
                mapTile = mapTile.setState(stateId)
                mapTile.addTag(mapTileTag)
                mapTile.addTag(color)
            end
        end
    end

    obj.UI.setValue('mapnumber', 'Map ' .. mapNumber)
end

function setBoardPosition(x, y, color)
    local board = getObjectsWithAllTags({color, 'playerboard'})[1]

    if isReverse(color) then
        board.setPosition({x, 0.97, y-6.8})
        board.setRotation({0,0,0})
    else
        board.setRotation({0,180,0})
        board.setPosition({x, 0.97, y+6.8})
    end
    board.setLock(true)
end

function isReverse(color)
    -- return color == 'Purple' or color == 'Yellow'
    return false
end

function setColor(obj, color)
    local colors = {
        Blue = "rgb(0.52,0.76,0.94)",
        Yellow = "rgb(1,0.89,0.16)",
        Purple = "rgb(0.57,0.47,0.73)",
        Red = "rgb(0.96,0.5,0.35)",
    }
    obj.UI.setAttribute("title", "color", colors[color])
end

function getTagColor(obj)
    local color = ''
    if obj.hasTag('Blue') then color = 'Blue' end
    if obj.hasTag('Yellow') then color = 'Yellow' end
    if obj.hasTag('Purple') then color = 'Purple' end
    if obj.hasTag('Red') then color = 'Red' end
    return color
end