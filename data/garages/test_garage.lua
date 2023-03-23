table.insert(Config.Garages, {
    label = "Arcadius Garages",
    interior = "arcadius_garages",
    price = 10000,
    points = {
        vector3(-132.51, -686.23, 110.0),
        vector3(-233.7, -649.28, 110.0),
        vector3(-198.83, -553.43, 110.0),
        vector3(-79.36, -541.4, 110.0)

    },
    points_thickness = 170,
    blip = {
        active = true,
        type = 106,
        color = 27,
        size = 0.8
    },
    gates = {
        {
            outside = {
                coords = vector3(-145.75, -580.11, 32.42),
                spawns = {
                    vector4(-138.06, -586.77, 31.78, 68.72),
                }
            },
            inside = vector4(-198.6, -577.91, 136.0, 224.22),
        }
    }
})