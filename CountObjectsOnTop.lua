function getTokenCount(card, valueType)
    local pos = getTokenPosition(card, valueType)
    local hitList = Physics.cast({
        origin       = pos,
        direction    = {0,1,0},
        type         = 3,
        size         = { 1.3, 1, 3.10},
        max_distance = 1
    })

    local timeCount = 0;
    local progressCount = 0;

    for key, value in ipairs(hitList) do
        if value.hit_object.hasTag('Time') then
            if (value.hit_object.name == 'Custom_Token_Stack') then
                timeCount = value.hit_object.getQuantity()
            else
                timeCount = 1
            end
        end
        if value.hit_object.hasTag('Progress') then
            if (value.hit_object.name == 'Custom_Token_Stack') then
                progressCount = value.hit_object.getQuantity()
            else
                progressCount = 1
            end
        end
    end

    if valueType == 'Time' then return timeCount end
    if valueType == 'Progress' then return progressCount end
end

function getTokenPosition(card, valueType)
    local pos = card.getPosition()
    pos[3] = pos[3]+1
    if valueType == 'Time' then pos[1] = pos[1]+0.8 end
    if valueType == 'Progress' then pos[1] = pos[1]-0.8 end
    return pos
end