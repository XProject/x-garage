Menu = {}

function Menu.onGarageRequestToEnter(data)
    local garageData = Config.Garages[data.garageIndex]

    lib.registerMenu({
        id = "outside_garage_menu",
        title = Config.Locales.garage_system,
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
                Zone.onGarageInsideZoneEnter(data)
            end
        end
    },
    function(_, _, args)
        if args.menu == "outside_bought_garage_menu" then
            Menu.openBoughtGarageMenu(data)
        elseif args.menu == "outside_unbought_garage_menu" then
            Menu.openUnboughtGarageMenu(data)
        end
    end)

    lib.showMenu("outside_garage_menu")
end

function Menu.openBoughtGarageMenu(data)
    local garageData = Config.Garages[data.garageIndex]
    local interiorGarages = Config.Interiors[garageData.interior]
    local options = {}
    local optionsCount = 0

    for i = 1, #interiorGarages do
        if HasGarage(data.garageIndex, i) then
            optionsCount += 1
            options[optionsCount] = {
                label = ("Enter %s"):format(interiorGarages[i].label),
                args = {garageInteriorIndex = i}
            }
        end
    end

    if optionsCount == 0 then
        lib.notify({title = Config.Locales.garage_system, description = Config.Locales.no_bought_garages, type = "error"})
        return Menu.onGarageRequestToEnter(data)
    end

    lib.registerMenu({
        id = "outside_bought_garage_menu",
        title = Config.Locales.garage_system,
        disableInput = true,
        canClose = true,
        options = options,
        onClose = function(keyPressed)
            if keyPressed then
                Menu.onGarageRequestToEnter(data)
            end
        end
    },
    function(_, _, args)
        EnterOwnGarage(data.garageIndex, args.garageInteriorIndex, {}) -- TODO: send proper selectedDecors
    end)

    lib.showMenu("outside_bought_garage_menu")
end

function Menu.openUnboughtGarageMenu(data)
    local garageData = Config.Garages[data.garageIndex]
    local interiorGarages = Config.Interiors[garageData.interior]
    local options = {}
    local optionsCount = 0

    for i = 1, #interiorGarages do
        if not HasGarage(data.garageIndex, i) then -- TODO: check for ownership of the garage to show un-bought ones
            optionsCount += 1
            options[optionsCount] = {
                label = ("Buy %s"):format(interiorGarages[i].label),
                args = {interiorIndex = i}
            }
        end
    end

    if optionsCount == 0 then
        lib.notify({title = Config.Locales.garage_system, description = Config.Locales.no_unbought_garages, type = "error"})
        return Menu.onGarageRequestToEnter(data)
    end

    lib.registerMenu({
        id = "outside_unbought_garage_menu",
        title = Config.Locales.garage_system,
        disableInput = true,
        canClose = true,
        options = options,
        onClose = function(keyPressed)
            if keyPressed then
                Menu.onGarageRequestToEnter(data)
            end
        end
    },
    function(_, _, args)
        local interiorIndex = args.interiorIndex
        FadeScreen(true)
        if StartGaragePreview(data.garageIndex, interiorIndex) then
            -- player is now instanced and teleported to the interior entrance
            if type(interiorGarages[interiorIndex].object) == "string" then
                interiorGarages[interiorIndex].object = exports["bob74_ipl"][interiorGarages[interiorIndex].object]()
            end

            local interiorObject = interiorGarages[interiorIndex].object

            interiorGarages[interiorIndex].func.clear(interiorObject)
            interiorGarages[interiorIndex].func.loadDefault(interiorObject)

            FadeScreen(false)
            Menu.onGaragePreview(data, interiorIndex)
        else
            FadeScreen(false)
            lib.showMenu("outside_unbought_garage_menu")
        end
    end)

    lib.showMenu("outside_unbought_garage_menu")
end

function Menu.onGaragePreview(data, garageInteriorIndex)
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
                if decorName ~= "set" and type(decorData[decorName]) ~= "function" then
                    valuesCount += 1
                    values[valuesCount] = decorName
                end
            end

            optionsCount += 1
            options[optionsCount] = {
                label = decorKey,
                values = values,
                defaultIndex = 1,
                close = false,
                args = {decorKey = decorKey}
            }

            selectedDecors[decorKey] = values[1]
            garagePrice += decorData[values[1]]

            interiorGarages[garageInteriorIndex].decors[decorKey].set(interiorGarages[garageInteriorIndex].object, values[1])
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
        title = interiorGarages[garageInteriorIndex].label,
        disableInput = false,
        canClose = true,
        options = options,
        onSideScroll = function(selected, scrollIndex, args)
            local decorKey = args.decorKey
            local decors = interiorGarages[garageInteriorIndex].decors[decorKey]
            local currentDecorName = options[selected].values[scrollIndex]
            local previousDecorPrice = decors[selectedDecors[decorKey]]
            local currentDecorPrice = decors[currentDecorName]

            selectedDecors[decorKey] = currentDecorName
            garagePrice -= previousDecorPrice
            garagePrice += currentDecorPrice

            lib.setMenuOptions("preview_garage", {
                label = ("Price: $%s"):format(garagePrice),
                description = ("Click to buy this garage for $%s"):format(garagePrice),
                args = {decors = selectedDecors},
                close = false
            }, optionsCount)
            lib.hideMenu(false)

            FadeScreen(true)
            decors.set(interiorGarages[garageInteriorIndex].object, currentDecorName)
            FadeScreen(false)

            -- until ox_lib updates
            lib.setMenuOptions("preview_garage", {
                label = decorKey,
                values = options[selected].values,
                defaultIndex = scrollIndex,
                close = false,
                args = {decorKey = decorKey}
            }, selected)
            lib.showMenu("preview_garage", selected)
            -- until ox_lib updates
        end,
        onClose = function(keyPressed)
            if keyPressed then
                FadeScreen(true)
                if StopGaragePreview() then
                    FadeScreen(false)
                else
                    FadeScreen(false)
                    lib.showMenu("preview_garage")
                end
            end
        end
    },
    function(_, _, args)
        if args.decors then
            local response, message = BuyGarage(data.garageIndex, garageInteriorIndex, selectedDecors)
            if response then
                lib.notify({title = Config.Locales.garage_system, description = message, type = "success"})
                lib.hideMenu()
                FadeScreen(true)
                while IsScreenFadedOut() do
                    if StopGaragePreview() then
                        FadeScreen(false)
                        break
                    end
                    Wait(1000)
                end
            else
                lib.notify({title = Config.Locales.garage_system, description = message, type = "error"})
            end
        end
    end)

    lib.showMenu("preview_garage")
end