
Zone = {}
local garageZones = {}
local garageBlips = {}

local function createGarageBlip(garageIndex)
    local garageData = Config.Garages[garageIndex]
    if not garageData.blip or not garageData.blip.active then return end
    local blip = AddBlipForCoord(garageData.coords.x, garageData.coords.y, garageData.coords.z)
    SetBlipSprite(blip, garageData.blip.type)
    SetBlipScale(blip, garageData.blip.size)
    SetBlipColour(blip, garageData.blip.color)
    SetBlipAsShortRange(blip, true)
    AddTextEntry(garageData.label, garageData.label)
    BeginTextCommandSetBlipName(garageData.label)
    EndTextCommandSetBlipName(blip)
    garageBlips[garageIndex] = blip
end

function Zone.onGarageInsideZoneEnter(data)
    if garageZones[data.garageIndex].insideZones[data.gateIndex].inZone then return end
    garageZones[data.garageIndex].insideZones[data.gateIndex].inZone = true

    CreateThread(function()
        local garageData = Config.Garages[data.garageIndex]
        lib.showTextUI(("[E] - Open %s Menu"):format(garageData.label))

        while garageZones[data.garageIndex].insideZones[data.gateIndex].inZone do
            if IsControlJustReleased(0, 38) then
                if not cache.seat or cache.seat == -1 then
                    Action.onGarageRequestToEnter(data)
                    break
                else
                    lib.notify({title = "You need to be on foot or the driver"})
                end
            end
            Wait(0)
        end

        lib.hideTextUI()
        Zone.onGarageInsideZoneExit(data)
    end)
end

function Zone.onGarageInsideZoneExit(data)
    garageZones[data.garageIndex].insideZones[data.gateIndex].inZone = false
end

function Zone.onGarageZoneEnter(data)
    local garageData = Config.Garages[data.garageIndex]

    for i = 1, #garageData.gates do
        local sphereZone = lib.zones.sphere({
            coords = garageData.gates[i].outside.coords,
            -- radius = garageData.gates[i].outside.coords,
            debug = Config.Debug,
            onEnter = Zone.onGarageInsideZoneEnter,
            onExit = Zone.onGarageInsideZoneExit,
            garageIndex = data.garageIndex,
            gateIndex = i
        })
        garageZones[data.garageIndex].insideZones[i] = {zone = sphereZone, inZone = false}
    end
end

function Zone.onGarageZoneExit(data)
    for i = 1, #garageZones[data.garageIndex].insideZones do
        Zone.onGarageInsideZoneExit(garageZones[data.garageIndex].insideZones[i].Zone)
        garageZones[data.garageIndex].insideZones[i].zone:remove()
        garageZones[data.garageIndex].insideZones[i] = nil
    end
end

function Zone.setupGarage(garageIndex)
    local garageData = Config.Garages[garageIndex]
    if not garageData.points then return error("poly points are not set") end

    local polyZone = lib.zones.poly({
        points = garageData.points,
        thickness = garageData.points_thickness,
        debug = Config.Debug,
        onEnter = Zone.onGarageZoneEnter,
        onExit = Zone.onGarageZoneExit,
        garageIndex = garageIndex,
    })
    garageZones[garageIndex] = {zone = polyZone, insideZones = {}}

    garageData.coords = polyZone.coords
    createGarageBlip(garageIndex)
end

local function initialize()
    SetTimeout(1000, function()
        print(("^7[^2%s^7] HAS LOADED ^5%s^7 GARAGES(S)"):format(Shared.currentResourceName:upper(), #Config.Garages))
        for index = 1, #Config.Garages do
            Zone.setupGarage(index)
        end
    end)
end

initialize()