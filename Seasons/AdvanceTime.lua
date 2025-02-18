function advanceTime()
    local objects = getObjectFromGUID(Guids.Zones.AdvanceTime).getObjects()
    if #objects == 0 then
        print('Could not automatically advance the round because no dice was placed in the unused dice spot.')
        return
    end
    local advanceTimeCount = objects[1].getRotationValue()
    return advanceTimeByAmount({AdvanceTimeCount= advanceTimeCount, MarkEndOfRound = true})
end

-- {AdvanceTimeCount, MarkEndOfRound}
function advanceTimeByAmount(input)
    local round = getRound()
    -- round will be nil if the user spam changes the round
    if round == nil then return end
    local newRound = round + input.AdvanceTimeCount

    local message = 'Starting a new round in '
    local year = getYear()
    if newRound > 12 then
        year = advanceYear(1)
        message = message .. 'year ' .. year .. ', '
        newRound = newRound - 12
    end
    if newRound < 1 then
        year = advanceYear(-1)
        message = message .. 'year ' .. year .. ', '
        newRound = 12
    end

    local season = getSeason(round)
    local newSeason = getSeason(newRound)
    local seasonChanged = false
    if season ~= newSeason then
        seasonChanged = true
        greenPrint('The season changed to ' .. newSeason .. '.')
        highlightEffects(season)
        if newSeason == 'Summer' then
            droughtEnchantment()
        end
    end

    message = message .. 'month ' .. newRound .. '.'
    moveRound(newRound)
    if input.MarkEndOfRound == true then
        endOfTheRound()
        greenPrint(message)
    end

    return (year - 1) * 12 + newRound
end

function advanceYear(amount)
    local year = getYear()
    local changedYear = year + amount
    if changedYear < 1 then return end

    if settings.enchantmentCard == "Arus's Cunning Schemes" then
        yellowPrint("Arus's Cunning Schemes Enchantment")
        yellowPrint("The year has changed. Each player must simultaneously pass a Power card from their hand to the player on their left. A player with no Power cards in their hand does not pass a card to the player on their left but may receive one. This rule is also applied at the end of the game.")
    end

    if settings.enchantmentCard == "Into the Void" then
        yellowPrint("Into the Void")
        local crystalRequirement = 0
        if year + amount == 2 then
            crystalRequirement = 15
        elseif year + amount == 3 then
            crystalRequirement = 30
        elseif year + amount == 4 then
            crystalRequirement = 50
        end
        yellowPrint("Each player must sacrifice a Power card. However, Into the Void does not affect any players who have at least " .. crystalRequirement .. " crystals. Note: Effects that cause the same year to change more than once do not cause Into the Void to trigger additional times.")
    end

    moveYear(changedYear)
    dealLibraryCards(changedYear)
    return changedYear
end

function endOfTheRound()
    highlightEffects(round)
    untapCards()
    seasonsTurnEnchantment()
    tailwindEnchantment()
end

function dealLibraryCards(year)
    local romanYear = 'ii'
    if year == 3 then romanYear = 'iii' end
    local cardsWereDealt = false

    for _, player in ipairs(Player.getPlayers()) do
        local zone = getObjectsWithAllTags({'base', romanYear, player.color })[1]
        for _, object in ipairs(zone.getObjects()) do
            if object.type == 'Deck' then
                object.deal(4, player.color)
                cardsWereDealt = true
            end
        end
    end
    if cardsWereDealt == true then
        print('Dealing year ' .. year .. ' cards from player libraries.')
    end
end

function untapCards()
    local playerData = Global.getTable('Players')
    local cards = {}
    for _, player in ipairs(Player.getPlayers()) do
        for _, zone in ipairs(getObjectsWithTag('tableau', player.color)) do
            for _, card in ipairs(zone.getObjects()) do
                card.setRotationSmooth(playerData[player.color].SpecialR)
            end
        end
    end
    return cards
end

function seasonsTurnEnchantment()
    if settings.enchantmentCard == "Seasons' Turn" then
        yellowPrint("Season' Turn Enchantment")
        yellowPrint("At the end of the round, if a player's energy reserve contains all four types of energy, the player receives 4 crystals.")
        for _, player in ipairs(Player.getPlayers()) do
            if playerHasAllElements(player.color) then
                changeCrystals({ Increment = 4, Color = player.color, SkipMessage = true })
                print(player.color .. ' player receives 4 crystals.')
            end
        end
    end
end

function tailwindEnchantment()
    if settings.enchantmentCard == "Tailwind" then
        yellowPrint("Tailwind Enchantment")
        yellowPrint("At the end of the round, each player may discard an air energy from their reserve and receive 4 crystals. This effect may only be applyed once at the end of each round.")
    end
end

function droughtEnchantment()
    if settings.enchantmentCard == "Drought" then
        yellowPrint("Drought Enchantment")

        local topColor = ''
        local topAmount = 0
        local isMatch = false

        for _, player in ipairs(Player.getPlayers()) do
            local amount = getObjectsWithAllTags({player.color, 'crystals'})[1].getValue()
            if amount > topAmount then
                topAmount = amount
                topColor = player.color
                isMatch = false
            elseif amount == topAmount then
                isMatch = true
            end
        end

        if isMatch == true then
            yellowPrint('Two or more players have the same number of crystals. The Drought effect does not apply.')
        else
            yellowPrint(topColor .. " player has the most crystals and must either sacrifice one of their Power cards or decrease their energy reserve by one.")
        end
    end
end