function hideDestiny()
    local items = {
        getObjectFromGUID('975275'),
        getObjectFromGUID('48b274'),
        getObjectFromGUID('0e1960'),
        getObjectFromGUID('50469c'),
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