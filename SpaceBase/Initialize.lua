gameLoaded = false

function onLoad(saveState)
    UI.hide('FirstPlayerPanel')
    math.randomseed(os.time())
    Hands.enable = false

    local loadedData = JSON.decode(saveState)
    if loadedData ~= nil then
        settings = loadedData
    end

    -- Set items uninteractable
    for key, value in ipairs({
            -- Auto Roll Zone Dotted Displays
            Guids.AutoRollDisplay['Red'], Guids.AutoRollDisplay['Orange'], Guids.AutoRollDisplay['Yellow'], Guids.AutoRollDisplay['Green'], Guids.AutoRollDisplay['Blue'], Guids.AutoRollDisplay['Teal'], Guids.AutoRollDisplay['Purple'],
            -- Player Boards
            'e58bea', '93553d', '2eaddb', 'fc21ad', 'a917cc', '0b40bb', '707903',
            -- Table
            '12c65e', 'f938a2', 'afc863', '9f95fd', 'c8edca', '35b95f', '393bf7', '5af8f2', '4ee1f2',
            -- Shy Pluto Card
            'aa6cc3',
            -- Floor and stools
            'b1cad7', '5f9ba8', '28c93d',
            -- Help table
            '71a899'
        }) do
        if (getObjectFromGUID(value) != nil) then
            -- getObjectFromGUID(value).interactable = false
        end
    end

    for c=1,7 do
        for k=1,13 do
            local playerBoardSector = getObjectFromGUID(Guids.PlayerBoards[Colors[c]][k]);
            if (playerBoardSector != nil) then
                playerBoardSector.createButton({
                    click_function = Colors[c] .. "Deploy" .. k,
                    function_owner = Global,
                    label          = "Deploy",
                    position       = {0.05,-0.15,1.25},
                    rotation       = {0,180,0},
                    width          = 300,
                    height         = 200,
                    font_size      = 70,
                    color          = {0, 0, 0},
                    font_color     = {1, 1, 1},
                    tooltip        = 'Deploy ' .. k
                })
            end
        end
    end

    sectorDeckOnLoad()

    for _, color in ipairs(Colors) do
        createMoveCubeButtons(color)
    end

    if (settings.started == true) then
        UI.hide('optionsMenu1')
        UI.hide('optionsMenu2')
        UI.hide('optionsMenu3')
    end

    gameLoaded = true
end

function onSave()
    return JSON.encode(settings)
end

highlightedCard1 = nil
function onObjectNumberTyped(object, player_color, number)
    if object.type ~= 'Card' then return end
    local isHighlighted = object.getVar('highlight')
    if isHighlighted == nil or isHighlighted == false then
        object.highlightOn(stringColorToRGB('Yellow'))
        object.setVar('highlight', true)
        if highlightedCard1 == nil then
            highlightedCard1 = object.guid
        else
            swapCards(highlightedCard1, object.guid)
            highlightedCard1 = nil
        end
    else
        object.highlightOff(stringColorToRGB('Yellow'))
        object.setVar('highlight', false)
        highlightedCard1 = nil
    end
end

function swapCards(guid1, guid2)
    local card1 = getObjectFromGUID(guid1)
    local card2 = getObjectFromGUID(guid2)
    card1.highlightOff(stringColorToRGB('Yellow'))
    card2.highlightOff(stringColorToRGB('Yellow'))
    card1.setVar('highlight', false)
    card2.setVar('highlight', false)
    card1pos = card1.getPosition()
    card1rot = card1.getRotation()
    card1lock = card1.locked
    card2pos = card2.getPosition()
    card2rot = card2.getRotation()
    card2lock = card2.locked
    card1.setPositionSmooth(card2pos)
    card1.setRotationSmooth(card2rot)
    card1.setLock(card2lock)
    card2.setPositionSmooth(card1pos)
    card2.setRotationSmooth(card1rot)
    card2.setLock(card1lock)
end

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

function start()
    local hasColors = hasPlayerSelectedColors()
    if (not hasColors) then
        print('At least one player must select a color before starting the game.')
        return
    end
    UI.hide('optionsMenu1')
    UI.hide('optionsMenu2')
    UI.hide('optionsMenu3')
    settings.started = true

    -- If a 6 or 7 player game, give each player a sector 7 and 8 McCaffery Monitor-Relay Class Craft
    addSixSevenPlayerMods()

    addSelectedExpansions()

    -- Give the starter card "Started" tag to know on load if this is loading a saved game
    settings.started = true

    -- Shuffle the sector decks
    shuffleSectorDecks()
    print('Resupplying marketplace.')
    Turns.enable = true

    -- Deal starting cards (and pilot tokens if playing Shy Pluto) for active players
    dealStartingCards()

    -- If world eater, pull out 6 World Eater red dice
    if (settings.worldEater == true) then
        local diceBag = getObjectFromGUID(Guids.Expansions.ShyPluto.RedBag)
        diceBag.takeObject({guid = '2a7a43', position = {8.17, 1.23, 25.87}, rotation = {270, 180, 0}})
        diceBag.takeObject({guid = '5f0e18', position = {8.94, 1.23, 25.87}, rotation = {270, 180, 0}})
        diceBag.takeObject({guid = 'e7c672', position = {9.71, 1.23, 25.87}, rotation = {270, 180, 0}})
        diceBag.takeObject({guid = '8244a0', position = {10.48, 1.23, 25.87}, rotation = {270, 180, 0}})
        diceBag.takeObject({guid = '90e112', position = {11.25, 1.23, 25.87}, rotation = {270, 180, 0}})
        diceBag.takeObject({guid = '3de589', position = {12.02, 1.23, 25.87}, rotation = {270, 180, 0}})
    end

    print('Giving out starter cards.')
    gameStarted = true

    if (settings.lightSpeed == true) then
        UI.setAttribute('FirstPlayerPanelText', 'fontSize', 16)
        UI.setAttributes('FirstPlayerPanelText', {
        text = 'Each player may spend money to buy as many cards as they can afford. Any unspent money is kept. Set the player with the highest remaining money as the starting player. Ties are broken with the highest sector card. If still tied, roll dice.'
    })
    end

    -- Show set starting player
    UI.show('FirstPlayerPanel')
    hideStarterOptionsForNonPlayers()
end

function addSixSevenPlayerMods()
    if (#Player.getPlayers() > 5) then
        commandStation = getExpansion('commandStation');
        deck7 = commandStation.takeObject{guid = '9fdea6', position = {10.72, 3.08, 40.00}, rotation = {0,180,0}}
        deck8 = commandStation.takeObject{guid = '19207a', position = {12.61, 3.08, 40.00}, rotation = {0,180,0}}
        for _, player in ipairs(Player.getPlayers()) do
            local card7 = deck7.takeObject()
            local card8 = deck8.takeObject()
            deployCard({
                card = card7,
                xpos = 6,
                ypos = 0,
                upSum = getDeployHeight(card7.guid),
                color = player.color,
                flip = true,
                shouldMoveCharges = false
            })
            deployCard({
                card = card8,
                xpos = 7,
                ypos = 0,
                upSum = getDeployHeight(card8.guid),
                color = player.color,
                flip = true,
                shouldMoveCharges = false
            })
        end
        getObjectFromGUID(Guids.Bags.Expansions).putObject(commandStation)
    end
end

function dealStartingCards()
    for key, color in ipairs(getTurnOrderFromStartingPlayer(Turns.turn_color)) do
        dealCard(Positions.Starters[color], 1, 1)
        if (settings.lightSpeed == true) then
            -- Give out more cards
            dealCard(Positions.Starters[color], 1, 2)
            dealCard(Positions.Starters[color], 1, 3)
            dealCard(Positions.Starters[color], 1, 4)
            dealCard(Positions.Starters[color], 2, 5)
            dealCard(Positions.Starters[color], 2, 6)

            -- Update to 15 credits. The lightspeed / Terra Proxima income will add later
            settings.Points[color].Credits = 15
            moveTrack('Credits', color)
        end
        -- Give out pilot tokens
        -- If playing world eater, give out 2 pilot tokens
        if (settings.shyPluto == true or settings.terraProxima == true or settings.worldEater == true) then

            local PilotBag = getPilotBag(color)
            if (PilotBag != nil) then
                PilotBag.takeObject({
                    position = {x=Positions.Starters[color][1]+10, y=Positions.Starters[color][2], z=Positions.Starters[color][3]},
                    rotation = {0,180,0},
                    smooth = true
                })

                if (settings.worldEater == true) then
                    PilotBag.takeObject({
                        position = {x=Positions.Starters[color][1]+11, y=Positions.Starters[color][2], z=Positions.Starters[color][3]},
                        rotation = {0,180,0},
                        smooth = true
                    })

                end
            end
        end
    end
end

function hideStarterOptionsForNonPlayers()
    UI.hide('StarterOptionRed')
    UI.hide('StarterOptionOrange')
    UI.hide('StarterOptionYellow')
    UI.hide('StarterOptionGreen')
    UI.hide('StarterOptionTeal')
    UI.hide('StarterOptionBlue')
    UI.hide('StarterOptionPurple')

    local seatedPlayerColors = getSeatedPlayers()
    local nonSeatedColors = {}
    for _, color in ipairs(Colors) do
        local hasMatch = false
        for _, seatedColor in ipairs(seatedPlayerColors) do
            if seatedColor == color then hasMatch = true end
        end
        if hasMatch == false then
            -- Clear items for non-seated colors
            for _, object in ipairs(getObjectsWithTag(color)) do
                destroyObject(object)
            end
            for _, guid in ipairs(Guids.PlayerBoards[color]) do
                local obj = getObjectFromGUID(guid)
                checkDestruct(obj)
            end
        end
    end

    for _, color in ipairs(seatedPlayerColors) do
        if (isPlayerColor(color)) then
            UI.show('StarterOption' .. color)
        end
    end
end

function dealCard(positionObj, sector, iteration)
    iteration = iteration - 1
    local pos = {x=positionObj[1]+(1.5 * iteration), y=positionObj[2], z=positionObj[3]}
    getObjectFromGUID(Guids.Decks.Sectors[sector]).takeObject({
        position = pos,
        rotation = {0,180,0}
    })
end

function CameraViewClicked(player, value, id)
    player.lookAt(CameraStates[id])
end


-- Swap all cards in a sector with those from another sector
function swapSectorCards()
    -- The sectors that the two checkers are on will determine which to swap
    local checkers = getObjectsWithTag('checker')
    local locOne = getSectorLocation(checkers[1])
    local locTwo = getSectorLocation(checkers[2])
    if (locTwo[2] == 0 or locOne[2] == 0) then
        print("Both checkers must be on a sector to swap sectors.")
        return
    end
    if (locOne[1] != locTwo[1]) then
        print("You can't swap sectors from different player boards.")
        return
    end
    print('Swapping ', locOne[1], ' sectors ', locOne[2], ' and ', locTwo[2], '.')

    -- Return the checkers to the original location
    checkers[1].setPositionSmooth({-0.46, 1.12, -14.32}, false, false)
    checkers[2].setPositionSmooth({0.89, 1.12, -14.32}, false, false)

    local Sector1 = getObjectFromGUID(Guids.PlayerBoards[locOne[1]][locOne[2]])
    local Sector2 = getObjectFromGUID(Guids.PlayerBoards[locOne[1]][locTwo[2]])
    local Deploy1 = getObjectFromGUID(Guids.DeploySections[locOne[1]][locOne[2]])
    local Deploy2 = getObjectFromGUID(Guids.DeploySections[locOne[1]][locTwo[2]])
    local Position1 = Sector1.getPosition()
    local Position2 = Sector2.getPosition()
    local DeployPosition1 = Deploy1.getPosition()
    local DeployPosition2 = Deploy2.getPosition()
    moveHorizontal(Sector1, Position2[1])
    moveHorizontal(Sector2, Position1[1])
    moveHorizontal(Deploy1, Position2[1])
    moveHorizontal(Deploy2, Position1[1])
end

function moveHorizontal(zone, xPosition)
    local objects = zone.getObjects()
    for _, object in ipairs(objects) do
        local type = object.type
        if object.type == "Card" or object.type == "Deck" then
            local position = object.getPosition()
            object.setPositionSmooth({xPosition, position[2], position[3]})
        end
    end
end

function getSectorLocation(obj)
    local position = obj.getPosition()
    local right = round({number = position[1], places = 1})
    local rightIndex = 0
    -- There are 24 (26 with proxima) x-positions the sectors can be in
    local totalSectorPositions = 12
    if (settings.terraProxima == true) then totalSectorPositions = 13 end
    for k=1,(totalSectorPositions * 2) do
        if (k < (totalSectorPositions + 1)) then
            if (tostring(right) == tostring(round({number = Positions.Cards.Green.right + Positions.SectorXIncrements[k], places = 1}))) then
                rightIndex = k
            end
        else
            if (tostring(right) == tostring(round({number = Positions.Cards.Purple.right + Positions.SectorXIncrements[k-totalSectorPositions], places = 1}))) then
                rightIndex = k
            end
        end
    end

    -- Determine the yPosition
    local upIndex = (round({number = position[3], places = 0}) + 23) / 12

    local color = ''
    if (rightIndex < (totalSectorPositions + 1)) then
        if (upIndex == 1) then color = 'Red' end
        if (upIndex == 2) then color = 'Orange' end
        if (upIndex == 3) then color = 'Yellow' end
        if (upIndex == 4) then color = 'Green' end
    end
    if (rightIndex > totalSectorPositions) then
        if (upIndex == 1) then color = 'Purple' end
        if (upIndex == 2) then color = 'Blue' end
        if (upIndex == 3) then color = 'Teal' end
    end

    if (rightIndex > totalSectorPositions) then rightIndex = rightIndex - totalSectorPositions end
    return {color, rightIndex}
end

-- Toggles expansions on/off
function uiToggle(player, value, id)
    if value == 'True' then
        settings[id] = true
    else
        settings[id] = false
    end
end

function startingOptionSelected(player, option, id)
    selectedStartingPlayer = Colors[option + 1]
end

function SetStartingPlayer()
    -- Player order table
    local turnOrder = getTurnOrderFromStartingPlayer(selectedStartingPlayer)
    setStartingResources(turnOrder)
    returnUnpurchasedCards()

    -- Move starting player card to starting player
    getObjectFromGUID(StartPlayerCard).setPositionSmooth({
        Positions.Starters[selectedStartingPlayer][1],
        Positions.Starters[selectedStartingPlayer][2],
        Positions.Starters[selectedStartingPlayer][3]
    })

    Turns.turn_color = turnOrder[1]
    UI.hide('FirstPlayerPanel')
end

function setStartingResources(turnOrder)
    for index, color in ipairs(turnOrder) do

        -- CREDITS
        local startingCredits = 0
        if (index == 2) then
            startingCredits = startingCredits + 1
        end
        if (index == 3) then
            startingCredits = startingCredits + 2
        end

        -- INCOME
        local startingIncome = 0
        if (settings.terraProxima == true or settings.lightSpeed == true) then
            startingIncome = startingIncome + 1
        end
        if (index > 3) then
            startingIncome = startingIncome + 1
        end

        local playerOrder = 'First'
        if index == 2 then playerOrder = 'Second' end
        if index == 3 then playerOrder = 'Third' end
        if index == 4 then playerOrder = 'Fourth' end
        if index == 5 then playerOrder = 'Fifth' end
        if index == 6 then playerOrder = 'Sixth' end
        if index == 7 then playerOrder = 'Seventh' end

        local messages = {playerOrder .. ' player gains '}
        if startingCredits == 0 and startingIncome == 0 then
            table.insert(messages, ' no starting resources')
        end

        if startingCredits > 0 then
            settings.Points[color].Credits = startingCredits
            moveTrack('Credits', color)
            table.insert(messages, startingCredits .. ' credit')
            if startingCredits > 1 then table.insert(messages, 's') end
        end
        if startingCredits > 0 and startingIncome > 0 then
            table.insert(messages, ' and ')
        end
        if startingIncome > 0 then
            settings.Points[color].Income = startingIncome
            moveTrack('Income', color)
            table.insert(messages, startingIncome .. ' income')
        end
        table.insert(messages, '.')

        message = table.concat(messages)
        printToAll(message, stringColorToRGB(color))
    end
end

function returnUnpurchasedCards()
    local sector1 = getObjectFromGUID(Guids.Decks.Sectors[1])
    local sector2 = getObjectFromGUID(Guids.Decks.Sectors[2])

    for key, color in ipairs(getSeatedPlayers()) do
        if (isPlayerColor(color)) then
            local zone = getObjectFromGUID(Guids.Zones.Discard[color])
            local objects = zone.getObjects()
            for index, object in ipairs(objects) do
                local type = object.type
                if (string.find(type, 'Deck') or string.find(type, 'Card')) then
                    if (object.hasTag('sector 1')) then
                        sector1.putObject(object)
                    end
                    if (object.hasTag('sector 2')) then
                        sector2.putObject(object)
                    end
                end
            end
        end
    end
end

-- Deploy or undeploy a card from clicking the deploy button
function deployRouting(sector, xpos, deployGuid, color, altClick)
    if (altClick == false) then
        deploy({
            sector = sector,
            sectorNumber = xpos,
            deployGuid = deployGuid,
            color = color
        })
    else undeploy(sector, xpos, deployGuid, color)
    end
end

-- Takes the card on the station, flips it upside down, and tucks it under the board
-- and under the topmost deployed card of that sector
-- input = { sector, sectorNumber, deployGuid, color }
function deploy(input)
    input.sectorNumber = input.sectorNumber - 1
    local cards = {}

    -- Get the currently deployed cards
    local deployedZone = getObjectFromGUID(input.deployGuid)
    for index, card in ipairs(deployedZone.getObjects()) do
        local type = card.tag
        if (string.find(type, 'Deck') or string.find(type, 'Card')) then
            table.insert(cards, card)
        end
    end

    -- Reposition all deployed cards, which will fix any misalignment if a card was
    -- manually removed
    local deployedCount = 0
    upSum = 0
    flip = true
    if (input.sectorNumber == 12) then
        upSum = 0.22
        flip = false
    end
    -- Loop through deployed cards in y-position order and deploy them
    for index, card in spairs(cards, function(t,a,b) return t[b].getPosition()[3] > t[a].getPosition()[3] end) do
        upSum = upSum + getDeployHeight(card.guid)
        deployCard({
            card = card,
            xpos = input.sectorNumber,
            ypos = index-1,
            upSum = upSum,
            color = input.color,
            flip = flip,
            shouldMoveCharges = false
        })
        deployedCount = deployedCount + 1
    end
    -- Deploy the card in the station
    local foundCard = find_pile(input.sector)

    if (foundCard != nil) then
        -- Don't deploy the upgrade boards even though they are technically cards
        upSum = upSum + getDeployHeight(foundCard.guid)
        deployCard({
            card = foundCard,
            xpos = input.sectorNumber,
            ypos = deployedCount,
            upSum = upSum,
            color = input.color,
            flip = flip,
            shouldMoveCharges = true
        })
    end
end

function getDeployHeight(guid)
    if has_value({table = Guids.Deployments.Tall, value = guid}) then return 0.71 end
    if has_value({table = Guids.Deployments.Taller, value = guid}) then return 1.17 end
    if has_value({table = Guids.Deployments.Tall2, value = guid}) then return 0.89 end
    return 0.55
end

-- Move the topmost deployed card back to the station
function undeploy(sector, xpos, deployGuid, color)
    local topPosition = nil
    local topCard = nil

    local deployed = getObjectFromGUID(deployGuid)
    for index, card in ipairs(deployed.getObjects()) do
        local type = card.tag
        if (string.find(type, 'Deck') or string.find(type, 'Card')) then
            if (topPosition == nil) then
                topCard = card
                topPosition = topCard.getPosition()[3]
            end
            if (card.getPosition()[3] > topCard.getPosition()[3]) then
                topCard = card
            end
        end
    end

    if (topCard == nil) then return end
    topCard.setLock(false)
    local topCardPosition = topCard.getPosition()
    topCard.setPositionSmooth({topCardPosition[1], 1.23, Positions.Cards[color].orig}, false, true)
    topCard.setRotationSmooth({0,180,0}, false, true)
end

-- Move the station card to the topmost deployed spot
function deployCard(parameters)
    -- parameters: card, xpos, ypos, upSum, color, flip, shouldMoveCharges
    local charges
    if (parameters.shouldMoveCharges == true) then
        charges = getCharges(parameters.card)
    end

    if (parameters.flip == true) then
        parameters.card.setRotationSmooth({0,360,0}, false, true)
    end
    parameters.card.setLock(true)

    local right = Positions.Cards[parameters.color].right + Positions.SectorXIncrements[parameters.xpos+1]
    local up = Positions.Cards[parameters.color].up + parameters.upSum
    local height = heightFirst + (heightIncrement*(parameters.ypos))
    parameters.card.setPositionSmooth({right, height, up}, false, true)

    if (parameters.shouldMoveCharges == true) then
        moveDeployedCharges(parameters.card, charges)
    end
end

function moveDeployedCharges(card, charges)
    Wait.time(function()
        local snapPositions = getSnapPoints(card, true)
        for key, charge in ipairs(charges) do
            if (snapPositions[key] != nil) then
                charge.setPositionSmooth(snapPositions[key], false, true)
            else
                charge.unregisterCollisions()
                charge.highlightOn(Color(1, 0, 0))
                local chargePosition = charge.getPosition()
                charge.setPositionSmooth({chargePosition[1], 4,chargePosition[3]})
                print('Removing extra charge')
                Wait.time(function() checkDestruct(charge) end, 1.5)
            end
        end
    end, 0.35)
end

-- Detect charges on the station card
-- If there are charge slots on the deployed side, move existing charges there
-- Delete extra charges
function getCharges(object)
    local hitList = Physics.cast({
        origin       = object.getPosition(),
        direction    = {0,1,0},
        type         = 3,
        size         = { 1.3, 1, 3.10},
        max_distance = 1
    })

    local chargeObjects = {};

    for key, value in ipairs(hitList) do
        if (value.hit_object.type == 'Block') then
            table.insert(chargeObjects, value.hit_object)
        end
    end

    return chargeObjects;
end

function getSnapPoints(object, isDeployed)
    local snapPoints = {};
    for key, value in ipairs(object.getSnapPoints()) do
        if (isDeployed and value.position[3] > 1) then
            table.insert(snapPoints, object.positionToWorld(value.position))
        end
        if (not isDeployed and value.position[3] < 1) then
            table.insert(snapPoints, object.positionToWorld(value.position))
        end
    end
    return snapPoints
end

-- Fill empty shy pluto spots by moving dice to the left, and then draw
-- new dice to fill remaining spots
function deployDice()
    if (ResupplyInProgress == true) then return end

    ResupplyInProgress = true
    Wait.time(function() ResupplyInProgress = false end, 2)
    local dice = {}

    local deployed = getObjectFromGUID(ShyPlutoDiceZone)
    if (deployed) then
        for key, die in ipairs(deployed.getObjects()) do
            local type = die.tag
            if (string.find(type, 'Dice')) then
                table.insert(dice, die)
            end
        end
    end

    lastEmptyPosition = 1;
    for index, die in spairs(dice, function(t,a,b) return t[b].getPosition()[1] > t[a].getPosition()[1] end) do
        die.setPositionSmooth({ShyPlutoDiceX[lastEmptyPosition], ShyPlutoDiceY, ShyPlutoDiceZ})
        lastEmptyPosition = lastEmptyPosition + 1
    end

    local miningDiceBag = getMiningDiceBag()
    miningDiceBag.shuffle()

    if (lastEmptyPosition < 7) then
        for k=lastEmptyPosition, 6 do
            if #miningDiceBag.getObjects() == 0 then return end
            miningDiceBag.takeObject({
                position = {x=ShyPlutoDiceX[k], y=ShyPlutoDiceY, z=ShyPlutoDiceZ},
                rotation = {x=270, y=180, z=0},
                smooth = true
            })
        end
    end
end

-- Create all deploy functions since Tabletop Simulator doesn't support
-- passing parameters into buttons
for c=1,7 do
    for k=1,13 do
        -- Create a new global function
        _G[Colors[c] .. 'Deploy' .. k] = function(obj, color, alt_click)
            deployRouting(obj, k, Guids.DeploySections[Colors[c]][k], Colors[c], alt_click)
        end
    end
end

-- The game always starts on the Red player's turn. If there is no Red player,
-- the turn automatically switches to the next player. If a Red player exists,
-- onPlayerTurnEnd will not trigger.
function onPlayerTurnEnd(color)
    if (gameLoaded == false) then return end
    if (settings.started == true and Turns.enable == true) then
        resupplySectors()
    end
    -- Player turn end can be called before objects are loaded
    if (settings.shyPluto or settings.terraProxima == true) then
        local miningDiceBag = getMiningDiceBag()
        if (miningDiceBag != nil) then
            deployDice()
        end
    end
end