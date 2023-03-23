Config.Interiors["arcadius_garages"] = {
    {-- #1 => -191.0133, -579.1428, 135.0000
        label = "Arcadius Garage 1",
        interiorId = 253441,
        ipl = "imp_dt1_02_cargarage_a",
        object = "GetImportCEOGarage1Object",
        func = {
            clear = function(object)
                object.Part.Clear()
            end,
            loadDefault = function(object)
                object.Part.Load(object.Part.Garage1)
                object.Style.Set(object.Part.Garage1, object.Style.plain)
                object.Numbering.Set(object.Part.Garage1, object.Numbering.Level1.style1)
                object.Lighting.Set(object.Part.Garage1, object.Lighting.none, true)
            end,
        },
        spawns = {
            vector4(0, 0, 0, 0),
            vector4(0, 0, 0, 0),
            vector4(0, 0, 0, 0),
        },
        decors = {
            styles = {
                set = function(object, decor)
                    object.Style.Set(object.Part.Garage1, decor, true)
                end,
                garage_decor_01 = 1000,
                garage_decor_02 = 0,
                garage_decor_03 = 1000,
                garage_decor_04 = 1000
            },
            numbering = {
                set = function(object, decor)
                    object.Numbering.Set(object.Part.Garage1, decor, true)
                end,
                numbering_style01_n1 = 0,
                numbering_style02_n1 = 0,
                numbering_style03_n1 = 0,
                numbering_style04_n1 = 0,
                numbering_style05_n1 = 0,
                numbering_style06_n1 = 0,
                numbering_style07_n1 = 0,
                numbering_style08_n1 = 0,
                numbering_style09_n1 = 0
            },
            lighting = {
                set = function(object, decor)
                    object.Lighting.Set(object.Part.Garage1, decor, true)
                end,
                [""] = 0,
                lighting_option01 = 1000,
                lighting_option02 = 1000,
                lighting_option03 = 1000,
                lighting_option04 = 1000,
                lighting_option05 = 1000,
                lighting_option06 = 1000,
                lighting_option07 = 1000,
                lighting_option08 = 1000,
                lighting_option09 = 1000
            }
        }
    },
    {-- #2 => -117.4989, -568.1132, 135.0000
        label = "Arcadius Garage 2",
        interiorId = 253697,
        ipl = "imp_dt1_02_cargarage_b",
        spawns = {
            vector4(0, 0, 0, 0),
            vector4(0, 0, 0, 0),
            vector4(0, 0, 0, 0),
        },
        decors = {
            styles = {
                garage_decor_01 = 1000,
                garage_decor_02 = 0,
                garage_decor_03 = 1000,
                garage_decor_04 = 1000
            },
            numbering = {
                numbering_style01_n2 = 0,
                numbering_style02_n2 = 0,
                numbering_style03_n2 = 0,
                numbering_style04_n2 = 0,
                numbering_style05_n2 = 0,
                numbering_style06_n2 = 0,
                numbering_style07_n2 = 0,
                numbering_style08_n2 = 0,
                numbering_style09_n2 = 0
            },
            lighting = {
                [""] = 0,
                lighting_option01 = 1000,
                lighting_option02 = 1000,
                lighting_option03 = 1000,
                lighting_option04 = 1000,
                lighting_option05 = 1000,
                lighting_option06 = 1000,
                lighting_option07 = 1000,
                lighting_option08 = 1000,
                lighting_option09 = 1000
            }
        }
    },
    {-- #3 => -117.4989, -568.1132, 135.0000
        label = "Arcadius Garage 3",
        interiorId = 253953,
        ipl = "imp_dt1_02_cargarage_c",
        spawns = {
            vector4(0, 0, 0, 0),
            vector4(0, 0, 0, 0),
            vector4(0, 0, 0, 0),
        },
        decors = {
            styles = {
                garage_decor_01 = 1000,
                garage_decor_02 = 0,
                garage_decor_03 = 1000,
                garage_decor_04 = 1000
            },
            numbering = {
                numbering_style01_n3 = 0,
                numbering_style02_n3 = 0,
                numbering_style03_n3 = 0,
                numbering_style04_n3 = 0,
                numbering_style05_n3 = 0,
                numbering_style06_n3 = 0,
                numbering_style07_n3 = 0,
                numbering_style08_n3 = 0,
                numbering_style09_n3 = 0
            },
            lighting = {
                [""] = 0,
                lighting_option01 = 1000,
                lighting_option02 = 1000,
                lighting_option03 = 1000,
                lighting_option04 = 1000,
                lighting_option05 = 1000,
                lighting_option06 = 1000,
                lighting_option07 = 1000,
                lighting_option08 = 1000,
                lighting_option09 = 1000
            }
        }
    },
    {-- #4 => -146.6166, -596.6301, 166.0000
        label = "Arcadius Mod Garage",
        interiorId = 254209,
        ipl = "imp_dt1_02_modgarage",
        spawns = {
            vector4(0, 0, 0, 0),
            vector4(0, 0, 0, 0),
            vector4(0, 0, 0, 0),
        },
        decors = {
            floor = {
                [""] = 0,
                floor_vinyl_01 = 1000,
                floor_vinyl_02 = 1000,
                floor_vinyl_03 = 1000,
                floor_vinyl_04 = 1000,
                floor_vinyl_05 = 1000,
                floor_vinyl_06 = 1000,
                floor_vinyl_07 = 1000,
                floor_vinyl_08 = 1000,
                floor_vinyl_09 = 1000,
                floor_vinyl_10 = 1000,
                floor_vinyl_11 = 1000,
                floor_vinyl_12 = 1000,
                floor_vinyl_13 = 1000,
                floor_vinyl_14 = 1000,
                floor_vinyl_15 = 1000,
                floor_vinyl_16 = 1000,
                floor_vinyl_17 = 1000,
                floor_vinyl_18 = 1000,
                floor_vinyl_19 = 1000,
            }
        }
    },
}