SectorScriptZones = {}

function sectorDeckOnLoad()
    SectorScriptZones = {
        getObjectFromGUID(Guids.Zones.Sectors[1]),
        getObjectFromGUID(Guids.Zones.Sectors[2]),
        getObjectFromGUID(Guids.Zones.Sectors[3]),
        getObjectFromGUID(Guids.Zones.Sectors[4])
    }

    for k=1,4 do
        if (SectorScriptZones[k] != nil) then
            local params = {
                click_function = "resupplySector" .. k,
                function_owner = Global,
                label          = "Resupply",
                position       = {0,0.4,-0.35},
                rotation       = {0,180,0},
                width          = 500,
                height         = 20,
                font_size      = 100,
                color          = {0, 0, 0},
                font_color     = SectorDeckColors[k],
                tooltip        = 'Resupply Sector ' .. k
            }
            if k == 4 then
                params.tooltip = 'Resupply Sector 13'
            end
            SectorScriptZones[k].createButton(params)
        end
    end
end

resupplySector1 = function() resupplySector(1) end
resupplySector2 = function() resupplySector(2) end
resupplySector3 = function() resupplySector(3) end
resupplySector4 = function() resupplySector(4) end

function getSectorDeck(n)
    return find_pile(getObjectFromGUID(n))
end

-- Deal cards to refill the marketplace
function resupplySector(n)
    if ResupplySectorInProgress[n] == false then
        ResupplySectorInProgress[n] = true
        Wait.time(function() ResupplySectorInProgress[n] = false end, 2)

        local deck = SectorScriptZones[n]
        local topCard = find_pile(deck)

        checkSectors = {}
        local total = 6
        if (n == 4) then total = 3 end
        for k=1,total do
            local foundCard = find_pile(getObjectFromGUID(SectorDealZones[n][k]))
            local foundToken = find_token(getObjectFromGUID(SectorDealZones[n][k]))
            if (foundCard ~= nil) then
                table.insert(checkSectors, foundCard)
                local position = {SectorX[#checkSectors], 1, SectorY[n]}
                foundCard.setPositionSmooth(position)
                if (foundToken ~= nil) then
                    foundToken.setPositionSmooth(position)
                end
            end
        end

        for k=1,total do
            if (not checkSectors[k]) then
                if (topCard != nil) then
                    topCard.takeObject({flip=true, position = {SectorX[k], 1, SectorY[n]}})
                    for _, obj in ipairs(deck.getObjects()) do
                        if obj.tag == "Card" then
                            topCard.flip()
                            topCard.setPositionSmooth(checkSectors[k].getPosition())
                            break
                        end
                    end
                end
            end
        end
    end
end

function resetSupplySectorButtonHeights()
    local function moveUpZone(zoneNumber)
        local zone = getObjectFromGUID(Guids.Zones.Sectors[zoneNumber])
        local cardAmount = #((find_pile(zone)).getObjects())
        if cardAmount > 213 then cardAmount = 213 end
        local p = zone.getPosition()
        p[2] = 0.37 + (cardAmount)*0.01 - math.floor(cardAmount/27)/100
        zone.setPositionSmooth(p)
    end
    moveUpZone(1)
    moveUpZone(2)
    moveUpZone(3)
end


function supplyPilotToken()
    print('Supplying patrol ship')
    local order = {
        SectorDealZones[3][1], SectorDealZones[2][1], SectorDealZones[1][1],
        SectorDealZones[3][2], SectorDealZones[2][2], SectorDealZones[1][2],
        SectorDealZones[3][3], SectorDealZones[2][3], SectorDealZones[1][3],
        SectorDealZones[3][4], SectorDealZones[2][4], SectorDealZones[1][4],
        SectorDealZones[3][5], SectorDealZones[2][5], SectorDealZones[1][5],
        SectorDealZones[3][6], SectorDealZones[2][6], SectorDealZones[1][6]
    }
    local pilotBag = getObjectFromGUID(Guids.Expansions.Proxima.PilotBag)
    for n=1,18 do
        local zone = getObjectFromGUID(order[n])
        local token = find_token(zone)
        if (token == nil) then
            pilotBag.takeObject({
                position = zone.getPosition(),
                rotation = {x=0, y=180, z=0},
                smooth = true
            })
            return
        end
    end
end

function shuffleSectorDecks()
    local total = 3
    if settings.terraProxima == true then total = 4 end
    for k=1,total do
        deck = find_pile(SectorScriptZones[k])
        deck.shuffle()
    end
end

function resupplySectors()
    resupplySector1()
    resupplySector2()
    resupplySector3()
    if settings.terraProxima == true then resupplySector4() end
end