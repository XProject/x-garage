table.insert(Config.Garages, {
    label = "Arcadius Garages",
    interior = "arcadius_garages",
    price = 10000,
    points = {
        vector3(0, 0, 0),
        vector3(0, 0, 0),
        vector3(0, 0, 0),
    },
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
            inside = vector3(0, 0, 0),
        }
    }
})