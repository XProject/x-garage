lib.callback.register(Shared.Callback.startGaragePreview, function(source, garageIndex, gateIndex)
    local garageCoords = Config.Garages[garageIndex]?.gates?[gateIndex]?.inside
    if garageCoords return false end

    -- TODO: distance check

    if not exports["x-instance"]:doesInstanceExist("garage_preview") then
        exports["x-instance"]:addInstanceType("garage_preview")
    end

    return exports["x-instance"]:addPlayerToInstance(source, "garage_preview")
end)