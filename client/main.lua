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

---@diagnostic disable-next-line: param-type-mismatch
AddStateBagChangeHandler(Shared.State.globalGarages, nil, function(bagName, _, value)
    Config.Garages = value
end)

function Teleport(entity, coords)
    FreezeEntityPosition(entity, true)
    NetworkFadeOutEntity(entity, false, false)

    ---@diagnostic disable-next-line: missing-parameter
    SetEntityCoords(entity, coords.x, coords.y, coords.z)
    SetEntityHeading(entity, coords.w)

    while not HasCollisionLoadedAroundEntity(entity) do
        RequestCollisionAtCoord(coords.x, coords.y, coords.z)
        Wait(1000)
    end

    NetworkFadeInEntity(entity, false)
    FreezeEntityPosition(entity, false)
end

function Spinner(state, string)
    if state then
        AddTextEntry(string, string)
        BeginTextCommandBusyspinnerOn(string)
        EndTextCommandBusyspinnerOn(4)
    else
        BusyspinnerOff()
    end
end

function StartGaragePreview(garageIndex, interiorIndex)
    local response = lib.callback.await(Shared.Callback.startGaragePreview, 1000)
    if response then
        coordsBeforeGaragePreview = cache.coords
        vehicleBeforeGaragePreview = cache.seat == -1 and cache.vehicle
        local garageInterior = Config.Garages[garageIndex].interior
        local garageCoords = Config.Interiors[garageInterior][interiorIndex].coords
        Teleport(cache.ped, garageCoords)
    end
    return response
end

function StopGaragePreview()
    local response = lib.callback.await(Shared.Callback.stopGaragePreview, 1000)
    if response then
        Teleport(cache.ped, coordsBeforeGaragePreview)
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

function FadeScreen(state, duration)
    duration = duration or 1000
    if state then
        Spinner(true, "Loading")
        DoScreenFadeOut(duration)
    else
        Spinner(false)
        DoScreenFadeIn(duration)
    end
    Wait(duration)
end

local function onResourceStop(resource)
    if resource ~= Shared.currentResourceName then return end
    FadeScreen(false, duration)
end

AddEventHandler("onResourceStop", onResourceStop)
AddEventHandler("onClientResourceStop", onResourceStop)