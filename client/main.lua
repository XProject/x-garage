--[[
-- This is how rockstar fakes player blip location while in an ipl interior
CreateThread(function()
    while true do
        if IsPauseMenuActive() then
            if IsMinimapInInterior() then
                HideMinimapExteriorMapThisFrame()
            else
                HideMinimapInteriorMapThisFrame()
                SetPlayerBlipPositionThisFrame(-191.0133, -579.1428)
            end
        end
        Wait(0)
    end
end)
]]

Config.Garages = GlobalState[Shared.State.globalGarages]
local coordsBeforeGaragePreview
local vehicleBeforeGaragePreview

AddStateBagChangeHandler(Shared.State.globalGarages, nil, function(bagName, _, value)
    Config.Garages = value
end)

function startGaragePreview(garageIndex, gateIndex)
    local response = lib.callback.await(Shared.Callback.startGaragePreview, false, garageIndex, gateIndex)
    if response then
        coordsBeforeGaragePreview = cache.coords
        vehicleBeforeGaragePreview = cache.seat == -1 and cache.vehicle
        local garageCoords = Config.Garages[garageIndex]?.gates?[gateIndex]?.inside
        
        SetEntityCoords(cache.ped, garageCoords.x, garageCoords.y, garageCoords.z)
        SetEntityHeading(cache.ped, garageCoords.w)
    end
    return response
end

function stopGaragePreview()
    local response = lib.callback.await(Shared.Callback.stopGaragePreview, false)
    if response then
        SetEntityCoords(cache.ped, garageCoords.x, garageCoords.y, garageCoords.z)
        if vehicleBeforeGaragePreview then
            SetPedIntoVehicle(cache.ped, vehicleBeforeGaragePreview, -1)
        end

        coordsBeforeGaragePreview = nil
        vehicleBeforeGaragePreview = nil
    end
    return response
end