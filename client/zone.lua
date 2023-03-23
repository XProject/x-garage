
local zone = {}
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

function zone.onGarageInsideZoneEnter(data)
    local garageData = Config.Garages[data.garageIndex]
    garageZones[data.garageIndex].insideZones[data.gateIndex].inZone = true

    CreateThread(function()
        lib.showTextUI(("[E] - Open %s Menu"):format(garageData.label))
        while garageZones[data.garageIndex].insideZones[data.gateIndex].inZone do
            if IsControlJustReleased(0, 38) then
                Action.onGarageRequestToEnter(data)
                break
            end
            Wait(0)
        end
        lib.hideTextUI()
    end)
end

function zone.onGarageInsideZoneExit(data)
    garageZones[data.garageIndex].insideZones[data.gateIndex].inZone = false
end

function zone.onGarageZoneEnter(data)
    local garageData = Config.Garages[data.garageIndex]

    for i = 1, #garageData.gates do
        local sphereZone = lib.zones.sphere({
            coords = garageData.gates[i].outside.coords,
            -- radius = garageData.gates[i].outside.coords,
            debug = Config.Debug,
            onEnter = zone.onGarageInsideZoneEnter,
            onExit = zone.onGarageInsideZoneExit,
            garageIndex = data.garageIndex,
            gateIndex = i
        })
        garageZones[data.garageIndex].insideZones[i] = {zone = sphereZone, inZone = false}
    end
end

function zone.onGarageZoneExit(data)
    for i = 1, #garageZones[data.garageIndex].insideZones do
        zone.onGarageInsideZoneExit(garageZones[data.garageIndex].insideZones[i].zone)
        garageZones[data.garageIndex].insideZones[i].zone:remove()
        garageZones[data.garageIndex].insideZones[i] = nil
    end
end

function zone.setupGarage(garageIndex)
    local garageData = Config.Garages[garageIndex]
    if not garageData.points then return error("poly points are not set") end

    local polyZone = lib.zones.poly({
        points = garageData.points,
        thickness = garageData.points_thickness,
        debug = Config.Debug,
        onEnter = zone.onGarageZoneEnter,
        onExit = zone.onGarageZoneExit,
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
            zone.setupGarage(index)
        end
    end)
end

initialize()

return zone