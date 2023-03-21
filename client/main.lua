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

AddStateBagChangeHandler(Shared.State.globalGarages, nil, function(bagName, _, value)
    Config.Garages = value
end)