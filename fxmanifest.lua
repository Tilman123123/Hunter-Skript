fx_version 'cerulean'
game 'gta5'

author 'Dein Name'
description 'Komplettes Jagd-Skript mit UI, NPCs, Blips, Animationen etc.'
version '1.0.0'

-- Shared config oder Daten
shared_script 'shared/animals.lua'

-- Client-Skripte
client_scripts {
    'client/client.lua',
    'client/blips.lua',
    'client/npc_spawn.lua',
    'client/sounds.lua',
    'client/target.lua',
    'client/ui.lua',
    'client/zones.lua',
    'client/marker.lua',
    'client/blip.lua',
    'client/loot.lua',
    'client/cooldown.lua',
    'client/progressbar.lua'
}

-- Server-Skripte
server_scripts {
    'server/server.lua',
    'server/xp.lua',
    'server/database_handler.lua',
    'server/missions/mission-01.lua',
    'server/missions/mission-02.lua',
    'server/missions/mission-03.lua',
    'server/missions/mission-04.lua',
    'server/missions/mission-05.lua',
    'server/missions/mission-06.lua',
    'server/missions/mission-07.lua',
    'server/missions/mission-08.lua',
    'server/missions/mission-09.lua',
    'server/missions/mission-10.lua',
    'server/missions/mission-config.lua',
    'server/missions/mission-manager.lua',
    'server/missions/mission-utils.lua'
}

-- UI-Dateien (NUI)
ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

-- Animations- & Tier-Metadaten
files {
    'data/animations.meta',
    'data/animation.meta',
    'data/animation.json',
    'data/animals.meta'
}

data_file 'VEHICLE_METADATA_FILE' 'data/animals.meta'
