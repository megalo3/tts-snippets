Scores = {
    prestige = {
        White = 0,
        Pink = 0,
        Orange = 0,
        Yellow = 0
    },
    crystals = {
        White = 0,
        Pink = 0,
        Orange = 0,
        Yellow = 0
    },
    unplayed = {
        White = 0,
        Pink = 0,
        Orange = 0,
        Yellow = 0
    },
    bonus = {
        White = 0,
        Pink = 0,
        Orange = 0,
        Yellow = 0
    },
    endofgame = {
        White = 0,
        Pink = 0,
        Orange = 0,
        Yellow = 0
    },
}


-- {value, id}
function scoreChange(input)
    local id = input.id
    local value = input.value

    types = {'prestige', 'crystals', 'unplayed', 'bonus', 'endofgame'}

    -- {type, color}
    local matches = {}
    for word in string.gmatch(id, "%a+") do
        table.insert(matches, word)
    end
    Scores[matches[1]][matches[2]] = value

    updateTotal(matches[2])
end

function setAllTotals()
    printToAll('The end of year 3 marks the end of the game.', stringColorToRGB('Yellow'))
    printToAll('Players must add their end of game bonuses manually.', stringColorToRGB('Yellow'))

    for _, player in ipairs(Player.getPlayers()) do
        local color = player.color

        -- PRESTIGE
        local prestige = getCardPrestigeTotal(color)
        Scores.prestige[color] = prestige
        UI.setAttribute('prestige-' .. color, 'text', prestige)

        -- CRYSTALS
        local crystals = getObjectsWithAllTags({color, 'crystals'})[1]
        local crystalValue = crystals.getValue()
        Scores.crystals[color] = crystalValue
        UI.setAttribute('crystals-' .. color, 'text', crystalValue)

        -- UNPLAYED
        local unplayedMultiplier = -5
        -- Check if player has special ability #5
        if settings.specialAbility[color] == '5' then
            unplayedMultiplier = 3
        end
        local unplayedValue = #player.getHandObjects() * unplayedMultiplier
        Scores.unplayed[color] = unplayedValue
        UI.setAttribute('unplayed-' .. color, 'text', unplayedValue)

        -- BONUS
        local bonusTrack = getBonusTrackPosition(color)
        local bonusPoints = 0
        if bonusTrack == 2 then
            bonusPoints = -5
        elseif bonusTrack == 3 then
            bonusPoints = -12
        elseif bonusTrack == 4 then
            bonusPoints = -20
        end
        Scores.bonus[color] = bonusPoints
        UI.setAttribute('bonus-' .. color, 'text', bonusPoints)

        updateTotal(color)
    end
end

function updateTotal(color)
    local total = Scores.prestige[color] + Scores.crystals[color] + Scores.unplayed[color] + Scores.bonus[color] + Scores.endofgame[color]

    UI.setAttribute('total-' .. color, "text", total)
end

function getCardPrestigeTotal(color)
    local zone = getObjectsWithAllTags({color, 'base', 'promo', 'path of destiny', 'enchanted kingdom', 'tableau'})[1]
    local prestige = 0
    for _, card in ipairs(zone.getObjects()) do
        if card.type == 'Card' then
            prestige = prestige + Cards[card.getName()].Prestige
        end
    end
    return prestige
end

function getBonusTrackPosition(color)
    function sortBlockX(a,b)
        return a[1] < b[1]
    end
    function roundPosition(position)
        return {
            round(position[1], 3),
            round(position[2]+.3, 3),
            round(position[3], 3)
        }
    end
    function round(number, places)
        local mult = 10^(places or 0)
        return math.floor(number * mult + 0.5) / mult
    end

    local board = getObjectsWithAllTags({color, 'player board'})[1]
    local block = getObjectsWithAllTags({color, 'bonus track'})[1]
    local blockPosition = roundPosition(block.getPosition())
    local blockIndex = 0
    local points = {}
    for _, point in ipairs(board.getSnapPoints()) do
        if has_value(point.tags, 'bonus track') then
            local position = board.positionToWorld(point.position)
            local roundedPosition = roundPosition(position)
            table.insert(points, roundedPosition)
        end
    end
    table.sort(points, sortBlockX)

    for index, point in ipairs(points) do
        if (point[1] == blockPosition[1]) then
            blockIndex = index
        end
    end

    if blockIndex == 0 then return end
    return blockIndex
end