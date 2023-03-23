local garages = {}

local function syncGlobalStates()
    GlobalState:set(Shared.State.globalGarages, Config.Garages, true)
    GlobalState:set(Shared.State.globalInteriors, Config.Interiors, true)
end

CreateThread(syncGlobalStates)