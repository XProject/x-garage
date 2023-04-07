Shared = {}

Shared.currentResourceName = GetCurrentResourceName()

Shared.State = {}

Shared.State.globalGarages = ("%s_%s"):format(Shared.currentResourceName, "globalGarages")

Shared.Callback = {}

Shared.Callback.startGaragePreview = ("%s:%s"):format(Shared.currentResourceName, "startGaragePreview")

Shared.Callback.stopGaragePreview = ("%s:%s"):format(Shared.currentResourceName, "stopGaragePreview")

Shared.Callback.hasGarage = ("%s:%s"):format(Shared.currentResourceName, "hasGarage")

Shared.Callback.buyGarage = ("%s:%s"):format(Shared.currentResourceName, "buyGarage")

Shared.Callback.getGarageDecors = ("%s:%s"):format(Shared.currentResourceName, "getGarageDecors")

function dumpTable(table, nb)
    if nb == nil then
        nb = 0
    end

    if type(table) == 'table' then
        local s = ''
        for i = 1, nb + 1, 1 do
            s = s .. "    "
        end

        s = '{\n'
        for k, v in pairs(table) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            for i = 1, nb, 1 do
                s = s .. "    "
            end
            s = s .. '[' .. k .. '] = ' .. dumpTable(v, nb + 1) .. ',\n'
        end

        for i = 1, nb, 1 do
            s = s .. "    "
        end

        return s .. '}'
    else
        return tostring(table)
    end
end