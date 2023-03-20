fx_version  "cerulean"
use_experimental_fxv2_oal   "yes"
lua54       "yes"
game        "gta5"

name        "x-garage"
version     "0.0.0"
repository  "https://github.com/XProject/x-garage"
description "Project-X Garage: Garage System with GTA IPLs for FiveM's OneSync Infinity"

shared_scripts {
    "shared/*.lua",
}

server_scripts {
    "data/**/*.lua",
    "server/*.lua"
}

client_scripts {
    "client/*.lua",
}