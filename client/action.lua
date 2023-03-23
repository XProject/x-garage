Action = {}

local zone = lib.require("client.zone")

function Action.onGarageRequestToEnter(data)
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
            Action.openBoughtGarageMenu(data)
        elseif args.menu == "outside_unbought_garage_menu" then
            Action.openUnboughtGarageMenu(data)
        end
    end)

    lib.showMenu("outside_garage_menu")
end

function Action.openBoughtGarageMenu(data)
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
                Action.onGarageRequestToEnter(data)
            end
        end
    },
    function(_, _, args)

    end)

    lib.showMenu("outside_bought_garage_menu")
end

function Action.openUnboughtGarageMenu(data)
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
                Action.onGarageRequestToEnter(data)
            end
        end
    },
    function(_, _, args)
        local response = StartGaragePreview(data.garageIndex, data.gateIndex)
        if response then
            -- player is now instanced and teleported to the interior entrance
            local index = args.index
            if type(interiorGarages[index].object) == "string" then
                interiorGarages[index].object = exports["bob74_ipl"][interiorGarages[index].object]()
            end

            local interiorObject = interiorGarages[index].object

            interiorGarages[index].func.clear(interiorObject)
            interiorGarages[index].func.loadDefault(interiorObject)

            Action.onGaragePreview(data, index)
        else
            lib.showMenu("outside_unbought_garage_menu")
            lib.notify({title = "preview not started"})
        end
    end)

    lib.showMenu("outside_unbought_garage_menu")
end

function Action.onGaragePreview(data, garageInteriorIndex)
    local garageData = Config.Garages[data.garageIndex]
    local interiorGarages = Config.Interiors[garageData.interior]
    local options = {}
    local optionsCount = 0
    local selectedDecors = {}
    local garagePrice = garageData.price

    if interiorGarages[garageInteriorIndex].decors then
        for decorKey, decorData in pairs(interiorGarages[garageInteriorIndex].decors) do
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
                defaultIndex = 1,
                args = {decorKey = decorKey}
            }

            selectedDecors[decorKey] = values[1]
            garagePrice += decorData[values[1]]
        end
    end

    optionsCount += 1
    options[optionsCount] = {
        label = ("Price: $%s"):format(garagePrice),
        description = ("Click to buy this garage for $%s"):format(garagePrice),
        args = {decors = selectedDecors},
        close = false
    }

    lib.registerMenu({
        id = "preview_garage",
        title = ("%s - %s"):format(Shared.currentResourceName, interiorGarages[garageInteriorIndex].label),
        disableInput = true,
        canClose = true,
        options = options,
        onSideScroll = function(selected, scrollIndex, args)
            local currentDecorName = options[selected].values[scrollIndex]
            local previousDecorPrice = interiorGarages[garageInteriorIndex].decors[args.decorKey][selectedDecors[args.decorKey]]
            local currentDecorPrice = interiorGarages[garageInteriorIndex].decors[args.decorKey][currentDecorName]

            selectedDecors[args.decorKey] = currentDecorName
            garagePrice -= previousDecorPrice
            garagePrice += currentDecorPrice

            lib.setMenuOptions("preview_garage", {
                label = ("Price: $%s"):format(garagePrice),
                description = ("Click to buy this garage for $%s"):format(garagePrice),
                args = {decors = selectedDecors},
                close = false
            }, optionsCount)
        end,
        onClose = function(keyPressed)
            if keyPressed then
                StopGaragePreview()
                Action.openUnboughtGarageMenu(data)
            end
        end
    },
    function(_, _, args)
        if args.decors then
            local response, message = BuyGarage(data.garageIndex, garageInteriorIndex, selectedDecors)
            if response then
                StopGaragePreview()
                zone.onGarageInsideZoneEnter(data)
            else
                lib.notify({title = message})
            end
        end
    end)

    lib.showMenu("preview_garage")
end