Shared = {}

Shared.currentResourceName = GetCurrentResourceName()

Shared.State = {}

Shared.State.globalGarages = ("%s_%s"):format(Shared.currentResourceName, "globalGarages")

Shared.Callback = {}

Shared.Callback.startGaragePreview = ("%s:%s"):format(Shared.currentResourceName, "startGaragePreview")

Shared.Callback.stopGaragePreview = ("%s:%s"):format(Shared.currentResourceName, "stopGaragePreview")

Shared.Callback.buyGarage = ("%s:%s"):format(Shared.currentResourceName, "buyGarage")