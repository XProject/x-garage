local garages = {}

local function syncGlobalStates()
    GlobalState:set(Shared.State.globalGarages, Config.Garages, true)
end

CreateThread(syncGlobalStates)