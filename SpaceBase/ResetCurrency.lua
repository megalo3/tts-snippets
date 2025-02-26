function resetCredits(button, color)
    if (isPlayerColor(color)) then
        settings.Points[color].Credits = settings.Points[color].Income
        printToAll(color .. ' player reset their credits to ' .. settings.Points[color].Credits, stringColorToRGB(color))
        moveTrack('Credits', color)
    else
        print('You must first select a player color to reset your credits.')
    end
end