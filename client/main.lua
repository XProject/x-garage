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
local insideGarage

local duiObj = CreateDui("https://simg.nicepng.com/png/small/234-2340201_exit-sign-wayfinding-fire-door-emergency-comments-exit.png", 256, 256)
local duiHandle = GetDuiHandle(duiObj)
local dict = CreateRuntimeTxd("markerDict") -- dictionary name
local txd = CreateRuntimeTextureFromDuiHandle(dict, "markerTxt", duiHandle) -- texture name

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

function HasGarage(garageIndex, garageInteriorIndex)
    return lib.callback.await(Shared.Callback.hasGarage, false, garageIndex, garageInteriorIndex)
end

function GetGarageDecors(garageIndex, garageInteriorIndex)
    return lib.callback.await(Shared.Callback.getGarageDecors, 1000, garageIndex, garageInteriorIndex)
end

function BuyGarage(garageIndex, garageInteriorIndex, selectedDecors)
    return lib.callback.await(Shared.Callback.buyGarage, 1000, garageIndex, garageInteriorIndex, selectedDecors)
end

function FadeScreen(state, duration)
    duration = duration or 1000
    if state then
        DoScreenFadeOut(duration)
        Spinner(true, "Loading")
    else
        DoScreenFadeIn(duration)
        Spinner(false)
    end
    Wait(duration)
end

function EnterOwnGarage(garageIndex, garageInteriorIndex, selectedDecors)
    FadeScreen(true)
    if not StartGaragePreview(garageIndex, garageInteriorIndex) then -- TODO: change this since it adds player to preview_garage instance
        FadeScreen(false)
        return
    end

    local garageData = Config.Garages[garageIndex]
    local interiorData = Config.Interiors[garageData.interior][garageInteriorIndex]
    insideGarage = ("%s:%s"):format(garageIndex, garageInteriorIndex)

    if type(interiorData.object) == "string" then
        interiorData.object = exports["bob74_ipl"][interiorData.object]()
    end

    local interiorObject = interiorData.object

    interiorData.func.clear(interiorObject)
    interiorData.func.loadDefault(interiorObject)

    for decorKey, decorName in pairs(selectedDecors) do
        interiorData.decors[decorKey].set(interiorObject, decorName)
    end

    print(dumpTable(selectedDecors))

    FadeScreen(false)

    CreateThread(function()
        local _insideGarage = insideGarage
        while _insideGarage == insideGarage do
            if IsPauseMenuActive() then
                if IsMinimapInInterior() then
                    HideMinimapExteriorMapThisFrame()
                else
                    HideMinimapInteriorMapThisFrame()
                    SetPlayerBlipPositionThisFrame(interiorData.coords.x, interiorData.coords.y)
                end
            end

            DrawMarker(9, interiorData.coords.x, interiorData.coords.y, interiorData.coords.z, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255, true, true, 2, false, "markerDict", "markerTxt", false)

            if #(cache.coords - vector3(interiorData.coords.x, interiorData.coords.y, interiorData.coords.z)) <= 2 then
                if IsControlJustReleased(0, 38) then
                    FadeScreen(true)
                    while IsScreenFadedOut() do
                        if StopGaragePreview() then
                            break
                        end
                        Wait(1000)
                    end
                    Teleport(cache.ped, garageData.outside.coords)
                    FadeScreen(false)
                    insideGarage = nil
                    break
                end
            end
            Wait(0)
        end
    end)
end

local function onResourceStop(resource)
    if resource ~= Shared.currentResourceName then return end
    FadeScreen(false, duration)
end

AddEventHandler("onResourceStop", onResourceStop)
AddEventHandler("onClientResourceStop", onResourceStop)