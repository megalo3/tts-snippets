settings = {}

function onLoad(saveState)
    local loadedData = JSON.decode(saveState)
    if loadedData ~= nil then
        settings = loadedData
    end

    math.randomseed(os.time())
    -- Set items uninteractable
    for key, object in ipairs(getObjectsWithTag('noninteractable')) do
        object.interactable = false
    end
end

function onSave()
    return JSON.encode(settings)
end