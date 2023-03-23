---@class xGarage
---@field owner string
---@field coords vector3
---@field ipl string
---@field interiorId number
---@field decors table
---@field parkings xParking[]
---@field capacity number
---@field vehicles table

Garage = {}
setmetatable(Garage, {
    __index = Garage
})

---@param owner string
---@param coords vector3
---@param ipl string
---@param interiorId number
---@param decors table
---@param parkings table<number, vector4>
---@return xGarage
function Garage:new(owner, coords, ipl, interiorId, decors, parkings)
    local object = {}
    setmetatable(object, Garage)
    object.owner = owner
    object.coords = coords
    object.ipl = ipl
    object.interiorId = interiorId
    object.decors = decors
    object.parkings = setupParkings(parkings)
    object.capacity = #object.parkings
    object.vehicles = {}
    return object
end

---@param vehicleModel string
---@param vehicleProps table
---@param parkingIndex? number
---@return boolean, string
function Garage:addVehicle(vehicleModel, vehicleProps, parkingIndex)
    local self = self --[[@as xGarage]]
    if #self.vehicles == self.capacity then return false, "garage_is_full" end

    if parkingIndex then
        if self.parkings[parkingIndex]?.occupied then return false, "parking_is_occupied" end
    else
        for i = 1, #self.parkings do
            if not self.parkings[i].occupied then
                parkingIndex = i
                break
            end
        end
    end

    if not parkingIndex or parkingIndex > #self.parkings then return false, "parking_not_exists" end
    
    self.parkings[parkingIndex].occupied = true
    table.insert(self.vehicles, {model = vehicleModel, props = vehicleProps, parking = parkingIndex})

    return true, "successful"
end

---@param parkingIndex? number
---@return boolean, string
function Garage:removeVehicle(parkingIndex)
    local self = self --[[@as xGarage]]
    if #self.vehicles == 0 then return false, "garage_is_empty" end

    if parkingIndex > #self.parkings then return false, "parking_not_exists" end

    if not self.parkings[parkingIndex]?.occupied then return false, "parking_is_not_occupied" end
    
    self.parkings[parkingIndex].occupied = false
    table.remove(self.vehicles, parkingIndex)

    return true, "successful"
end

---@return string
function Garage:getOwner()
    local self = self --[[@as xGarage]]
    return self.owner
end