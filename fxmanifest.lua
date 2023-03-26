fx_version  "cerulean"
use_experimental_fxv2_oal   "yes"
lua54       "yes"
game        "gta5"

name        "x-garage"
version     "0.0.0"
repository  "https://github.com/XProject/x-garage"
description "Project-X Garage: Garage System with GTA IPLs for FiveM's OneSync Infinity"

dependencies {
    "oxmysql",
    "bob74_ipl",
    "ox_lib",
    "x-instance"
}

shared_scripts {
    "@ox_lib/init.lua",
    "shared/*.lua",
    "data/interiors/*.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "data/**/*.lua",
    "server/*.lua"
}

client_scripts {
    "client/main.lua",
    "client/*.lua",
}