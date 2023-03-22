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
    
    lib.showMenu("outside_garage_menu")
end

function action.openBoughtGarageMenu(data)
    local garageData = Config.Garages[data.garageIndex]
    local interiorGarages = Config.Interiors[garageData.interior]
    local options = {}

    for i = 1, #interiorGarages do
        if true then -- TODO: check for ownership of the garage to show bought ones
            options[#options+1] = {
                label = ("Enter %s"):format(interiorGarages[i].label),
            }
        end
    end

    lib.registerMenu({
        id = "outside_bought_garage_menu",
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

    lib.showMenu("outside_bought_garage_menu")
end

function action.openUnboughtGarageMenu(data)
    local garageData = Config.Garages[data.garageIndex]
    local interiorGarages = Config.Interiors[garageData.interior]
    local options = {}

    for i = 1, #interiorGarages do
        if true then -- TODO: check for ownership of the garage to show un-bought ones
            options[#options+1] = {
                label = ("Buy %s"):format(interiorGarages[i].label),
                args = {name = garageData.interior, index = i}
            }
        end
    end

    lib.registerMenu({
        id = "outside_unbought_garage_menu",
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
        local response = startGaragePreview(data.garageIndex, data.gateIndex)
        if response then
            -- player is now instanced and teleported to the interior entrance
            local index = args.index
            if type(interiorGarages[index].object) == "string" then
                interiorGarages[index].object = exports["bob74_ipl"][interiorGarages[index].object]()
            end

            local interiorObject = interiorGarages[index].object

            interiorGarages[index].func.clear(interiorObject)
            interiorGarages[index].func.loadDefault(interiorObject)

            action.onGaragePreview(data, index)
        end
    end)

    lib.showMenu("outside_unbought_garage_menu")
end

function action.onGaragePreview(data, interiorGarageIndex)
    local garageData = Config.Garages[data.garageIndex]
    local interiorGarages = Config.Interiors[garageData.interior]
    local options = {}
    local optionsCount = 0
    local selectedDecors = {}
    local garagePrice = garageData.price

    if interiorGarages[interiorGarageIndex].decors then
        for decorKey, decorData in pairs(interiorGarages[interiorGarageIndex].decors) do
            local values = {}
            local valuesCount = 0
            
            for decorName in pairs(decorData) do
                valuesCount += 1
                values[valuesCount] = decorName
            end

            optionsCount += 1
            options[optionsCount] = {
                label = decorKey,
                values = values,
                defaultIndex = 1
            }

            selectedDecors[decorKey] = {decorName = values[1], decorPrice = decorData[values[1]]}
            garagePrice += selectedDecors[decorKey].decorPrice
        end
    end

    optionsCount += 1
    options[optionsCount] = {
        label = "Buy",
        description = ("Buy this garage for $%s"):format(garagePrice)
        args = {price = garagePrice}
    }
    
    lib.registerMenu({
        id = "preview_garage",
        title = ("%s - %s"):format(Shared.currentResourceName, interiorGarages[interiorGarageIndex].label),
        disableInput = true,
        canClose = true,
        options = options,
        onSideScroll = function(selected, scrollIndex, args)
            -- modify price
        end,
        onClose = function(keyPressed)
            if keyPressed then
                stopGaragePreview()
                action.openUnboughtGarageMenu(data)
            end
        end
    },
    function(_, _, args)

    end)

    lib.showMenu("preview_garage")
end