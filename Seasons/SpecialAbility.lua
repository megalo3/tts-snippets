function dealSpecialAbilityTokens()
    local bag = getObjectFromGUID(Guids.Bags.SpecialAbility)
    bag.shuffle()
    local playerColors = getSeatedPlayerColors()

    for _, color in ipairs(playerColors) do
        -- Deal to spaces in front of board
        for x=1,3 do
            local token = spawnToken(color, x)
            -- Special Ability 16 requires a Destiny Enchantment
            local hasDestiny = (settings.enchantmentCard == 'Force of Destiny' or settings.enchantmentCard == 'Divine Destiny')
            if token.getName() == '16' and hasDestiny == false then
                getObjectsWithAllTags({'unused'})[1].putObject(token)
                token = spawnToken(color, x)
            end
            token.addTag(color)
        end
    end
    printToAll('Each player has been randomly dealt 3 Special Ability tokens. After the Prelude, before beginning the Tournament, each player will select one of their Special Ability tokens and place it on their game board.', stringColorToRGB('Pink'))
end

function spawnToken(color, x)
    local bag = getObjectFromGUID(Guids.Bags.SpecialAbility)
    return bag.takeObject({
        position = getTableauPosition({color = color, slot = x+12}),
        rotation = Players[color].SpecialR
    })
end