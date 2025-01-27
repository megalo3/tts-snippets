function startNextPhase()
    if settings.setupComplete == false or settings.phase == 'E' then return end
    increasePhase()
    resupplyVineyards()
    removeGameBoardHexes()
    updatePlayerTurnOrder()
    Wait.time(function() supplyGameBoardHexes() end, 0.5)
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