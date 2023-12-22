--[[ FX Information ]]--
fx_version 'cerulean'
game 'gta5'

--[[ Resource Information ]]--
name 'cm_supressor'
description 'Suppresses and removes specific vehicle and ped models in-game.'
version '1.0.0'
author 'coconutwatermelon'

--[[ Client Scripts ]]--
client_scripts {
    'client/main.lua',
}

--[[ Files ]]--
files {
    'models.json',
}

--[[ Data Files ]]--
data_file 'VEHICLE_MODEL_FILE' 'models.json'
data_file 'PED_MODEL_FILE' 'models.json'
