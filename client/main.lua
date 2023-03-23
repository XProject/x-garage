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
Config.Interiors = GlobalState[Shared.State.globalInteriors]
local coordsBeforeGaragePreview
local vehicleBeforeGaragePreview

---@diagnostic disable-next-line: param-type-mismatch
AddStateBagChangeHandler(Shared.State.globalGarages, nil, function(bagName, _, value)
    Config.Garages = value
end)

---@diagnostic disable-next-line: param-type-mismatch
AddStateBagChangeHandler(Shared.State.globalInteriors, nil, function(bagName, _, value)
    Config.Interiors = value
end)

function StartGaragePreview(garageIndex, gateIndex)
    local response = lib.callback.await(Shared.Callback.startGaragePreview, 1000, garageIndex, gateIndex)
    if response then
        coordsBeforeGaragePreview = cache.coords
        --[[vehicleBeforeGaragePreview = cache.seat == -1 and cache.vehicle
        local garageCoords = Config.Garages[garageIndex]?.gates?[gateIndex]?.inside

        ---@diagnostic disable-next-line: missing-parameter
        SetEntityCoords(cache.ped, garageCoords.x, garageCoords.y, garageCoords.z)
        SetEntityHeading(cache.ped, garageCoords.w)]]
    end
    return response
end

function StopGaragePreview()
    local response = lib.callback.await(Shared.Callback.stopGaragePreview, 1000)
    if response then
        ---@diagnostic disable-next-line: missing-parameter
        SetEntityCoords(cache.ped, coordsBeforeGaragePreview.x, coordsBeforeGaragePreview.y, coordsBeforeGaragePreview.z)
        if vehicleBeforeGaragePreview then
            SetPedIntoVehicle(cache.ped, vehicleBeforeGaragePreview, -1)
        end

        coordsBeforeGaragePreview = nil
        vehicleBeforeGaragePreview = nil
    end
    return response
end

function BuyGarage(garageIndex, garageInteriorIndex, selectedDecors)
    return lib.callback.await(Shared.Callback.buyGarage, 1000, garageIndex, garageInteriorIndex, selectedDecors)
end