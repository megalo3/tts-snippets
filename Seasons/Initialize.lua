function onLoad(saveState)
    local loadedData = JSON.decode(saveState)
    if loadedData ~= nil then
        settings = loadedData
    end

    math.randomseed(os.time())
    -- Set items uninteractable
    for key, object in ipairs(getObjectsWithTag('noninteractable')) do
        object.interactable = false
    end

    if settings.setupComplete == false then
        setupMenu('true')

        yellowPrint('Hidden zone opacity can be changed in Menu -> Configuration -> Interface -> Misc. Settings -> Hidden Zone Hide Opacity.')
        print('Players may choose a specific Enchantment card and place it in the Enchantment card slot. If not, an Enchantment card will be randomly selected.')
    else
        gatherItemsMenu('true')
    end
end

function onSave()
    return JSON.encode(settings)
end

function onPlayerTurn(player, previous_player)
    if settings.setupComplete == false then return end
    if settings.playerTurn == player.color and settings.changingTurns == false then
        local next = Turns.getNextTurnColor()
        settings.changingTurns = true
        settings.playerTurn = next
        Turns.turn_color = next
        moveFirstPlayerToken()
        local totalRounds = advanceTime()
        if totalRounds <= 36 then
            print('First player moves to the next player.')
        else
            scorePadMenu('true')
        end
    else
        settings.changingTurns = false
    end
end

function setupMenu(value)
    UI.setAttribute('optionsMenu1', 'active', value)
    UI.setAttribute('optionsMenu2', 'active', value)
    UI.setAttribute('optionsMenu3', 'active', value)
end

function updateStartingPlayerMenu()
    local nonSeated = {table.unpack(getSeatedPlayerColors())}
    local name = 'StartingPlayer-'
    if has_value(nonSeated, 'White') then
        name = name .. 'w'
        settings.playerTurn = 'White'
    end
    if has_value(nonSeated, 'Pink') then
        name = name .. 'p'
        if settings.playerTurn == '' then settings.playerTurn = 'Pink' end
    end
    if has_value(nonSeated, 'Orange') then
        name = name .. 'o'
        if settings.playerTurn == '' then settings.playerTurn = 'Orange' end
    end
    if has_value(nonSeated, 'Yellow') then name = name .. 'y' end
    UI.setAttribute(name, 'active', 'true')
end

function startingPlayerMenu(value)
    if value == 'true' then updateStartingPlayerMenu() end
    UI.setAttribute('startPlayerMenu', 'active', value)
    UI.setAttribute('startPlayerMenuButtons', 'active', value)
end

function gatherItemsMenu(value)
    UI.setAttribute('gatherItemsMenu', 'active', 'true')
end

function scorePadMenu(value)
    setAllTotals()
    UI.setAttribute('ScorepadMenu', 'active', 'true')
end

function uiToggle(player, value, id)
    if id == 'beginner' or id == 'intermediate' or id == 'advanced' then
        if value == 'True' then
            settings.difficulty = id
        end
    else
        if value == 'True' then
            settings[id] = true
        else
            settings[id] = false
        end
    end
end

function setup()
    setupMenu('false')

    if settings.enchantmentCards == true then
        dealEnchantmentCard()
    else
        removeEnchantment()
    end

    if settings.enchantmentCard ~= "Olaf's Knowledge" then
        for _, object in ipairs(getObjectsWithAllTags({'olafs knowledge'})) do
            destroyObject(object)
        end
    end

    if settings.enchantmentCard ~= 'Force of Destiny' and settings.enchantmentCard ~= 'Divine Destiny' then
        hideDestiny()
    end

    if settings.enchantmentCard == 'Vision of Destiny' then
        DrawPilePos[1] = DrawPilePos[1] - 3
        DiscardPilePos[1] = DiscardPilePos[1] - 3
        local drawDeckZone = getObjectFromGUID(Guids.Zones.DrawDeck)
        local drawDeckPos = drawDeckZone.getPosition()
        drawDeckZone.setPosition({drawDeckPos[1] - 3, drawDeckPos[2], drawDeckPos[3]})
        yellowPrint('Vision of Destiny Enchantment')
        yellowPrint('The top two Power cards in the draw pile are systematically revealed and placed in a row next to the draw. The card farthest from the draw is considered to be the top card in the draw, and the other face-up card is deemed the second card in the draw.')
    end

    local baseDeck = getObjectsWithAllTags({'Deck', 'base'})[1]

    if settings.difficulty == 'intermediate' or settings.difficulty == 'beginner' then
        for index, card in ipairs(baseDeck.getObjects()) do
            local info = Cards[card.name]
            if info.Number < 31 then
                Wait.frames(function()
                    baseDeck.takeObject({
                        guid = card.guid,
                        position = DrawPilePos
                    })
                end, index*3)
            end
        end
    end
    local waitTime = 3
    if settings.difficulty == 'advanced' then
        baseDeck.setPositionSmooth(DrawPilePos)
        waitTime = 1.3
    end

    Wait.time(function()
        local deck = getDrawDeck()
        if settings.pathOfDestiny == true then
            local pathOfDestiny = getObjectsWithAllTags({'Deck', 'path of destiny'})[1]
            deck.putObject(pathOfDestiny)
        end
        if settings.enchantedKingdom == true then
            deck.putObject(getObjectsWithAllTags({'Deck', 'enchanted kingdom'})[1])
        end
        if settings.promos == true then
            deck.putObject(getObjectsWithAllTags({'promo'})[1])
        end
        Wait.time(function()
            deck.shuffle()

            if settings.enchantmentCard == 'Vision of Destiny' then
                visionOfDestinyShift()
            end

            getObjectFromGUID(Guids.Text.Phase).setValue('Prelude')
            yellowPrint('The Prelude phase has begun.')
            if settings.specialAbilityTokens == true then
                dealSpecialAbilityTokens()
            end
            dealStartingHand()
        end, 1.7)
    end, waitTime)
end

function visionOfDestinyShift()
    local deck = getDrawDeck()

    local topCardText = getObjectFromGUID(Guids.Text.TopCard)
    local topCardTextPos = topCardText.getPosition()
    topCardText.setPositionSmooth({topCardTextPos[1], 1, topCardTextPos[3]})

    local secondDrawText = getObjectFromGUID(Guids.Text.SecondDraw)
    local secondDrawTextPos = secondDrawText.getPosition()
    secondDrawText.setPositionSmooth({secondDrawTextPos[1], 1, secondDrawTextPos[3]})

    local drawText = getObjectFromGUID(Guids.Text.Draw)
    local drawTextPos = drawText.getPosition()
    drawText.setPositionSmooth({drawTextPos[1]-3, drawTextPos[2], drawTextPos[3]})

    local discardText = getObjectFromGUID(Guids.Text.Discard)
    local discardTextPos = discardText.getPosition()
    discardText.setPositionSmooth({discardTextPos[1]+3, discardTextPos[2], discardTextPos[3]})

    deck.takeObject({
        flip = true,
        position = DiscardPilePos
    })
    deck.takeObject({
        flip = true,
        position = {DiscardPilePos[1]+3, DiscardPilePos[2], DiscardPilePos[3]}
    })
    resetTableGrid()
end

function setLibraryCards()
    getDrawDeck().setName('Draw Deck')
    local deckSize = 3
    if settings.enchantmentCard == 'Extended Experience' then
        deckSize = 4
    end
    print('Players must put ' .. deckSize .. ' cards under library II and ' .. deckSize .. ' cards under library III.')
    if settings.specialAbilityTokens == true then
        printToAll('Players must select their special ability token if they have not yet.', stringColorToRGB('Pink'))
    end

    startingPlayerMenu('true')
end

function startTournament()
    removeUnseatedPlayers()

    settings.changingTurns = true
    -- Turns.enable = true
    Turns.turn_color = settings.playerTurn
    -- Turns.type = 2 (custom)
    -- Turns.order = 'White', 'Orange', 'Pink', 'Yellow'

    removeTwistOfFate()
    setCardEffects()

    getObjectFromGUID(Guids.Text.Phase).setValue('Tournament')

    startingPlayerMenu('false')

    gatherItemsMenu('true')
    local playerCount = #Player.getPlayers()
    local diceRemovalCount = 4 - playerCount
    local elements = {'air', 'earth', 'fire', 'water'}

    for index, element in ipairs(elements) do
        for x=1, diceRemovalCount do
            Wait.time(function()
                removeRandomDie(element)
            end, (x - 1) * 1.5)
        end
    end
    -- sort dice
    Wait.time(function()
        returnDice({'water', 'earth', 'fire', 'air'})
    end, (diceRemovalCount - 1) * 2)
    settings.setupComplete = true
    yellowPrint('The Tournament has begun.')

    moveFirstPlayerToken()
end

function removeUnseatedPlayers()
    local DestroyText = {
        White = {'ea859b', '6c48c5', 'ba874d', '488258'},
        Pink = {'516b1f', '23ec5f', 'fdd082', '89fde0'},
        Orange = {'6170a1', 'fb6f4f', '709559', 'beeb1d'},
        Yellow = {'ef8ba4', '90d2d7', 'ae099f', '7cacdd'}
    }
    local nonSeated = getNonSeatedPlayerColors()
    for _, color in ipairs(nonSeated) do
        for _, object in ipairs(getObjectsWithTag(color)) do
            destroyObject(object)
        end
        for x=1,4 do
            destroyObject(getObjectFromGUID(DestroyText[color][x]))
        end
    end
end

function removeTwistOfFate()
 -- Remove Twist of Fate on game start
    local deck = getDrawDeck();
    for _, card in ipairs(getDrawDeck().getObjects()) do
        if card.name == 'Twist of Fate' then
            getObjectFromGUID(Guids.Bags.UnusedItems).putObject(
                deck.takeObject({guid = card.guid})
            )
        end
    end
end

function removeRandomDie(element)
    local dice = getObjectsWithAllTags({'Die', element})
    local random = rand(#dice)
    getObjectFromGUID(Guids.Bags.UnusedItems).putObject(dice[random])
end

function moveFirstPlayerToken()
    local token = getObjectsWithAllTags({'first player token'})[1]
    token.setPositionSmooth(Players[settings.playerTurn].FirstPlayer)
    token.setRotationSmooth(Players[settings.playerTurn].SpecialR)
end

function startingPlayerSelected(player, value, id)
    local colorOrder = {
        White = 'Pink',
        Pink = 'Orange',
        Orange = 'Yellow',
        Yellow = 'White'
    }
    local nonSeated = getNonSeatedPlayerColors()
    for x=1,3 do
        if has_value(nonSeated, value) == true then
            value = colorOrder[value]
        end
    end
    settings.playerTurn = value
end

function getDrawDeck()
    return getDeckFromZone(getObjectFromGUID(Guids.Zones.DrawDeck))
end

TokenBags = {
    air = 'a0c85d',
    fire = 'ecfadc',
    water = 'd2a187',
    earth = 'f61095',
}
TokenBags['decrease energy'] = '9a6508'

function spawnitem(player, b, id)
    if id == 'air' or id == 'earth' or id == 'water' or id == 'fire' then
        spawnElement(player, id)
    elseif id == 'crystal' then
        changeCrystals({ Increment = 1, Color = player.color })
    elseif id == 'summongauge' then
        moveSummonGauge('positive', player)
    end
end

function spawnitem5(player, b, id)
    if id == 'crystal' then
        changeCrystals({ Increment = 5, Color = player.color })
    end
end

function despawnitem(player, b, id)
    if id == 'air' or id == 'earth' or id == 'water' or id == 'fire' then
        despawnElement(player, id)
    elseif id == 'crystal' then
        changeCrystals({ Increment = -1, Color = player.color })
    elseif id == 'summongauge' then
        moveSummonGauge('negative', player)
    end
end

function transmuteitem(player, b, id)
    function purseOfIoCount(color)
        local zone = getObjectsWithTag('tableau', color)[1]
        local count = 0
        for _, card in ipairs(zone.getObjects()) do
            if card.type == 'Card' and card.getName() == 'Purse of Io' then
                count = count + 1
            end
        end
        return count
    end

    local round = getRound()
    local season = getSeason(round)
    local transmuteValues = {
        Winter = {
            air = 1,
            earth = 3,
            water = 1,
            fire = 2
        },
        Spring = {
            air = 2,
            earth = 1,
            water = 1,
            fire = 3
        },
        Summer = {
            air = 3,
            earth = 1,
            water = 2,
            fire = 1
        },
        Fall = {
            air = 1,
            earth = 2,
            water = 3,
            fire = 1
        },
    }

    -- Natural Balance enchantment makes all energy tokens transmute to 2 crystals
    local transmuteCount = transmuteValues[season][id]
    if settings.enchantmentCard == 'Natural Balance' then
        transmuteCount = 2
    end

    local hasElement = despawnElement(player, id, true)
    if hasElement ~= false then
        local purseOfIoCount = purseOfIoCount(player.color)
        local transmuteCount = transmuteCount + purseOfIoCount

        -- Io's Bounty gives a +1 bonus to transmutation
        if settings.enchantmentCard == "Io's Bounty" then
            transmuteCount = transmuteCount + 1
        end
        changeCrystals({ Increment = transmuteCount, Color = player.color, TransmuteCount = transmuteCount, PurseofIoCount = purseOfIoCount, TransmuteElement = id })
    end
end

-- { increment, color, transmuteElement, purseOfIoCount, skipMessage }
-- { Increment = 4, Color = player.color, SkipMessage = true }
function changeCrystals(input)
    local crystals = getObjectsWithAllTags({input.Color, 'crystals'})[1]
    local newValue = crystals.getValue() + input.Increment
    if newValue < 0 then
        yellowPrint('Crystal count can not go below 0.')
        return
    end
    local incdec = 'gained'
    if input.Increment < 0 then incdec = 'removed' end
    local message = input.Color .. " player has " .. incdec .. " " .. math.abs(input.Increment) .. " crystals to a total of " .. newValue .. " crystals."
    if input.TransmuteElement ~= nil then
        local purseOfIoMessage = ''
        if input.PurseOfIoCount ~= nil and input.PurseOfIoCount > 0 then
            purseOfIoMessage = ' (' .. input.PurseOfIoCount .. 'x Purse of Io bonus)'
        end
        message = input.Color .. " player has transmuted " .. input.TransmuteElement .. " into " .. input.Increment .. " crystals" .. purseOfIoMessage .. " to a total of " .. newValue .. " crystals."
    end
    if input.SkipMessage == nil then
        printToAll(message, stringColorToRGB(input.Color))
    end

    crystals.setValue(newValue)
end

function moveSummonGauge(direction, player)
    function sortBlockX(a,b)
        if player.color == 'Orange' or player.color == 'Yellow' then
            return a[1] > b[1]
        end
        return a[1] < b[1]
    end
    function roundPosition(position)
        return {
            round(position[1], 2),
            round(position[2]+.3, 2),
            round(position[3], 2)
        }
    end

    local board = getObjectsWithAllTags({player.color, 'player board'})[1]
    local block = getObjectsWithAllTags({player.color, 'summon gauge'})[1]
    local blockPosition = roundPosition(block.getPosition())
    local gaugeIndex = 0
    local points = {}
    for _, point in ipairs(board.getSnapPoints()) do
        if has_value(point.tags, 'summon gauge') then
            local position = board.positionToWorld(point.position)
            local roundedPosition = roundPosition(position)
            table.insert(points, roundedPosition)
        end
    end
    table.sort(points, sortBlockX)

    for index, point in ipairs(points) do
        if (point[1] == blockPosition[1]) then
            gaugeIndex = index
        end
    end

    if gaugeIndex == 0 then return end
    if direction == 'positive' then
        if gaugeIndex > 15 then
            yellowPrint('You increase your summoning gauge past 15.')
            return;
        end
        printToAll(player.color .. " player increased their summoning gauge to " .. gaugeIndex .. '.', stringColorToRGB(player.color))
        block.setPositionSmooth(points[gaugeIndex + 1], false, true)
    elseif direction == 'negative' then
        if gaugeIndex <= 1 then
            yellowPrint('You cannot reduce your summoning gauge below 0.')
            return;
        end
        printToAll(player.color .. " player decreased their summoning gauge to " .. gaugeIndex -2 .. '.', stringColorToRGB(player.color))
        block.setPositionSmooth(points[gaugeIndex - 1], false, true)
    end
end

function spawnElement(player, element)
    local remainingSpace = getRemainingTokenSpace(player.color)
    if remainingSpace == 0 then
        yellowPrint(player.color .. ' has no space left for energy.')
        return
    end

    moveTokensLeft(player.color)

    local totalSlots = getTokenSlotCount(player.color)
    local snapPositionIndex = totalSlots - remainingSpace + 1

    local positions = getPointPositions(player.color)

    local bag = getObjectFromGUID(TokenBags[element])
    bag.takeObject({
        position = positions[snapPositionIndex],
        rotation = Players[player.color].SpecialR,
        smooth = false
    })
    printToAll(player.color .. ' player gained ' .. element .. ' energy.', stringColorToRGB(player.color))
end

function despawnElement(player, element, skipMessage)
    for _, token in ipairs(getTokens(player.color)) do
        local tag = token.getTags()[1]
        if tag == element then
            destroyObject(token)
            if skipMessage ~= true then
                printToAll(player.color .. ' player spent ' .. element .. ' energy.', stringColorToRGB(player.color))
            end
            Wait.frames(function()
                moveTokensLeft(player.color)
            end, 10)
            return
        end
    end
    yellowPrint(player.color .. ' has no ' .. element .. ' energy to spend.')
    return false
end

function getPointPositions(color)
    local points = {}
    for _, point in ipairs(Global.getSnapPoints()) do
        if has_value(point.tags, color) == true then
            table.insert(points, point.position)
        end
    end

    local grimoire = nil
    for _, token in ipairs(getTokens(color)) do
        local tag = token.getTags()[1]
        if tag == 'grimoire' then grimoire = token end
    end

    if grimoire ~= nil then
        for _, point in ipairs(grimoire.getSnapPoints()) do
            table.insert(points, grimoire.positionToWorld(point.position))
        end
    end

    return points
end

function getTokens(color)
    local zone = getObjectFromGUID(Guids.Zones.Token[color])
    return zone.getObjects()
end

-- {color, element}
function playerHasElement(input)
    for _, token in ipairs(getTokens(input[1])) do
        if token.hasTag(input[2]) then
            return true
        end
    end
    return false
end

function playerHasAllElements(color)
    local earth = 0
    local air = 0
    local water = 0
    local fire = 0

    for _, token in ipairs(getTokens(color)) do
        if token.hasTag('earth') then
            earth = 1
        elseif token.hasTag('air') then
            air = 1
        elseif token.hasTag('water') then
            water = 1
        elseif token.hasTag('fire') then
            fire = 1
        end
    end
    return (earth + air + fire + water) == 4
end

function getTokenCount(color)
    local count = {
        air = 0,
        fire = 0,
        water = 0,
        earth = 0,
        grimoire = 0
    }
    count['decrease energy'] = 0
    for _, token in ipairs(getTokens(color)) do
        local tag = token.getTags()[1]
        if token.type ~= 'Dice' then
            count[tag] = count[tag] + 1
        end
    end
    return count
end

function getRemainingTokenSpace(color)
    local count = getTokenCount(color)
    local total = count.air + count.fire + count.water + count.earth + count['decrease energy']
    local max = 7
    if count.grimoire > 0 then max = 10 end
    return max - total
end

function hasGrimoire(color)
    return getTokenCount(color).grimoire > 0
end

function getTokenSlotCount(color)
    local count = 7
    if hasGrimoire(color) == true then
        count = 10
    end
    return count
end

function moveTokensLeft(color)
    local slot = 1
    local positions = getPointPositions(color)
    for _, token in ipairs(getTokens(color)) do
        local tag = token.getTags()[1]
        if tag ~= 'grimoire' and token.type ~= 'Dice' then
            token.setPositionSmooth(positions[slot])
            slot = slot + 1
        end
    end
end

function round(number, places)
    local mult = 10^(places or 0)
    return math.floor(number * mult + 0.5) / mult
end

function scoreChange(player, value, id)
    scoreChange({ id = id, value = value })
end

function yellowPrint(message)
    printToAll(message, stringColorToRGB('Yellow'))
end