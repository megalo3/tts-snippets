function addSelectedExpansions()
    addDreadnaught()
    addShyPluto()
    addBiodome()
    addTerraProxima()
    addJohnDClaire()
    addDeadReckoning()
    addGenesis()
    addColonyCards()
    removeUnusedExpansions()
end

function addDecktoDeck(consumerDeck, consumedDeckGUID)
    local consumedDeck = getObjectFromGUID(consumedDeckGUID)
    for index, card in ipairs(consumedDeck.getObjects()) do
        consumerDeck.putObject(consumedDeck.takeObject())
    end
end

function getExpansion(name)
    guids = {
        commandStation = '70f1b7',
        biodome = 'ba13be',
        genesis = 'a5ceaa',
        terraProxima = '9e7285',
        shyPluto = 'cef3c4',
        dreadnaught = 'fd5137'
    }
    return getObjectFromGUID(Guids.Bags.Expansions).takeObject({
        guid = guids[name]
    })
end

function addDreadnaught()
    if (settings.dreadnaught == true) then
        print('Adding Dreadnaught.')
        expansion = getExpansion('dreadnaught');
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[2]), expansion.guid)
    end
end

function addShyPluto()
    expansion = getExpansion('shyPluto');

    if (settings.worldEater == true) then
        print('Adding The World Eater.')
        -- Eater Die
        expansion.takeObject({guid = '0ccf00', position = {-1.70, 2, 8.67}})
        -- The World Eater
        expansion.takeObject({guid = '633ea0', position = {10.11, 2, 22.20}, rotation = {0,180,0}})
        -- Cube
        expansion.takeObject({guid = 'a7bbb5', position = {8.98, 2.1, 21.41}})
    end

    if (settings.shyPluto == true) then
        print('Adding Shy Pluto.')
        expansion.takeObject({guid = Guids.Expansions.ShyPluto.Sectors[1]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[1]), Guids.Expansions.ShyPluto.Sectors[1])
        expansion.takeObject({guid = Guids.Expansions.ShyPluto.Sectors[2]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[2]), Guids.Expansions.ShyPluto.Sectors[2])
        expansion.takeObject({guid = Guids.Expansions.ShyPluto.Sectors[3]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[3]), Guids.Expansions.ShyPluto.Sectors[3])
        pinkDiceBag = getObjectFromGUID(Guids.Expansions.ShyPluto.PinkBag)
        pinkDiceBag.shuffle()
        Global.setVar('resupplyInProgress', true)
        Wait.time(function() Global.setVar('resupplyInProgress', false) end, 2)

        for k=1,6 do
            pinkDiceBag.takeObject({
                position = {x=Global.getVar('ShyPlutoDiceX')[k], y=ShyPlutoDiceY, z=ShyPlutoDiceZ},
                rotation = {x=270, y=180, z=0},
                smooth = true
            })
        end
        checkDestruct(pinkDiceBag)

        -- Shuffle the red dice
        getObjectFromGUID(Guids.Expansions.ShyPluto.RedBag).shuffle()
    end

    getObjectFromGUID(Guids.Bags.Expansions).putObject(expansion);
end

function addBiodome()
    if (settings.biodome == true) then
        print('Adding Biodome Sector Cards.')
        expansion = getExpansion('biodome');
        expansion.takeObject({guid = Guids.Expansions.Biodome.Sectors[1]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[1]), Guids.Expansions.Biodome.Sectors[1])
        expansion.takeObject({guid = Guids.Expansions.Biodome.Sectors[2]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[2]), Guids.Expansions.Biodome.Sectors[2])
        expansion.takeObject({guid = Guids.Expansions.Biodome.Sectors[3]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[3]), Guids.Expansions.Biodome.Sectors[3])
        expansion.takeObject({guid = Guids.Expansions.Biodome.Colony})
        getObjectFromGUID(Guids.Bags.Expansions).putObject(expansion);
    end
end

function addTerraProxima()
    if (settings.terraProxima == true) then
        print('Adding Terra Proxima sector cards.')
        expansion = getExpansion('terraProxima');
        expansion.takeObject({guid = Guids.Expansions.Proxima.Sectors[1]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[1]), Guids.Expansions.Proxima.Sectors[1])
        expansion.takeObject({guid = Guids.Expansions.Proxima.Sectors[2]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[2]), Guids.Expansions.Proxima.Sectors[2])
        expansion.takeObject({guid = Guids.Expansions.Proxima.Sectors[3]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[3]), Guids.Expansions.Proxima.Sectors[3])
        expansion.takeObject({guid = Guids.Expansions.Proxima.Colony})
        getObjectFromGUID(Guids.Bags.Expansions).putObject(expansion);

        -- If shy pluto exists, combine terra proxima dice with shy pluto and shuffle
        local orangeDiceBag = getObjectFromGUID(Guids.Expansions.Proxima.OrangeDiceBag)
        local redDiceBag = getObjectFromGUID(Guids.Expansions.ShyPluto.RedBag)
        if (settings.shyPluto == true) then
            for k=1,15 do
                redDiceBag.putObject(orangeDiceBag.takeObject())
            end
            Wait.time(function() redDiceBag.shuffle() end, 0.1)
            checkDestruct(orangeDiceBag)
        else
            orangeDiceBag.shuffle()
        end
    end
end

function addJohnDClaire()
    if (settings.johnDClaire == true) then
        print('Adding John D Claire promo card.')
        getObjectFromGUID(Guids.Decks.Sectors[3]).putObject(getObjectFromGUID(Guids.Bags.Expansions).takeObject({guid = Guids.Expansions.JohnDClaire.Sector3}))
    end
end

function addDeadReckoning()
    if (settings.deadReckoning == true) then
        print('Deploying Dread Reckoning cards.')
        local deck = getObjectFromGUID(Guids.Bags.Expansions).takeObject({guid = Guids.Expansions.DeadReckoning.Sector1, position = {17.21, 3.04, 40.02}})

        -- If this is a 7 player game, we have to duplicate a random Dread Reckoning card
        -- because there are only 6
        if (#Player.getPlayers() > 6) then
            deck.shuffle()
            local taken = deck.takeObject()
            local cloned = taken.clone()
            deck.putObject(taken)
            deck.putObject(cloned)
        end

        deck.shuffle()

        -- Need to wait for 6-7 player games deployment of McCaffery Monitor-Relay Class Crafts
        DeployScript = getObjectFromGUID('73274b')
        Wait.time(function()
            for _, player in ipairs(Player.getPlayers()) do
                DeployScript.call('autoDeployCard', { card = deck.takeObject(), color = player.color })
            end
        end, .5)
    end
end

function addGenesis()
    if (settings.genesis == true) then
        print('Adding Genesis.')

        expansion = getExpansion('genesis');
        expansion.takeObject({guid = Guids.Expansions.Genesis.Sectors[1]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[1]), Guids.Expansions.Genesis.Sectors[1])
        expansion.takeObject({guid = Guids.Expansions.Genesis.Sectors[2]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[2]), Guids.Expansions.Genesis.Sectors[2])
        expansion.takeObject({guid = Guids.Expansions.Genesis.Sectors[3]})
        addDecktoDeck(getObjectFromGUID(Guids.Decks.Sectors[3]), Guids.Expansions.Genesis.Sectors[3])
        expansion.takeObject({guid = Guids.Expansions.Genesis.Colony})
        getObjectFromGUID(Guids.Bags.Expansions).putObject(expansion);
    end
end

function addColonyCards()
    if (settings.biodome == true) then
        getObjectFromGUID(Guids.Expansions.Biodome.Colony).setPosition({3.00, 1.00, 30.00})
        getObjectFromGUID(Guids.Expansions.Biodome.Colony).setRotation({0, 180, 180})
        print('Adding Biodome Colony Cards.')
    end
    if (settings.terraProxima == true) then
        getObjectFromGUID(Guids.Expansions.Proxima.Colony).setPosition({3.00, 1.00, 30.00})
        getObjectFromGUID(Guids.Expansions.Proxima.Colony).setRotation({0, 180, 180})
        print('Adding Terra Proxima Colony Cards.')
    end
    if (settings.genesis == true) then
        getObjectFromGUID(Guids.Expansions.Genesis.Colony).setPosition({3.00, 1.00, 30.00})
        getObjectFromGUID(Guids.Expansions.Genesis.Colony).setRotation({0, 180, 180})
        print('Adding Genesis Colony Cards.')
    end
    Wait.time(startColonyDeal, 2)
end

function startColonyDeal()
    colonyCardsDeck = find_pile(getObjectFromGUID('94470d'))
    if colonyCardsDeck != nil then
        colonyCardsDeck.shuffle()
        searchedColonyCards = {}
        foundColonyCardTotal = 0
        checkColonyCard()
    end
end

-- Switch out 6 different sector colony cards with biodome colony cards
function checkColonyCard()
    colonyCardsDeck.takeObject({
        flip = true,
        position = {4.5, 1.13, 30},
        smooth = true,
        callback_function = function(card)
            local sectorNumber = card.getRotationValue()
            if foundColonyCardTotal < 6 then
                -- Only switch out colony cards if the sector hasn't already been switched
                if searchedColonyCards[sectorNumber] == nil then
                    searchedColonyCards[sectorNumber] = true
                    foundColonyCardTotal = foundColonyCardTotal + 1
                    colonyCard = findColonySectorCard(sectorNumber)
                    local colonyPosition = colonyCard.getPosition()
                    colonyCard.setPositionSmooth({4.5, 1.13, 30})
                    card.setPositionSmooth(colonyPosition)
                end
                -- Since there aren't 6 switched colony cards, run the function again
                checkColonyCard()
            end
        end
    })
end

function findColonySectorCard(sectorNumber)
    local cards = getObjectFromGUID(ColonyCardsZone).getObjects()
    for index, card in ipairs(cards) do
        if (string.find(card.type, 'Card') and card.getRotationValue() == sectorNumber) then
            return card
        end
    end
end

function getPilotBag(value)
    return getObjectFromGUID(Guids.Expansions.ShyPluto.PilotBags[value])
end

function getMiningDiceBag()
    if (settings.shyPluto == true) then
        return getObjectFromGUID(Guids.Expansions.ShyPluto.RedBag)
    end
    if (settings.terraProxima == true) then
        return getObjectFromGUID(Guids.Expansions.Proxima.OrangeDiceBag)
    end
end

function removeUnusedExpansions()
    if (settings.dreadnaught == false) then
        print('Removing Dreadnaught.')
        -- Deck, Title
        removeMultiple({ Guids.Expansions.DreadnaughtDeck, '8c072f' })
    end

    if (settings.shyPluto == false and settings.worldEater == false) then
        print('Removing Shy Pluto.')
        checkDestruct(shyPlutoSector1)
        checkDestruct(shyPlutoSector2)
        checkDestruct(shyPlutoSector3)
        -- Dice bags, dice, world eater cards, pdf
        removeMultiple({
            -- Sector 1, 2, 3
            Guids.Expansions.ShyPluto.Sectors[1],
            Guids.Expansions.ShyPluto.Sectors[2],
            Guids.Expansions.ShyPluto.Sectors[3],
            Guids.Expansions.ShyPluto.PinkBag, '633ea0', 'a7bbb5', '897909', '0ccf00', '7622da', '29df5a',
            -- Game box
            '1b8a94',
            -- Title
            '79267c'
        })
    end

    if (settings.terraProxima == true and settings.shyPluto == false) then
        removeMultiple({Guids.Expansions.ShyPluto.RedBag})
    end

    -- Delete shy pluto mining station if neither proxima or pluto
    if (settings.terraProxima == false and settings.shyPluto == false and settings.worldEater == false) then
        removeMultiple({
            'aa6cc3',
            Guids.Expansions.ShyPluto.PilotBags.Red,
            Guids.Expansions.ShyPluto.PilotBags.Orange,
            Guids.Expansions.ShyPluto.PilotBags.Yellow,
            Guids.Expansions.ShyPluto.PilotBags.Green,
            Guids.Expansions.ShyPluto.PilotBags.Blue,
            Guids.Expansions.ShyPluto.PilotBags.Teal,
            Guids.Expansions.ShyPluto.PilotBags.Purple,
            Guids.AutoRollDisplay['Red'],
            Guids.AutoRollDisplay['Orange'],
            Guids.AutoRollDisplay['Yellow'],
            Guids.AutoRollDisplay['Green'],
            Guids.AutoRollDisplay['Blue'],
            Guids.AutoRollDisplay['Teal'],
            Guids.AutoRollDisplay['Purple'],
            Guids.Expansions.ShyPluto.RedBag,
            -- Extra dice by ROYGTBP
            '284842', '99eb0f',
            '887110', '4fbd20',
            'f2095b', '6b0985',
            '4f72e5', '460a76',
            '4d7108', '7c2bed',
            'bf288d', 'd86ace',
            '255f76', '7f8d0c',
            -- Ship numpad hotkey text
            '408c0f',
        })
    end

    if (settings.biodome == false) then
        print('Removing Biodome.')
        removeMultiple({
            Guids.Expansions.Biodome.Sectors[1],
            Guids.Expansions.Biodome.Sectors[2],
            Guids.Expansions.Biodome.Sectors[3],
            Guids.Expansions.Biodome.Colony,
            -- instructions, title
            'd16fc2', 'd9e362'
        })
    end

    if (settings.terraProxima == false) then
        print('Removing Terra Proxima.')
        removeMultiple({
            -- Title, Game box
            'd31912', '9e2a53',
            Guids.Expansions.Proxima.Sectors[1],
            Guids.Expansions.Proxima.Sectors[2],
            Guids.Expansions.Proxima.Sectors[3],
            Guids.Expansions.Proxima.UpgradeDeck,
            Guids.Expansions.Proxima.OrangeDiceBag,
            Guids.Expansions.Proxima.Colony,
            Guids.Expansions.Proxima.ShipDie,
            Guids.Expansions.Proxima.PilotBag,
            Guids.Expansions.Proxima.HelpText,
            Guids.Expansions.Proxima.Rulebook,
            -- script zone
            '84e601',
            -- Sector 13
            '49fa5b', '611b6d', '865e5f', '865e5f', '645b55',
            'bdc915', 'a0696f', '8aa3d6', 'd5f2f4', '06c771',
            '5ee2bc', '0f152b', 'd5a6cd', 'e0f9d7', 'a7dd25',
            '2997d4', 'af0a04', '2a6e02', 'e4690f', '95a377',
            '31a80a', '0eac03', 'dc81fb', 'eb01ea', 'd47673',
            '22b093', 'f278bc', '6269a3', 'f86306', 'dfe80b',
            'c87ead', '21ae1c', '4b9f30', 'ec53f7', 'c5ca23',
            '2a65e6', 'a174f8', 'd7fe96', 'c2ae00', '4af7c0',
            '4f95ef', '3b4252', '85f58b', 'd382e6'
        })
    end

    if (settings.genesis == false) then
        removeMultiple({
            -- Game box
            'c18398'
        })
    end

    if (settings.johnDClaire == false) then
        print('Removing John D Claire promo.')
        removeMultiple({ Guids.Expansions.JohnDClaire.Sector3, Guids.Expansions.JohnDClaire.Title })
    end

    if (settings.deadReckoning == false) then
        print('Removing Dread Reckoning promo.')
        removeMultiple({ Guids.Expansions.DeadReckoning.Sector1, Guids.Expansions.DeadReckoning.Title })
    end
end

function removeMultiple(removals)
    for key, value in ipairs(removals) do
        checkDestruct(getObjectFromGUID(value))
    end
end