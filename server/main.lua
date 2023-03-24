local garages = {}

local function syncGlobalStates()
    GlobalState:set(Shared.State.globalGarages, Config.Garages, true)
end

CreateThread(syncGlobalStates)

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