function rand(number)
    return math.ceil(math.random() * number)
end

function getNonSeatedPlayerColors()
    local allColors = {'Purple', 'Red', 'Blue', 'Yellow'}
    local seatedColors = getSeatedPlayerColors()
    local nonSeatedColors = {}
    for _, color in ipairs(allColors) do
        if has_value(seatedColors, color) == false then
            table.insert(nonSeatedColors, color)
        end
    end
    return nonSeatedColors
end

function shuffleArray(t)
  local tbl = {}
  for i = 1, #t do
    tbl[i] = t[i]
  end
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end

-- Lua doesn't have a round function!
function round(a)
    return math.floor(a+0.5)
end

function coerceBoolean(value)
    if value == 'True' then return true end
    if value == 'False' then return false end
    return value
end


function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function has_all_values(tab, values)
    local valueCount = 0
    for _, value in ipairs(values) do
        if has_value(tab, value) then
            valueCount = valueCount + 1
        end
    end
    return valueCount == #values
end

function has_any_value(tab, values)
    for _, value in ipairs(values) do
        if has_value(tab, value) then
            return true
        end
    end
    return false
end

function coerceBoolean(value)
    if value == 'True' then return true end
    if value == 'False' then return false end
    return value
end

function tableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

function yellowPrint(message)
    printToAll(message, stringColorToRGB('Yellow'))
end

function GreenPrint(message)
    printToAll(message, stringColorToRGB('Green'))
end

function getSeatedPlayerColors()
    local playerColors = {}
    for _, player in ipairs(Player.getPlayers()) do
        if has_value(Colors, player.color) == true then
            table.insert(playerColors, player.color)
        end
    end
    return playerColors
end

function getSeatedPlayerColorsOrdered()
    local playerColors = {}
    for _, player in ipairs(Player.getPlayers()) do
        table.insert(playerColors, player.color)
    end
    local ordered = {}
    for _, color in ipairs(Colors) do
        if has_value(playerColors, color) == true then
            table.insert(ordered, color)
        end
    end
    return ordered
end

function getSnapPositionsWithAllTagsPositionedToWorld(obj, tags)
    local snaps = getSnapPositionsWithAllTags(obj, tags)
    local positions = {}
    for _, snap in ipairs(snaps) do
        table.insert(positions, obj.positionToWorld(snap))
    end
    return positions
end

function getSnapPositionsWithAllTags(obj, tags)
    local snaps = obj.getSnapPoints()
    local positions = {}
    for _, snap in ipairs(snaps) do
        if #snap.tags > 0 then
            if has_all_values(snap.tags, tags) then
                table.insert(positions, snap.position)
            end
        end
    end
    return positions
end

function getSnapPositionsWithAnyTagsPositionedToWorld(obj, tags)
    local snaps = getSnapPositionsWithAnyTags(obj, tags)
    local positions = {}
    for _, snap in ipairs(snaps) do
        table.insert(positions, obj.positionToWorld(snap))
    end
    return positions
end

function getSnapPositionsWithAnyTags(obj, tags)
    local snaps = obj.getSnapPoints()
    local positions = {}
    for _, snap in ipairs(snaps) do
        if #snap.tags > 0 then
            if has_any_value(snap.tags, tags) then
                table.insert(positions, snap.position)
            end
        end
    end
    return positions
end

function objectHasTag(objInfo, tag)
    for _, t in ipairs(objInfo.tags) do
        if t == tag then
            return true
        end
    end
    return false
end

function getObjectGuidWithTag(container, tag)
    for _, obj in ipairs(container.getObjects()) do
        if objectHasTag(obj, tag) then
            return obj.guid
        end
    end
end