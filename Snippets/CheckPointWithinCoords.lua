-- Coordinates are {X, Z}
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

function round(number, places)
    local mult = 10^(places or 0)
    return math.floor(number * mult + 0.5) / mult
end