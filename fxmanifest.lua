fx_version 'cerulean'
game 'gta5'

author 'Dein Name'
description 'Komplettes Jagd-Skript mit UI, NPCs, Blips, Animationen etc.'
version '1.0.0'

-- Client Scripts
client_scripts {
    'client/blips.lua',
    'client/client.lua',
    'client/npc_spawn.lua',
    'client/sounds.lua',
    'client/target.lua',
    'client/ui.lua',
    'client/zones.lua'
}

-- Daten & Metadateien
files {
    'data/animations.meta',
    'data/animation.meta',
    'data/animation.json',
    'data/animals.meta'
}

data_file 'VEHICLE_METADATA_FILE' 'data/animals.meta'

client_scripts {
    'client/blips.lua',
    'client/client.lua',
    'client/npc_spawn.lua',
    'client/sounds.lua',
    'client/target.lua',
    'client/ui.lua',
    'client/zones.lua'
}

files {
    'data/animations.meta',
    'data/animation.meta',
    'data/animation.json',
    'data/animals.meta'
}

data_file 'VEHICLE_METADATA_FILE' 'data/animals.meta'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

shared_script 'shared/animals.lua'

'client/marker.lua',
'client/blip.lua',
'client/loot.lua',
'client/cooldown.lua',
'client/progressbar.lua',
