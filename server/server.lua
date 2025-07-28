-- server/server.lua

RegisterCommand("huntdebug", function(source, args, raw)
    local src = source
    TriggerClientEvent("hunter:client:debugInfo", src)
end, true)

AddEventHandler("playerDropped", function(reason)
    local src = source
    print(("Player %s left the server (%s)"):format(src, reason))
end)

RegisterNetEvent("hunter:server:logSell", function(item, price)
    local src = source
    print(("Player %s sold %s for $%s"):format(src, item, price))
end)

-- Lade alle Missionen
local missionFiles = {
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

for _, file in ipairs(missionFiles) do
    print("Lade Mission:", file)
    dofile(file)
end

local db = require("server.database_handler")

RegisterNetEvent("hunter:animalKilled", function(animalType, reward, dropItem)
    local src = source
    if db and db.saveKill then
        db.saveKill(src, animalType, reward, dropItem)
    else
        print("[Fehler] DB-Modul nicht geladen.")
    end
end)

RegisterNetEvent("hunt:animalKilled")
AddEventHandler("hunt:animalKilled", function(animalType)
    LogEvent("Tier getötet", "Typ: " .. animalType)
end)

RegisterNetEvent("hunt:animalKilled")
AddEventHandler("hunt:animalKilled", function(animalType)
    LogEvent("Tier getötet", "Typ: " .. animalType)
end)

RegisterNetEvent("hunt:playSound")
AddEventHandler("hunt:playSound", function(soundName)
    TriggerClientEvent("hunt:playClientSound", source, soundName)
end)

RegisterCommand("startHunt", function(source)
    SpawnRandomAnimal()
end, false)

RegisterServerEvent("hunt:sellAnimal")
AddEventHandler("hunt:sellAnimal", function(animalType)
    local src = source
    local reward = HuntingRewards[animalType]
    if reward then
        -- Füge Geld & Item hinzu (Dummy-System)
        print(("Player %s sold %s for $%s"):format(src, animalType, reward.money))
    end
end)
