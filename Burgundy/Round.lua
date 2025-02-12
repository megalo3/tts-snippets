function startNextPhase()
    if settings.setupComplete == false or settings.phase == 'E' then return end

    -- If there are undeployed trade goods, do not proceed
    local zone = getObjectFromGUID(Guids.Zones.tradegoods)
    if #(zone.getObjects()) > 0 then
        redPrint('There are still trade goods that have not been deployed. Unable to start the next phase.')
        return
    end
    local message = 'Gain coins for placed mines.'
    if settings.components.shields == true then
        message = 'Pay 1 coin per placed shield. If you cannot afford to pay for your placed shields, remove shields until you can afford them. Then you may gain coins from placed mines.'
    end
    yellowPrint(message)
    increasePhase()
    resupplyVineyards()
    removeGameBoardHexes()
    updatePlayerTurnOrder()
    Wait.time(function() supplyGameBoardHexes() end, 1)
end

function increasePhase()
    local match = ''
    for index, phase in ipairs(Phases) do
        if phase == settings.phase then
            match = Phases[index + 1]
        end
    end
    settings.phase = match
    deployTradeGoods('tgslot' .. match)

    getObjectFromGUID(Guids.Text.phase).setValue('Phase ' .. match)
end