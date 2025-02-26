function onObjectDrop(colorName, obj)
    if (obj.type == 'Card' or obj.type == 'Tile') then
        obj.setVar('droppedBy', colorName)
    end
end

function onObjectLeaveContainer(container, leave_object)
    if leave_object.type == 'Card' then leave_object.tooltip = false end
end

function AutoDeployOnObjectEnterScriptingZone(obj)
    -- Find the color that dropped this card
    local playerColor = obj.getVar('droppedBy')
    if (isPlayerColor(playerColor) == false) then return end
    if obj.type == 'Card' then
        autoDeployCard({card = obj, color = playerColor})
    end
    if obj.type == 'Tile' then
        autoDeployTile(obj, playerColor)
    end
end

function autoDeployTile(obj, color)
    local p = Positions.Starters[color]
    obj.setPositionSmooth({p[1] + 10, p[2], p[3]})
end

function autoDeployCard(parameters)
    -- parameters: card, color
    for k, rotationValue in ipairs(parameters.card.getRotationValues()) do
        -- Sector number
        local sectorNumber = rotationValue.value
        if (string.find(sectorNumber, '+')) then
            print('A ' .. sectorNumber .. ' card must be manually deployed.')
            return
        end

        sectorNumber = tonumber(sectorNumber)

        local sectorPileObject = getObjectFromGUID(Guids.PlayerBoards[parameters.color][sectorNumber])
        local deployGuid = Guids.DeploySections[parameters.color][sectorNumber]

        -- We want to deploy a sector 13 card immediately
        if (sectorNumber == 13) then
            local right = Positions.Cards[parameters.color].right + Positions.SectorXIncrements[sectorNumber]
            parameters.card.setPositionSmooth({right, 2, Positions.Cards[parameters.color].orig}, false, false)
            parameters.card.setRotationSmooth({0,180,0})
            local deployInput = {
                sector = sectorPileObject,
                sectorNumber = sectorNumber,
                deployGuid = deployGuid,
                color = parameters.color
            }
            Wait.time(function() deploy(deployInput) end, 1.3)
            return
        end

        local deployInput = {
            sector = sectorPileObject,
            sectorNumber = sectorNumber,
            deployGuid = deployGuid,
            color = parameters.color
        }
        deploy(deployInput)

        local right = Positions.Cards[parameters.color].right + Positions.SectorXIncrements[sectorNumber]
        parameters.card.setPositionSmooth({right, 2, Positions.Cards[parameters.color].orig}, false, false)
        parameters.card.setRotationSmooth({0,180,0})

    end
end