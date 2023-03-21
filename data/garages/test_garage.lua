table.insert(Config.Locations, {
    coords = {
        points = {
            vector3(0, 0, 0),
        },
        thickness = 1
        
        sphere = vector3(0, 0, 0),
        radius = 1,
        
        box = vector3(0, 0, 0),
        rotation = vector3(0, 0, 0),
        size = vector3(0, 0, 0),
    },
    interior = "arcadius_garages",
    blip = {
        active = true,
        type = 106,
        color = 27,
        size = 0.8
    },
    gates = {
        {
            outside = {
                coords = vector3(0, 0, 0),
                spawns = {
                    vector4(0, 0, 0, 0),
                    vector4(0, 0, 0, 0)
                }
            },
            inside = {
                coords = vector3(0, 0, 0),
            }
        }
    }
})