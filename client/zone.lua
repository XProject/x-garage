
local garageZones = {}
local garageBlips = {}

local function createGarageBlip(garageIndex)
    local garageData = Config.Locations[garageIndex]
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

local function onGarageInsideZoneEnter(data)
end

local function onGarageInsideZoneExit(data)
    
end

local function onGarageZoneEnter(data)
    local garageData = Config.Garages[data.garageIndex]
    
    if garageData.gates.outside then
        local sphereZone = lib.zone.sphere({
            coords = garageData.gates.outside.coords,
            radius = garageData.gates.outside.coords,
            debug = Config.Debug,
            onEnter = onGarageInsideZoneEnter,
            onExit = onGarageInsideZoneExit
        })
        garageZones[data.garageIndex].insideZones[1] = sphereZone
    else
        for i = 1, #garageData.gates do
            local sphereZone = lib.zone.sphere({
                coords = garageData.gates[i].outside.coords,
                radius = garageData.gates[i].outside.coords,
                debug = Config.Debug,
                onEnter = onGarageInsideZoneEnter,
                onExit = onGarageInsideZoneExit
            })
            garageZones[data.garageIndex].insideZones[i] = sphereZone
        end
    end
end

local function onGarageZoneExit(data)
    for i = 1, #garageZones[data.garageIndex].insideZones do
        onGarageInsideZoneExit(garageZones[data.garageIndex].insideZones[i])
        garageZones[data.garageIndex].insideZones[i]:remove()
        garageZones[data.garageIndex].insideZones[i] = nil
    end
end

local function setupGarage(garageIndex)
    local garageData = Config.Garages[garageIndex]
    if not garageData.points then return error("poly points are not set") end

    local polyZone = lib.zone.poly({
        points = garageData.points,
        thickness = garageData.thickness,
        debug = Config.Debug,
        onEnter = onGarageZoneEnter,
        onExit = onGarageZoneExit,
        garageIndex = garageIndex,
        -- garage = garageData,
    })
    garageZones[garageIndex] = {zone = polyZone, insideZones = {}}

    garageData.coords = polyZone.coords
    createGarageBlip(garageIndex)
end

local function initialize()
    SetTimeout(1000, function()
        print(("^7[^2%s^7] HAS LOADED ^5%s^7 GARAGES(S)"):format(Shared.currentResourceName:upper(), #Config.Locations))
        for index = 1, #Config.Garages do
            setupGarage(index)
        end
    end)
end