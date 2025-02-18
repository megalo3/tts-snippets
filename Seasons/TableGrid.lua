Cross = 'https://steamusercontent-a.akamaihd.net/ugc/2056499830064337645/4194EE0B601B93984E7B4B1A53179A3FB543AD7B/'
StartY = .93
Decals = {}
XMult = 3
ZMult = 4.11

function getTableGridObject()
    return getObjectFromGUID('4ee1f2')
end

function resetTableGrid()
    Decals = {}
    getDecals()
    getTableGridObject().setDecals(Decals)
end

function getDecals()
    setTableau(-25.07, -10.6)
    setTableau(6.15, -10.6)
    setTableau(-25.07, 3.3)
    setTableau(6.15, 3.3)
    -- Draw/Discard Pile
    if settings.enchantmentCard == 'Vision of Destiny' then
        setCrosses(-8.00, -6.49, 4, 1)
    else
        setCrosses(-5.00, -6.49, 2, 1)
    end

    if settings.enchantmentCards == true then
        setCrosses(-8.21, 7.42, 1, 1)
    end
end

function setTableau(startX, startZ)
    setCrosses(startX, startZ, 5, 3)
end

function setCrosses(startX, startZ, repeatX, repeatZ)
    startX = startX - (XMult / 2)
    startZ = startZ - (ZMult / 2)
    for x=0,repeatX do
        for z=0,repeatZ do
            local p = {startX + (x * XMult), StartY, startZ + (z * ZMult)}
            local toLocal = getTableGridObject().positionToLocal(p)
            setCross(toLocal)
        end
    end
end

function setCross(position)
    table.insert(Decals, {
        name = "Cross",
        url      = Cross,
        position = position,
        rotation = {90, 0, 0},
        scale = {.5,.8,1}
    })
end