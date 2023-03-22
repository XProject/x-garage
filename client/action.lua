local action = {}

local zone = lib.require("client.zone")

function action.onGarageRequestToEnter(data)
    local garageData = Config.Garages[data.garageIndex]

    lib.registerMenu({
        id = "outside_garage_menu",
        title = ("%s - %s"):format(Shared.currentResourceName, garageData.label),
        disableInput = true,
        canClose = true,
        options = {
            {
                label = ("Enter %s"):format(garageData.label),
                args = {menu = "outside_bought_garage_menu"}
            },
            {
                label = ("Buy %s"):format(garageData.label),
                args = {menu = "outside_unbought_garage_menu"}
            }
        },
        onClose = function(keyPressed)
            if keyPressed then
                zone.onGarageInsideZoneEnter(data)
            end
        end
    },
    function(_, _, args)
        if args.menu == "outside_bought_garage_menu" then
            action.openBoughtGarageMenu(data)
        elseif args.menu == "outside_unbought_garage_menu" then
            action.openUnboughtGarageMenu(data)
        end
    end)
end

function action.openBoughtGarageMenu(data)
    local garageData = Config.Garages[data.garageIndex]
    local interiorGarages = Config.Interiors[garageData.interior]
    local options = {}

    for i = 1, #interiorGarages do
        if true then -- check for ownership of the garage to show bought ones
            options[#options+1] = {
                label = ("Enter %s"):format(interiorGarages[i].label),
            }
        end
    end

    lib.registerMenu({
        id = "outside_garage_menu",
        title = ("%s - %s"):format(Shared.currentResourceName, garageData.label),
        disableInput = true,
        canClose = true,
        options = options,
        onClose = function(keyPressed)
            if keyPressed then
                action.onGarageRequestToEnter(data)
            end
        end
    },
    function(_, _, args)
        
    end)
end

function action.openUnboughtGarageMenu(data)
    local garageData = Config.Garages[data.garageIndex]
    local interiorGarages = Config.Interiors[garageData.interior]
    local options = {}

    for i = 1, #interiorGarages do
        if true then -- check for ownership of the garage to show un-bought ones
            options[#options+1] = {
                label = ("Buy %s"):format(interiorGarages[i].label),
                args = {name = garageData.interior, index = i}
            }
        end
    end

    lib.registerMenu({
        id = "outside_garage_menu",
        title = ("%s - %s"):format(Shared.currentResourceName, garageData.label),
        disableInput = true,
        canClose = true,
        options = options,
        onClose = function(keyPressed)
            if keyPressed then
                action.onGarageRequestToEnter(data)
            end
        end
    },
    function(_, _, args)
        local response = lib.callback.await(Shared.Callback.startGaragePreview, false, data.garageIndex, data.gateIndex, args)
        if response then
            -- player is now instanced and teleported to the interior entrance
            
        end
    end)
end