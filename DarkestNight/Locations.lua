function countBlightsInLocation(location)
    local zone = getObjectsWithAllTags({'Zone', 'Board', 'Blight'})[1]
    local bag = getObjectsWithAllTags({'Bag', 'Time'})[1]
    local blights = zone.getObjects()
    local blightCount = 0
    local locationArea = LocationAreas[location]
    for _, blight in ipairs(blights) do
        if blight.type == 'Tile' then
            local position = blight.getPosition()
            local blightArea = getPointWithPolygonArea(location, {position[1], position[3]})
            if LocationAreas[location] == blightArea then
                local newBlightCount = getTileStackCount(blight)
                -- Voids count as 2 blights
                if blight.getName() == 'Void' then newBlightCount = newBlightCount * 2 end
                blightCount = blightCount + newBlightCount
            end
        end
    end
    return blightCount
end

function getTileStackCount(tileStack)
    if (tileStack.name == 'Custom_Tile_Stack') then
        return tileStack.getQuantity()
    else
        return 1
    end
end

function findPawnLocation(pawn)
    local locationName = nil
    local position = pawn.getPosition()
    for _, location in ipairs(Locations) do
        local pawnArea = getPointWithPolygonArea(location, {position[1], position[3]})
        if LocationAreas[location] == pawnArea then
            return location
        end
    end
end

function getPolygonArea(location)
    local coords = LocationVertices[location]
    local area = 0
    for i = 0,#coords - 2 do
        local point2 = coords[i+1]
        local point3 = coords[i+2]
        local newArea = getTriangleArea(coords[1], point2, point3)
        area = area + newArea
    end
    return round(area, 2)
end

function getPointWithPolygonArea(location, point)
    local coords = LocationVertices[location]
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

-- Lua doesn't have a round function!
function round(number, places)
    local mult = 10^(places or 0)
    return math.floor(number * mult + 0.5) / mult
end
