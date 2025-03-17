function onLoad(saveState)
    SetupBag = getObjectFromGUID(Guids.Bags.setup)
    BlackBag = getObjectFromGUID(Guids.Bags.blackmarket)
    BuildingBag = getObjectFromGUID(Guids.Bags.building)
    ShieldBag = getObjectFromGUID(Guids.Bags.shield)
    TradeRouteBag = getObjectFromGUID(Guids.Bags.traderoute)
    WorkerBag = getObjectFromGUID(Guids.Bags.worker)

    setPlayerBoardDuchyButtons()

    local loadedData = JSON.decode(saveState)
    if loadedData ~= nil then
        settings = loadedData
    end

    math.randomseed(os.time())
    -- Set items uninteractable
    for key, object in ipairs(getObjectsWithTag('noninteractable')) do
        object.interactable = false
    end

    if settings.setupComplete == true then
        setupMenu('false')
        setAdvanceButtons()
    end

    for key, object in ipairs(getObjectsWithTag('vineyardhex')) do
        if object.guid ~= Guids.Zones.vineyard then
            createVineyardFlipButton(object)
        end
    end
end

function onSave()
    return JSON.encode(settings)
end

function onPlayerTurn(player, previous_player)
end

function onObjectLeaveContainer(container, leave_object)
    if container.guid == Guids.Bags.vineyard then
        createVineyardFlipButton(leave_object)
    end

    local description = Descriptions[leave_object.getName()]
    if description == nil then return end
    leave_object.setDescription(description)
end

function onScriptingButtonDown(number, playerColor)
    local activePlayer
    for _, player in ipairs(Player.getPlayers()) do
        if player.color == playerColor then activePlayer = player end
    end
    if activePlayer == nil then return end

    local p = activePlayer.getPointerPosition()

    local pos = {p[1], 2, p[3]}
    if number == 1 then
        local bag = getObjectFromGUID(Guids.Bags.worker)
        if bag == nil then return end
        bag.takeObject({position = pos, rotation = {0, 180, 0}})
    end

    if number == 2 then
        local bag = getObjectFromGUID(Guids.Bags.coin)
        if bag == nil then return end
        bag.takeObject({position = pos, rotation = {0, 180, 0}})
    end
end
