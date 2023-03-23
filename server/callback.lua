lib.callback.register(Shared.Callback.startGaragePreview, function(source, garageIndex)
    -- TODO: distance/zone check

    return exports["x-instance"]:addPlayerToInstance(source, "garage_preview")
end)

lib.callback.register(Shared.Callback.stopGaragePreview, function(source)
    -- TODO: distance/zone check

    if exports["x-instance"]:getPlayerInstance(source) ~= "garage_preview" then
        return false
    end

    return exports["x-instance"]:removePlayerFromInstance(source)
end)

lib.callback.register(Shared.Callback.buyGarage, function(source, garageIndex, garageInteriorIndex, selectedDecors)
    -- TODO: distance/zone check
    -- TODO: check if the garage is not already bought by source

    local garageData = Config.Garages[garageIndex]
    local interiorGarages = Config.Interiors[garageData.interior]
    local garagePrice = garageData.price

    if interiorGarages[garageInteriorIndex].decors then
        for decorKey, decorData in pairs(interiorGarages[garageInteriorIndex].decors) do
            if not selectedDecors[decorKey] then return false, "decors_data_mismatch" end
            garagePrice += decorData[selectedDecors[decorKey]]
        end
    end

    -- TODO: check if source has enough money

    return true, "successful"
end)