function onScriptingButtonDown(index, playerColor)
    if playerColor == "Grey" then return end
    local activePlayer
    for _, player in ipairs(Player.getPlayers()) do
        if player.color == playerColor then activePlayer = player end
    end

    local p = activePlayer.getPointerPosition()
    local pos = {p[1], 2, p[3]}
    if index == 1 then
        local bag = getObjectsWithAllTags({playerColor, 'charge'})[1]
        if bag == nil then return end
        local p = activePlayer.getPointerPosition()
        bag.takeObject({position = pos})
    end

    if index == 2 then
        local bag = getObjectsWithAllTags({playerColor, 'ship'})[1]
        if bag == nil then return end
        bag.takeObject({position = pos})
    end
end