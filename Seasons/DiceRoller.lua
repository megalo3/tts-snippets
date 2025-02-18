spawnPos = {
    {-3.46, 1.39, 12.39}, -- 3
    {-5.64, 1.39, 12.06}, -- 2
    {-1.27, 1.39, 11.81}, -- 4
    {-6.41, 1.39, 9.98}, -- 1
    {-0.37, 1.39, 9.78} -- 5
}
restPos = {
    water = 22.81,
    earth = 24.01,
    fire = 25.20,
    air = 26.41
}
startZ = -2.72
zIncrement = -1.04
OtherElementMap = {
    water = {'earth', 'fire', 'air'},
    earth = {'water', 'fire', 'air'},
    fire = {'water', 'earth', 'air'},
    air = {'water', 'earth', 'fire'}
}

function click_roll()
    local round = getRound()
    local element = 'water'
    if round > 3 and round <= 6 then
        element = 'earth'
    end
    if round > 6 and round <= 9 then
        element = 'fire'
    end
    if round > 9 and round <= 12 then
        element = 'air'
    end

    local destinyDice = getObjectsWithAllTags({'destiny di'})
    if #destinyDice == 1 then
        returnDestiny()
    end

    local dice = getObjectsWithAllTags({'Die', element})

    returnDice(OtherElementMap[element])

    for index, die in ipairs(dice) do
        die.setPositionSmooth(spawnPos[index], false, true)
        Wait.frames(function()
            die.randomize()
        end, 90)
    end
end

function returnDice(elements)
    for _, element in ipairs(elements) do
        local returnDice = getObjectsWithAllTags({'Die', element})
        for index, returnDie in ipairs(returnDice) do
            local z = startZ + (zIncrement * (index - 1))
            returnDie.setPositionSmooth({restPos[element], 1.4, z})
            returnDie.setRotationSmooth({0,0,0})
        end
    end
end

function alphanumsort(o)
    local function padnum(d) return ("%03d%s"):format(#d, d) end
    table.sort(o, function(a,b)
    return tostring(a):gsub("%d+",padnum) < tostring(b):gsub("%d+",padnum) end)
    return o
end