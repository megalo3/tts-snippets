function getSeatedPlayerColors()
    local playerColors = {}
    for _, player in ipairs(Player.getPlayers()) do
        table.insert(playerColors, player.color)
    end
    local ordered = {}
    for _, color in ipairs(PlayerOrder) do
        if has_value({playerColors, color}) == true then
            table.insert(ordered, color)
        end
    end
    return ordered
end

function getNonSeatedPlayerColors()
    local allColors = {'White', 'Pink', 'Orange', 'Yellow'}
    local seatedColors = getSeatedPlayerColors()
    local nonSeatedColors = {}
    for _, color in ipairs(allColors) do
        if has_value({seatedColors, color}) == false then
            table.insert(nonSeatedColors, color)
        end
    end
    return nonSeatedColors
end