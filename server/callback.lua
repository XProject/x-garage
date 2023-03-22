lib.callback.register(Shared.Callback.startGaragePreview, function(source, garageIndex, gateIndex)
    local garageCoords = Config.Garages[garageIndex]?.gates?[gateIndex]?.inside
    if garageCoords return false end

    if not exports["x-instance"]:doesInstanceExist("garage_preview") then
        exports["x-instance"]:addInstanceType("garage_preview")
    end

    local response = exports["x-instance"]:addPlayerToInstance(source, "garage_preview")
    if not response then return false end

    local playerPed = GetPlayerPed(source)
    SetEntityCoords(playerPed, table.unpack(garageCoords))
    
    return true
end)