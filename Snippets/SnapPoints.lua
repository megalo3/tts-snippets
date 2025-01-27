
    setGlobalSnapPoints()

    for _, board in ipairs({getObjectFromGUID('cacdee'),getObjectFromGUID('368cc9'),getObjectFromGUID('616984'),getObjectFromGUID('a893fa')}) do
        local points = {}
        for _, point in ipairs(board.getSnapPoints()) do
            point.tags = {'summon gauge'}
            table.insert(points, point)
        end
        board.setSnapPoints(points)
    end
    
    function setGlobalSnapPoints()
    local allPoints = {}
    local coords = {
        {3.45, -12.37},
        {3.45, 13.84},
        {20.45, 13.84},
        {20.45, -12.37}
    }
    local coords2 = {
        {-28.20, -12.37},
        {-28.20, 13.84},
        {-10.37, 13.84},
        {-10.37, -12.37}
    }

    for _, point in ipairs(Global.getSnapPoints()) do
        if Utility.call('isPointWithinCoords', {coords, {point.position[1], point.position[3]}}) or
            Utility.call('isPointWithinCoords', {coords2, {point.position[1], point.position[3]}})
        then
            point.tags = {'base', 'promo', 'path of destiny', 'enchanted kingdom'}
            table.insert(allPoints, point)
        else
            table.insert(allPoints, point)
        end
    end
    Global.setSnapPoints(allPoints)
end