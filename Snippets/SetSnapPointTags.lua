function SetSnapPointTags(board)
    local points = {}
    for _, point in ipairs(board.getSnapPoints()) do
        point.tags = {'summon gauge'}
        table.insert(points, point)
    end
    board.setSnapPoints(points)
end