function hideDestiny()
    local items = {
        getObjectFromGUID(Guids.Text.Destiny[1]),
        getObjectFromGUID(Guids.Text.Destiny[2]),
        getObjectFromGUID(Guids.Text.Destiny[3]),
        getObjectFromGUID(Guids.Text.Destiny[4]),
        table.unpack(getObjectsWithAllTags({'Destiny'}))
    }
    for _, item in ipairs(items) do
        destroyObject(item)
    end
    getObjectsWithAllTags({'unused'})[1].putObject(getObjectFromGUID(Guids.DestinyDie))
end

function returnDestiny()
    getObjectFromGUID(Guids.DestinyDie).setPositionSmooth(Positions.Destiny)
end