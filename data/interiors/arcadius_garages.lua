Config.Interiors["arcadius_garages"] = {
    {
        label = "Arcadius Garage South",
        interiorId = 253441,
        ipl = "imp_dt1_02_cargarage_a",
        coords = vector4(-198.6, -577.91, 136.0, 224.22),
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
            -- 1st floor
            vector4(-188.307693, -574.312073, 135.585327, 232.440948),
            vector4(-183.626373, -572.373596, 135.585327, 189.921265),
            vector4(-179.169220, -572.953857, 135.585327, 161.574799),
            vector4(-175.015381, -575.090088, 135.585327, 133.228333),
            vector4(-172.905487, -579.389038, 135.585327, 96.377945),
            vector4(-173.156036, -585.019775, 135.585327, 65.196854),
            -- 2nd floor
            vector4(-188.307693, -574.312073, 140.926758, 232.440948),
            vector4(-183.626373, -572.373596, 140.926758, 189.921265),
            vector4(-179.169220, -572.953857, 140.926758, 161.574799),
            vector4(-175.015381, -575.090088, 140.926758, 133.228333),
            vector4(-172.905487, -579.389038, 140.926758, 96.377945),
            vector4(-173.156036, -585.019775, 140.926758, 65.196854),
            -- 3rd floor
            vector4(-188.307693, -574.312073, 146.268188, 232.440948),
            vector4(-183.626373, -572.373596, 146.268188, 189.921265),
            vector4(-179.169220, -572.953857, 146.268188, 161.574799),
            vector4(-175.015381, -575.090088, 146.268188, 133.228333),
            vector4(-172.905487, -579.389038, 146.268188, 96.377945),
            vector4(-173.156036, -585.019775, 146.268188, 65.196854),
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
    {
        label = "Arcadius Garage South-East",
        interiorId = 253697,
        ipl = "imp_dt1_02_cargarage_b",
        coords = vector4(-124.77, -569.08, 136.0, 266.5),
        object = "GetImportCEOGarage1Object",
        func = {
            clear = function(object)
                object.Part.Clear()
            end,
            loadDefault = function(object)
                object.Part.Load(object.Part.Garage2)
                object.Style.Set(object.Part.Garage2, object.Style.plain)
                object.Numbering.Set(object.Part.Garage2, object.Numbering.Level2.style1)
                object.Lighting.Set(object.Part.Garage2, object.Lighting.none, true)
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
                    object.Style.Set(object.Part.Garage2, decor, true)
                end,
                garage_decor_01 = 1000,
                garage_decor_02 = 0,
                garage_decor_03 = 1000,
                garage_decor_04 = 1000
            },
            numbering = {
                set = function(object, decor)
                    object.Numbering.Set(object.Part.Garage2, decor, true)
                end,
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
                set = function(object, decor)
                    object.Lighting.Set(object.Part.Garage2, decor, true)
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
    {
        label = "Arcadius Garage West",
        interiorId = 253953,
        ipl = "imp_dt1_02_cargarage_c",
        coords = vector4(-133.25, -623.19, 136.0, 148.5),
        object = "GetImportCEOGarage1Object",
        func = {
            clear = function(object)
                object.Part.Clear()
            end,
            loadDefault = function(object)
                object.Part.Load(object.Part.Garage3)
                object.Style.Set(object.Part.Garage3, object.Style.plain)
                object.Numbering.Set(object.Part.Garage3, object.Numbering.Level3.style1)
                object.Lighting.Set(object.Part.Garage3, object.Lighting.none, true)
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
                    object.Style.Set(object.Part.Garage3, decor, true)
                end,
                garage_decor_01 = 1000,
                garage_decor_02 = 0,
                garage_decor_03 = 1000,
                garage_decor_04 = 1000
            },
            numbering = {
                set = function(object, decor)
                    object.Numbering.Set(object.Part.Garage3, decor, true)
                end,
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
                set = function(object, decor)
                    object.Lighting.Set(object.Part.Garage3, decor, true)
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
    {
        label = "Arcadius Mod Garage",
        interiorId = 254209,
        ipl = "imp_dt1_02_modgarage",
        coords = vector4(-139.55, -588.42, 167.0, 138.0),
        object = "GetImportCEOGarage1Object",
        func = {
            clear = function(object)
                object.ModShop.Floor.Clear()
            end,
            loadDefault = function(object)
                object.ModShop.Floor.Set(object.ModShop.Floor.default, true)
            end,
        },
        spawns = {
            vector4(0, 0, 0, 0),
            vector4(0, 0, 0, 0),
            vector4(0, 0, 0, 0),
        },
        decors = {
            floor = {
                set = function(object, decor)
                    object.ModShop.Floor.Set(decor, true)
                end,
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