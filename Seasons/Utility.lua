-- color, slot
function getTableauPosition(input)
    local x = input.slot%5
    if x == 0 then x = 5 end
    local z = math.ceil(input.slot/5)

    return {Global.getTable('Players')[input.color].TableauX[x], 2, Global.getTable('Players')[input.color].TableauZ[z]}
end

function rand(number)
    return math.ceil(math.random() * number)
end

function getSeatedPlayerColors()

    local playerColors = {}
    for _, player in ipairs(Player.getPlayers()) do
        table.insert(playerColors, player.color)
    end
    local ordered = {}
    for _, color in ipairs(PlayerOrder) do
        if has_value(playerColors, color) == true then
            table.insert(ordered, color)
        end
    end
    return ordered
end

function getNonSeatedPlayerColors()
    local allColors = {'White', 'Pink', 'Orange', 'Yellow'}
    local seatedColors = getSeatedPlayerColors()
    local nonSeatedColors = {}
    for _, color in ipairs(allColors) do
        if has_value(seatedColors, color) == false then
            table.insert(nonSeatedColors, color)
        end
    end
    return nonSeatedColors
end

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function getDeckFromZone(zone)
    if (zone == nil) then return end
    for _, object in ipairs(zone.getObjects(true)) do
        if (object.type == 'Deck') then
            return object
        end
    end
    return nil
end

function getCardFromZone(zone)
    if (zone == nil) then return end
    for _, object in ipairs(zone.getObjects(true)) do
        if (object.type == 'Card') then
            return object
        end
    end
    return nil
end

function shuffleArray(array)
    local output = { }
    local random = math.random

    for index = 1, #array do
        local offset = index - 1
        local value = array[index]
        local randomIndex = offset*random()
        local flooredIndex = randomIndex - randomIndex%1

        if flooredIndex == offset then
            output[#output + 1] = value
        else
            output[#output + 1] = output[flooredIndex + 1]
            output[flooredIndex + 1] = value
        end
    end

    return output
end

function getRound()
    local pos = getRoundMarker().getPosition()
    local x = round(pos[1],2)
    local z = round(pos[3],2)
    for index, marker in ipairs(Positions.RoundMarkers) do
        if marker[1] == x and marker[2] == z then
            return index
        end
    end
end

function getSeason(round)
    local seasons = { 'Winter', 'Winter', 'Winter', 'Spring', 'Spring', 'Spring', 'Summer', 'Summer', 'Summer', 'Fall', 'Fall', 'Fall' }
    return seasons[round]
end

function getYear()
    local pos = getYearMarker().getPosition()
    local x = round(pos[1],2)
    local z = round(pos[3],2)
    for index, marker in ipairs(Positions.YearMarkers) do
        if marker[1] == x and marker[2] == z then
            return index
        end
    end
end

function moveRound(number)
    local p = Positions.RoundMarkers[number]
    getRoundMarker().setPositionSmooth({p[1], 1.20, p[2]}, false, true)
end
function moveYear(number)
    if number > 4 then number = 4 end
    local p = Positions.YearMarkers[number]
    getYearMarker().setPositionSmooth({p[1], 1.20, p[2]}, false, true)
end

function getRoundMarker()
    return getObjectsWithAllTags({'round marker'})[1]
end
function getYearMarker()
    return getObjectsWithAllTags({'year marker'})[1]
end

-- Lua doesn't have a round function!
function round(number, places)
    local mult = 10^(places or 0)
    return math.floor(number * mult + 0.5) / mult
end



-- {coords, point}
function isPointWithinCoords(input)
    local area1 = getPolygonArea(input[1])
    local area2 = getPointWithPolygonArea(input[1], input[2])
    return area1 == area2
end

function getPolygonArea(coords)
    local area = 0
    for i = 0,#coords - 2 do
        local point2 = coords[i+1]
        local point3 = coords[i+2]
        local newArea = getTriangleArea(coords[1], point2, point3)
        area = area + newArea
    end
    return round(area, 2)
end

function getPointWithPolygonArea(coords, point)
    local area = 0
    for i = 0,#coords - 1 do
        local point2 = coords[i+1]
        local point3Index = i+2
        if point3Index > #coords then point3Index = 1 end
        local point3 = coords[point3Index]
        local newArea = getTriangleArea(point, point2, point3)
        area = area + newArea
    end
    return round(area, 2)
end

function getTriangleArea(one, two, three)
    local x1 = one[1]
    local y1 = one[2]
    local x2 = two[1]
    local y2 = two[2]
    local x3 = three[1]
    local y3 = three[2]
    return .5*(math.abs(
        x1*(y2-y3) + x2*(y3-y1) + x3*(y1-y2)
    ))
end

function greenPrint(message)
    printToAll(message, stringColorToRGB('Green'))
end

function yellowPrint(message)
    printToAll(message, stringColorToRGB('Yellow'))
end