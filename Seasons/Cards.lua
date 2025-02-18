function onObjectSpawn(object)
    if object.type == 'Card' then
        setCardDescription(object)
        if Global.getTable('settings').setupComplete == true then
            setCardEffect(object)
        end
    end

    if object.hasTag('special ability') then
        local info = SpecialAbilityTokens[tonumber(object.getName())]
        object.setDescription(info.Description)
        object.createButton({
            click_function = "selectSpecialAbility",
            function_owner = Global,
            label          = "Select",
            position       = {0,0.15,-.65},
            rotation       = {0,0,0},
            width          = 360,
            height         = 125,
            font_size      = 100,
            color          = {0/255,200/255,130/255,1},
            font_color     = {255/255, 255/255,255/255,1},
            tooltip        = 'Select Special Ability Token'
        })
    end
end

function setCardDescription(card)
    local info = Cards[card.getName()]
    if info == nil then return end;
    local lineBreak = [[


]]
    local description = info.Description
    if info.Description2 ~= nil then
        description = description .. lineBreak .. info.Description2
    end
    if info.Description3 ~= nil then
        description = description .. lineBreak .. info.Description3
    end
    card.setDescription(description)
end

function setCardEffects()
    local objects = getObjectsWithAnyTags({'base', 'enchanted kingdom', 'path of destiny', 'promo'})
    for _, object in ipairs(objects) do
        if object.type == 'Card' then
            setCardEffect(object)
        end
    end
    local objects = getObjectsWithAnyTags({'special ability'})
    for _, object in ipairs(objects) do
        if object.getName() == '10' then
            setSpecialAbility10effect(object)
        end
    end

end

function setSpecialAbility10effect(object)
    function bootsIncreaseTime2(obj)
        advanceTimeByAmount({AdvanceTimeCount = 2, MarkEndOfRound = false})
        obj.removeButton(1)
        obj.removeButton(0)
    end
    function bootsDecreaseTime2(obj)
        advanceTimeByAmount({AdvanceTimeCount = -2, MarkEndOfRound = false})
        obj.removeButton(1)
        obj.removeButton(0)
    end
    object.createButton({
        click_function = "bootsDecreaseTime2",
        function_owner = Global,
        label          = "-2",
        position       = {-.3,0.25,-.4},
        rotation       = {0,0,0},
        width          = 200,
        height         = 200,
        font_size      = 100,
        color          = {0/255,200/255,130/255,1},
        font_color     = {255/255, 255/255,255/255,1},
        tooltip        = 'Decrease Time'
    })
    object.createButton({
        click_function = "bootsIncreaseTime2",
        function_owner = Global,
        label          = "+2",
        position       = {.3,0.25,-.4},
        rotation       = {0,0,0},
        width          = 200,
        height         = 200,
        font_size      = 100,
        color          = {0/255,200/255,130/255,1},
        font_color     = {255/255, 255/255,255/255,1},
        tooltip        = 'Increase Time'
    })
end

function setCardEffect(card)
    if card.getName() == 'Temporal Boots' then
        card.createButton({
            click_function = "bootsDecreaseTime",
            function_owner = Global,
            label          = "Decrease Time",
            position       = {-.52,0.25,.6},
            rotation       = {0,0,0},
            width          = 425,
            height         = 60,
            font_size      = 60,
            color          = {0,0,0,.97},
            font_color     = {255/255, 255/255,255/255,1},
            tooltip        = 'Decrease Time'
        })
        card.createButton({
            click_function = "bootsIncreaseTime",
            function_owner = Global,
            label          = "Increase Time",
            position       = {.52,0.25,.6},
            rotation       = {0,0,0},
            width          = 425,
            height         = 60,
            font_size      = 60,
            color          = {0,0,0,.97},
            font_color     = {255/255, 255/255,255/255,1},
            tooltip        = 'Increase Time'
        })
    end
end

function bootsIncreaseTime()
    advanceTimeByAmount({AdvanceTimeCount = 1, MarkEndOfRound = false})
end

function bootsDecreaseTime()
    advanceTimeByAmount({AdvanceTimeCount = -1, MarkEndOfRound = false})
end

function getAllCards()
    local cards = {}
    for _, zone in ipairs(getObjectsWithTag('tableau')) do
        for _, card in ipairs(zone.getObjects()) do
            table.insert(cards, card)
        end
    end
    return cards
end

function highlightEffects(type)
    local count = 0
    for _, card in ipairs(getAllCards()) do
        if card.type == 'Card' then
            local info = Cards[card.getName()]
            if
                (type == 'round' and info.EndOfRoundEffect == true) or
                (type == 'season' and info.ChangeOfSeasonEffect == true) then
                count = count + 1
                card.highlightOn(stringColorToRGB('Yellow'), 30)
            end
        end
    end
end

function selectSpecialAbility(object, color)
    if object.hasTag(color) == false then
        printToAll("You may not select another player's Special Ability token.", stringColorToRGB('Red'))
        return
    end
    object.setPositionSmooth(SpecialTokenPos[color])
    object.removeButton(0)
    object.removeTag(color)
    local otherTokens = getObjectsWithAllTags({color, 'special ability'})
    for _, token in ipairs(otherTokens) do
        token.removeTag(color)
        getObjectFromGUID(Guids.Bags.SpecialAbility).putObject(token)
    end

    local settings = Global.getTable('settings')
    settings.specialAbility[color] = object.getName()
    Global.setTable('settings', settings)
end