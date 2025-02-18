
EnchantmentPos = {-8.21, 2, 7.42}

function dealEnchantmentCard()
    local placedEnchantmentCard = getCardFromZone(getObjectFromGUID(Guids.Zones.Enchantment))
    local card = nil
    if placedEnchantmentCard ~= nil then
        card = placedEnchantmentCard
    else
        local deck = getObjectsWithAllTags({'enchantment'})[1]
        deck.shuffle()
        card = deck.takeObject({
            position = EnchantmentPos,
            flip = true
        })
    end

    settings.enchantmentCard = card.getName()
end

function removeEnchantment()
    resetTableGrid()
    destroyObject(getObjectFromGUID(Guids.Text.Enchantment))
end