Darkness = {
    Track = {-13.80, -12.80, -11.80, -10.80, -9.80, -8.80, -7.80, -6.80, -5.80, -4.80,
        -3.79, -2.77, -1.77, -0.77, 0.22, 1.22, 2.22, 3.20, 4.19, 5.20,
        6.20, 7.20, 8.20, 9.20, 10.20, 11.20, 12.27, 13.27, 14.27, 15.27, 16.27},
    NegativeTrackZ = 2.15,

    increaseDarknessConsideringBlights = function()
        -- Move darkness for each Desecration Blight out
        local desecrations = Blights.count('Desecration')
        if desecrations > 0 then
            printToAll('Adding ' .. desecrations .. ' extra darkness from Desecration blight(s).', stringColorToRGB('Yellow'))
        end
        Darkness.Move.Darkness(desecrations + 1)
    end,

    Move = {
        Clues = function(amount)
            local clueLevel = Darkness.getTrackLevel('Clues')
            local pos = Darkness.getTrackPosition(clueLevel + amount)
            getClueToken().setPositionSmooth(pos)
            print('Moving clues to level ' .. clueLevel + amount .. '.')
        end,

        Darkness = function(amount)
            local darknessCardLevels = Darkness.getDarknessCardLevels()

            local darknessLevel = Darkness.getTrackLevel('Darkness')
            local nextLevel = darknessLevel + amount
            print('Moving darkness to level ' .. nextLevel .. '.')

            local darknessIndex = Darkness.getDarknessCardIndex(nextLevel, darknessCardLevels)
            if darknessIndex ~= false and Darkness.canDrawDarknessCard(darknessIndex) then
                print('Drawing a Darkness card for darkness level ' .. nextLevel ..'.')
                Darkness.drawCard(darknessIndex)
            end

            if nextLevel == 25 then
                print('All blights have +1 might.')
            elseif nextLevel == 31 then
                print("You've reached the end of the darkness track. Add a blight to the Monastery instead.")
                return
            end
            Darkness.Move.DarknessToken(nextLevel)
        end,

        DarknessToken = function(level)
            local token = getObjectsWithAllTags({'Darkness', 'Token'})[1];
            token.setPositionSmooth(Darkness.getTrackPosition(level))
        end,

        StartingDarkness = function()
            local startingDarknessDm = Settings.difficultyOptions[3]
            local darkness = 0
            -- Move starting darkness
            if startingDarknessDm == -1 then
                Darkness.Move.DarknessToken(-5)
                darkness = -5
            end
            if startingDarknessDm == 1 then
                Darkness.Move.DarknessToken(5)
                darkness = 5
            end
            Darkness.drawStartingDarknesses(darkness)
        end
    },

    getDarknessCardLevels = function()
        local darknessCardsDm = Settings.difficultyOptions[1]
        local darknessCardLevels = {};
        if darknessCardsDm == -1 then darknessCardLevels = {15} end
        if darknessCardsDm == 0 then darknessCardLevels = {10,20} end
        if darknessCardsDm == 1 then darknessCardLevels = {7,14,21} end
        if darknessCardsDm == 2 then darknessCardLevels = {5,10,15,20} end
        if darknessCardsDm == 3 then darknessCardLevels = {4,8,12,16,20} end
        if darknessCardsDm == 4 then darknessCardLevels = {2,6,10,14,18,22} end
        if darknessCardsDm == 5 then darknessCardLevels = {0,4,8,12,16,20,24} end
        if darknessCardsDm == 6 then darknessCardLevels = {0,3,6,9,12,15,18,21} end
        return darknessCardLevels
    end,

    drawStartingDarknesses = function(darkness)
        local darknessCardLevels = Darkness.getDarknessCardLevels()

        for index, value in ipairs(darknessCardLevels) do
            if value <= darkness then
                print('Drawing a Darkness card for darkness level ' .. value .. '.')
                Darkness.drawCard(index)
            end
        end
    end,

    getTrackPosition = function(level)
        local z = 3.08
        if level < 0 then
            level = level * -1
            z = Darkness.NegativeTrackZ
        end
        return {Darkness.Track[level+1], 1.6, z}
    end,

    getDarknessCardIndex = function(number, levels)
        for index, level in ipairs(levels) do
            if level == number then
                return index
            end
        end
        return false
    end,

    canDrawDarknessCard = function(n)
        local drawnCardsZone = getObjectsWithAllTags({'DrawnDarknessCards', 'Zone'})[1];
        local drawnCardCount = #(drawnCardsZone.getObjects())
        if n <= drawnCardCount then
            return false
        end
        return true
    end,

    drawCard = function(n)
        local zone = getObjectsWithAllTags({'Darkness', 'Zone'})[1];
        local deck = Utility.getDeckFromZone(zone)
        local position = deck.getPosition()
        local xPos = position[1] + 2.5 * n
        local card = deck.takeObject({ position = {xPos, 2, position[3]}, flip = true })
        card.addTag('DrawnDarknessCards')
    end,

    getTrackLevel = function(pType)
        local token = pType == 'Darkness' and getDarknessToken() or getClueToken()
        local xpos = math.floor(token.getPosition()[1])
        local darknessLevel = xpos + 14;
        if  math.floor(token.getPosition()[3]) == math.floor(Darkness.NegativeTrackZ)
            then darknessLevel = darknessLevel * -1
        end
        return darknessLevel
    end
}