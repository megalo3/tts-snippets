function setTradeRoutes()
    if settings.components.traderoutes == true then
        local routeBoard = SetupBag.takeObject({guid = Guids.Boards['traderoute' .. settings.playercount]})

        for _, color in ipairs(Global.call('getSeatedPlayerColors')) do
            local board = getObjectsWithAllTags({color, 'playerboard'})[1]
            local pos = board.getPosition()
            local rotation = {0,180,0}
            local cloned = routeBoard.clone()
            cloned.setPosition({pos[1], 0.97, pos[3] + 10})
            cloned.setRotation(rotation)
            cloned.addTag(color)
            cloned.addTag('traderouteboard')
            cloned.setLock(true)
            local rotationY = 180
            local snaps = cloned.getSnapPoints()
            for _, snap in ipairs(snaps) do
                local pos = cloned.positionToWorld(snap.position)
                local route = TradeRouteBag.takeObject({position = pos})
                route.setRotation({0,rotationY,0})
            end
        end
        SetupBag.putObject(routeBoard)
    else
        SetupBag.putObject(getObjectFromGUID(Guids.Bags.traderoute))
    end
end