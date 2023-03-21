---@class xParking
---@field coords vector4
---@field occupied boolean

---@param parkings table<number, vector4>
---@return xParking[]
function setupParkings(parkings)
    local arrayOfParkings = {}  --[[@as xParking[] ]]

    for i = 1, #parkings do
        arrayOfParkings[i] = {coords = parkings[i], occupied = false}
    end
    
    return arrayOfParkings
end