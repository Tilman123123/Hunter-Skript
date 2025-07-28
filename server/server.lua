-- server/server.lua

local db = require("server.database_handler")

-- Spieler-Events
AddEventHandler("playerDropped", function(reason)
    local src = source
    print(("Player %s left the server (%s)"):format(src, reason))
end)

-- Debug-Command
RegisterCommand("huntdebug", function(source, args, raw)
    local src = source
    TriggerClientEvent("hunter:client:debugInfo", src)
end, true)

-- Verkauf loggen
RegisterNetEvent("hunter:server:logSell", function(item, price)
    local src = source
    print(("Player %s sold %s for $%s"):format(src, item, price))
end)

-- Sound an Client senden
RegisterNetEvent("hunt:playSound")
AddEventHandler("hunt:playSound", function(soundName)
    TriggerClientEvent("hunt:playClientSound", source, soundName)
end)

-- Tier getötet
RegisterNetEvent("hunter:animalKilled", function(animalType, reward, dropItem)
    local src = source
    if db and db.saveKill then
        db.saveKill(src, animalType, reward, dropItem)
    else
        print("[Fehler] DB-Modul nicht geladen.")
    end

    -- Geld & XP geben
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        xPlayer.addMoney(reward)
        TriggerEvent("hunter:addXP", 10)
        print(("Spieler %s erhielt $%s für %s"):format(src, reward, animalType))
    end
end)

-- Einzelverkauf
RegisterNetEvent('hunter:sell')
AddEventHandler('hunter:sell', function(animal)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local config = Config.Rewards[animal]

    if xPlayer and config then
        local count = xPlayer.getInventoryItem(config).count or 0
        local price = Config.AnimalRewards[animal] or 100

        if count > 0 then
            xPlayer.removeInventoryItem(config, 1)
            xPlayer.addMoney(price)
            TriggerEvent("hunter:server:logSell", config, price)
        else
            print(("Spieler %s hat kein %s"):format(src, config))
        end
    else
        print("[Fehler] Verkauf fehlgeschlagen (ESX oder Config fehlerhaft)")
    end
end)

-- Alles verkaufen
RegisterNetEvent('hunter:sellAll')
AddEventHandler('hunter:sellAll', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local total = 0

    if xPlayer then
        for animal, item in pairs(Config.Rewards) do
            local amount = xPlayer.getInventoryItem(item).count or 0
            local price = Config.AnimalRewards[animal] or 100

            if amount > 0 then
                xPlayer.removeInventoryItem(item, amount)
                total += (amount * price)
            end
        end

        if total > 0 then
            xPlayer.addMoney(total)
            print(("Spieler %s hat für %s$ verkauft"):format(src, total))
        else
            print(("Spieler %s hatte nichts zu verkaufen"):format(src))
        end
    else
        print("[Fehler] Spieler nicht gefunden (ESX)")
    end
end)

-- Admin-Spawnbefehl (Demo)
RegisterCommand("startHunt", function(source)
    SpawnRandomAnimal()
end, false)

-- Missionen laden
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
