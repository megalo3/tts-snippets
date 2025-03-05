function createBlightMountains(o, c, a) createBlight('Mountains') end
function createBlightCastle(o, c, a) createBlight('Castle') end
function createBlightVillage(o, c, a) createBlight('Village') end
function createBlightSwamp(o, c, a) createBlight('Swamp') end
function createBlightForest(o, c, a) createBlight('Forest') end
function createBlightRuins(o, c, a) createBlight('Ruins') end
function createBlightMonastery(o, c, a) createBlight('Monastery') end

function getItemMountains(o, c, a) getItem('Mountains',c) end
function getItemCastle(o, c, a) getItem('Castle',c) end
function getItemVillage(o, c, a) getItem('Village',c) end
function getItemSwamp(o, c, a) getItem('Swamp',c) end
function getItemForest(o, c, a) getItem('Forest',c) end
function getItemRuins(o, c, a) getItem('Ruins',c) end
function getItemMonastery(o, c, a) getItem('Monastery',c) end

StartingBlights = {0,0,0,0,0,0}
function createStartingBlights(n)
    if n == 0 then return end
    StartingBlights = {0,0,0,0,0,0}
    tryCreateStartingBlights(n)
end

function tryCreateStartingBlights(n)
    drawCard({ Target = 'Discard', Type = 'Map' })

    Wait.time(function()
        local guid = getTopMapDiscardGuid()
        local blightInfo = getBlightInfoFromGUID(guid)
        local retry = false

        for index, location in ipairs(Locations) do
            if location ~= 'Monastery' then
                if StartingBlights[index] < n then
                    local blightName = blightInfo[location][1]
                    local deployedBlightMessage = deployBlight(blightName, location, StartingBlights[index])
                    if deployedBlightMessage ~= false then
                        print(deployedBlightMessage)
                        StartingBlights[index] = StartingBlights[index] + 1
                    end
                end
                if StartingBlights[index] < n then
                    retry = true
                end
            end
        end

        if retry == true then
            tryCreateStartingBlights(n)
        end
    end, 1.5)
end

function getMapCardInfo()
    local guid = getTopMapDiscardGuid()
    if guid == false then return end
    return getBlightInfoFromGUID(guid)
end

function getItem(location, color)
    local blightInfo = getMapCardInfo()
    if blightInfo == nil then
        -- print('No map card has been played.')
        return
    end
    local itemName = blightInfo[location][2]
    local otherSearchResults = {'Epiphany', 'Forgotten Shrine', 'Inspiration', 'Stardust', 'Supply Cache'}
    if table.inTable(otherSearchResults, itemName) then
        printToAll("You've discovered a " .. itemName .. " in the " .. location .. ". It takes effect immediately.", stringColorToRGB(color))
        return
    end
    printToAll("You've discovered a " .. itemName .. " in the " .. location .. ".", stringColorToRGB(color))
    dealItem({ ItemName = itemName, Color = color})
end


function createBlight(location)
    local guid = getTopMapDiscardGuid()
    if guid == false then return end

    -- Make sure there aren't already 4 blights
    local blightCount = countBlightsInLocation(location)
    if blightCount >= 4 then
        printToAll('The ' .. location .. ' already has 4 blights. Creating a blight at the Monastery instead. If the Monastery ever has more than 4 blights, the heroes immediately lose the game.', stringColorToRGB('Orange'))
        location = 'Monastery'
        blightCount = countBlightsInLocation('Monastery')
    end
    -- If so, the blight location is the Monastery
    local blightInfo = getBlightInfoFromGUID(guid)
    local blightName = blightInfo[location][1]
    local deployedBlightMessage = deployBlight(blightName, location, blightCount)
    if deployedBlightMessage == false then
        return false
    end
    print(deployedBlightMessage)
    return true
end

function getTopMapDiscardGuid()
    local card = getDiscardDeckTopCardInfo('Map')
    if card == nil then
        print('No map card has been played.')
        return false
    end
    return card.guid
end

function getBlightInfoFromGUID(guid)
    for _, info in ipairs(Maps) do
        if (info.GUID == guid) then
            return info
        end
    end
end

function deployBlight(blightName, location, blightCount)
    local position = {LocationPositions[location][1] + blightCount * 1.5, 2, LocationPositions[location][3]}
    local BlightZone = getObjectsWithAllTags({'Zone', 'Blight', 'Draw'})[1]
    for index, tileStack in ipairs(BlightZone.getObjects()) do
        if (tileStack.getName() == blightName) then
            if (tileStack.name == 'Custom_Tile_Stack') then
                tileStack.takeObject({position = position})
            else
                tileStack.setPositionSmooth(position)
            end
            return 'Adding a ' .. blightName .. ' blight to the ' .. location .. '.';
        end
    end
    printToAll('No more ' .. blightName .. ' tokens available.', stringColorToRGB('Yellow'))
    return false
end

function blightCount(blightName)
    local count = 0
    local zone = getObjectsWithAllTags({'Zone', 'Board', 'Blight'})[1]
    for _, blight in ipairs(zone.getObjects()) do
        if blight.hasTag(blightName) then count = count + 1 end
    end
    return count
end
