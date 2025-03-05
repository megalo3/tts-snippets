Blights = {
    Starting = {0,0,0,0,0,0},

    createStartingBlights = function(n)
        if n == 0 then return end
        Blights.Starting = {0,0,0,0,0,0}
        Blights.tryCreateStartingBlights(n)
    end,

    tryCreateStartingBlights =     function(n)
        Utility.Draw.Card({ Target = 'Discard', Type = 'Map' })

        Wait.time(function()
            local guid = Blights.getTopMapDiscardGuid()
            local blightInfo = Blights.getBlightInfoFromGUID(guid)
            local retry = false

            for index, location in ipairs(Locations) do
                if location ~= 'Monastery' then
                    if Blights.Starting[index] < n then
                        local blightName = blightInfo[location][1]
                        local deployedBlightMessage = Blights.deployBlightToLocation(blightName, location, Blights.Starting[index])
                        if deployedBlightMessage ~= false then
                            print(deployedBlightMessage)
                            Blights.Starting[index] = Blights.Starting[index] + 1
                        end
                    end
                    if Blights.Starting[index] < n then
                        retry = true
                    end
                end
            end

            if retry == true then
                Blights.tryCreateStartingBlights(n)
            end
        end, 1.5)
    end,

    getMapCardInfo = function()
        local guid = Blights.getTopMapDiscardGuid()
        if guid == false then return end
        return Blights.getBlightInfoFromGUID(guid)
    end,

    getItem = function(location, color)
        local blightInfo = Blights.getMapCardInfo()
        if blightInfo == nil then
            return
        end
        local itemName = blightInfo[location][2]
        local otherSearchResults = {'Epiphany', 'Forgotten Shrine', 'Inspiration', 'Stardust', 'Supply Cache'}
        if table.inTable(otherSearchResults, itemName) then
            printToAll("You've discovered a " .. itemName .. " in the " .. location .. ". It takes effect immediately.", stringColorToRGB(color))
            return
        end
        printToAll("You've discovered a " .. itemName .. " in the " .. location .. ".", stringColorToRGB(color))
        Utility.Draw.Item({ ItemName = itemName, Color = color})
    end,

    createBlight = function(location)
        local guid = Blights.getTopMapDiscardGuid()
        if guid == false then return end

        if FailedBlightDrawAttempt == 0 then
            local info = Blights.getMapCardInfo()
            necroAddQuest(info)
        end

        -- Make sure there aren't already 4 blights
        local blightCount = countBlightsInLocation(location)
        if blightCount >= 4 then
            printToAll('The ' .. location .. ' already has 4 blights. Creating a blight at the Monastery instead. If the Monastery ever has more than 4 blights, the heroes immediately lose the game.', stringColorToRGB('Orange'))
            location = 'Monastery'
            blightCount = countBlightsInLocation('Monastery')
        end
        -- If so, the blight location is the Monastery
        local blightInfo = Blights.getBlightInfoFromGUID(guid)
        local blightName = blightInfo[location][1]
        local deployedBlightMessage = Blights.deployBlightToLocation(blightName, location, blightCount)
        if deployedBlightMessage == false then
            return false
        end
        print(deployedBlightMessage)
        return true
    end,

    getTopMapDiscardGuid = function()
        local card = Utility.getDiscardDeckTopCardInfo('Map')
        if card == nil then
            print('No map card has been played.')
            return false
        end
        return card.guid
    end,

    getBlightInfoFromGUID = function(guid)
        for _, info in ipairs(Maps) do
            if (info.GUID == guid) then
                return info
            end
        end
    end,

    deployBlightToLocation = function(blightName, location, blightCount)
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
    end,

    count = function(blightName)
        local count = 0
        local zone = getObjectsWithAllTags({'Zone', 'Board', 'Blight'})[1]
        for _, blight in ipairs(zone.getObjects()) do
            if blight.hasTag(blightName) then count = count + 1 end
        end
        return count
    end,

    returnBlight = function(object)
        local position = Blights.findSnapLocation(object.getName())
        local toWorld = getBlightBoard().positionToWorld(position)
        object.setPositionSmooth({toWorld[1], 3, toWorld[3]})
        object.setRotationSmooth({0,180,0})
    end,

    findSnapLocation = function(name)
        for _, snap in ipairs(getBlightBoard().getSnapPoints()) do
            if snap.tags[1] == name then
                return snap.position
            end
        end
    end
}