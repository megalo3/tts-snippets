Drafting = {
    Turn = 1,
    PlayerCount = 0,
    SelectedCount = 0,
    MaxTurns = 9
}

function dealStartingHand()
    local colors = shuffleArray(Player.getAvailableColors())
    local deck = getDrawDeck()
    local playerColors = {table.unpack(getSeatedPlayerColors())}
    Drafting.PlayerCount = #playerColors

    if settings.difficulty == 'beginner' then
        for _, card in ipairs(deck.getObjects()) do
            for x=1,4 do
                local hasBeginnerTag = has_value(card.tags, 'beginner' .. x)
                local isPlayerColor = has_value(playerColors, colors[x])
                if hasBeginnerTag == true and isPlayerColor == true then
                    local takenCard = deck.takeObject({ guid = card.guid })
                    takenCard.deal(1, colors[x])
                end
            end
        end
        print('There is no drafting in Apprentice Wizard difficulty. Everyone keeps their starting hands.')
        elementalConstruction(9, deck, playerColors)
        if settings.enchantmentCard == 'Extended Experience' then
            for _, color in ipairs(playerColors) do
                deck.deal(3, color)
            end
        end
        endDrafting()
    elseif settings.enchantmentCard == 'Elemental Construction' then
        elementalConstruction(18, deck, playerColors)
    else

        local draftCount = 9
        if settings.enchantmentCard == 'Natural Selection' then
            yellowPrint('Natural Selection Enchantment')
            yellowPrint('Each player discards one of their Power cards and the remaining 10 are passed to the left.')
            Drafting.Turn = 0
            draftCount = 11
            Drafting.MaxTurns = 10
        end
        if settings.enchantmentCard == 'Extended Experience' then
            draftCount = 12
            Drafting.MaxTurns = 12
        end
        if settings.enchantmentCard == 'Crossed Paths' then
            yellowPrint('Crossed Paths Enchantment')
            yellowPrint('The first card selected is passed to the player to your left.')
        end

        for _, color in ipairs(playerColors) do
            for x=1, draftCount do
                local card = deck.takeObject({
                    position = getTableauPosition({color = color, slot = x}),
                    flip = true,
                    rotation = Players[color].SpecialR
                })
                card.addTag(color)
                if settings.enchantmentCard == 'Natural Selection' then
                    addCardDiscardButton(card)
                elseif settings.enchantmentCard == 'Crossed Paths' then
                    addCardPassLeftButton(card)
                else
                    addCardSelectButton(card)
                end
            end
        end
        if settings.enchantmentCard ~= 'Natural Selection' then
            print('Every player must draft their card. Round 1.')
        end
    end
end

function elementalConstruction(num, deck, playerColors)
    if settings.enchantmentCard == 'Elemental Construction' then
        yellowPrint('Elemental Constuction Enchantment')
        yellowPrint('Each player draws 18 and selects 9 of them. The remaining are shuffled back into the draw pile.')
        for _, color in ipairs(playerColors) do
            deck.deal(num, color)
        end
    end
end

function addCardSelectButton(card)
    card.createButton(getDefaultButton())
end

function addCardPassLeftButton(card)
    local button = getDefaultButton()
    button.label = "Pass Left"
    button.width = 450
    button.tooltip = "Pass to the player to your left"
    button.click_function = "passLeftCard"
    card.createButton(button)
end

function addCardDiscardButton(card)
    local button = getDefaultButton()
    button.label = "Discard"
    button.tooltip = "Discard Card"
    button.click_function = "discardCard"
    card.createButton(button)
end

function getDefaultButton()
    return {
        click_function = "selectCard",
        function_owner = Global,
        label          = "Select",
        position       = {0,.2, 0},
        rotation       = {0,0,0},
        width          = 380,
        height         = 145,
        font_size      = 100,
        color          = {0/255, 0/255, 0/255,1},
        font_color     = {255/255, 255/255,255/255,1},
        tooltip        = 'Select Card'
    }
end

function selectCard(object, color)
    if object.hasTag(color) == false then return end
    removeZoneButtons(color)
    object.deal(1, color)
    checkPassDraft()
end

function discardCard(object, color)
    if object.hasTag(color) == false then return end
    removeZoneButtons(color)
    object.setPositionSmooth(DiscardPilePos)
    checkPassDraft()
end

function passLeftCard(object, color)
    if object.hasTag(color) == false then return end
    removeZoneButtons(color)
    local seatedColors = getSeatedPlayerColors()
    for index, c in ipairs(seatedColors) do
        if color == c then
            local nextColor = seatedColors[index + 1]
            if nextColor == nil then
                nextColor = seatedColors[1]
            end
            object.deal(1, nextColor)
        end
    end
    checkPassDraft()
end

function removeZoneButtons(color)
    local zone = getObjectsWithAllTags({color, 'hidden zone'})[1]
    for _, object in ipairs(zone.getObjects(true)) do
        if object.type == 'Card' then
            object.removeButton(0)
            object.removeTag(color)
        end
    end
end

function checkPassDraft()
    Drafting.SelectedCount = Drafting.SelectedCount + 1
    if Drafting.SelectedCount == Drafting.PlayerCount then
        Wait.time(function() passDraft() end, 1.3)
    end
end

function passDraft()
    Drafting.SelectedCount = 0
    Drafting.Turn = Drafting.Turn + 1

    if Drafting.Turn ~= Drafting.MaxTurns then
        print('Every player must draft their card. Round ' .. Drafting.Turn .. '.')
    end
    local seatedColors = getSeatedPlayerColors()
    local remainingCards = {
        White = {},
        Pink = {},
        Yellow = {},
        Orange = {},
    }

    for _, color in ipairs(seatedColors) do
        local zone = getObjectsWithAllTags({color, 'hidden zone'})[1]
        for _, object in ipairs(zone.getObjects(true)) do
            if object.type == 'Card' then
                table.insert(remainingCards[color], object)
            end
        end
    end
    for index, color in ipairs(seatedColors) do
        local nextColor = seatedColors[index + 1]
        if nextColor == nil then
            nextColor = seatedColors[1]
        end
        for remainingIndex, remainingCard in ipairs(remainingCards[color]) do
            if Drafting.Turn ~= Drafting.MaxTurns then
                local tabPos = getTableauPosition({ color = nextColor, slot = remainingIndex })
                remainingCard.setPositionSmooth(tabPos)
                remainingCard.setRotationSmooth(Players[nextColor].SpecialR)
                remainingCard.addTag(nextColor)
                addCardSelectButton(remainingCard)
            else
                remainingCard.deal(1, nextColor)
            end
        end
    end

    if Drafting.Turn == Drafting.MaxTurns then
        print('Every player automatically drafts their final card. Round ' .. Drafting.MaxTurns .. '.')
        if settings.enchantmentCard == 'Natural Selection' then
            yellowPrint('Natural Selection Enchantment')
            yellowPrint('Players must discard down to 9 cards.')
        end
        endDrafting()
    end
end

function endDrafting()
    for _, zone in ipairs(getObjectsWithAllTags({'hidden zone'})) do
        local p = zone.getPosition()
        zone.setPositionSmooth({p[1], -4.5, p[3]})
    end
    setLibraryCards()
end

function yellowPrint(message)
    printToAll(message, stringColorToRGB('Yellow'))
end