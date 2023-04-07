local garages = {}

local function syncGlobalStates()
    GlobalState:set(Shared.State.globalGarages, Config.Garages, true)
end

CreateThread(syncGlobalStates)

function GetIdentifier(source)
    return GetPlayerIdentifierByType(source, "license")
end

function HasGarage(source, garageIndex, garageInterior, garageInteriorIndex)
    local owner = GetIdentifier(source)
    local garage = garageIndex
    local interior = garageInterior
    local interior_index = garageInteriorIndex

    local result = MySQL.prepare.await("SELECT id FROM player_garages WHERE owner = ? AND garage = ? AND interior = ? AND interior_index = ?", {owner, garage, interior, interior_index})
    return result ~= nil
end

function GetGarageDecors(source, garageIndex, garageInterior, garageInteriorIndex)
    local owner = GetIdentifier(source)
    local garage = garageIndex
    local interior = garageInterior
    local interior_index = garageInteriorIndex

    local result = MySQL.scalar.await("SELECT decors FROM player_garages WHERE owner = ? AND garage = ? AND interior = ? AND interior_index = ?", {owner, garage, interior, interior_index})
    return result and json.decode(result) or {}
end

function OwnGarage(source, garageIndex, garageInterior, garageInteriorIndex, selectedDecors)
    local owner = GetIdentifier(source)
    local garage = garageIndex
    local interior = garageInterior
    local interior_index = garageInteriorIndex
    local decors = json.encode(selectedDecors)
    local vehicles = json.encode({})

    local id = MySQL.insert.await("INSERT INTO player_garages (owner, garage, interior, interior_index, decors, vehicles) VALUES (?, ?, ?, ?, ?, ?)", {owner, garage, interior, interior_index, decors, vehicles})
    return id
end

local function onResourceStart(resource)
    if resource ~= Shared.currentResourceName then return end
    exports["x-instance"]:addInstanceType("garage_preview")
end

AddEventHandler("onResourceStart", onResourceStart)
AddEventHandler("onServerResourceStart", onResourceStart)

local function onResourceStop(resource)
    if resource ~= Shared.currentResourceName then return end
    exports["x-instance"]:removeInstanceType("garage_preview", true)
end

AddEventHandler("onResourceStop", onResourceStop)
AddEventHandler("onServerResourceStop", onResourceStop)