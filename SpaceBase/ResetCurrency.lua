function resetCurrency(button, color)
    if (isPlayerColor(color)) then
        local moneyCube = getObjectFromGUID(Guids.PlayerCubes[color][1])
        local incomeCube = getObjectFromGUID(Guids.PlayerCubes[color][2])
        local moneyPos = moneyCube.getPosition()
        local incomePos = incomeCube.getPosition()
        moneyCube.setPositionSmooth({incomePos[1], moneyPos[2], moneyPos[3]})
    else
        print('You must first select a player color to reset your currency.')
    end
end