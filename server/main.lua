local garages = {}

local function syncGlobalStates()
    GlobalState:set(Shared.State.globalGarages, garages, true)
end