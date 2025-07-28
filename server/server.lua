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

-- Missionen laden (falls verwendet)
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

RegisterNetEvent("hunt:playSound")
AddEventHandler("hunt:playSound", function(soundName)
    TriggerClientEvent("hunt:playClientSound", source, soundName)
end)

RegisterCommand("startHunt", function(source)
    SpawnRandomAnimal()
end, false)

-- Verkauf einzelner Tiere
RegisterServerEvent('hunter:sell')
AddEventHandler('hunter:sell', function(animal)
    local src = source
    local price = 0

    if animal == 'deer' then
        price = 100
    elseif animal == 'boar' then
        price = 150
    end

    if price > 0 then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            xPlayer.addMoney(price)
            print(("Spieler %s hat %s verkauft und %s$ erhalten"):format(src, animal, price))
        else
            print(("[Fehler] Spieler %s konnte nicht über ESX geladen werden."):format(src))
        end
    else
        print(("[Warnung] Tier %s hat keinen festgelegten Preis."):format(tostring(animal)))
    end
end)

-- Verkauf aller gesammelten Items (Reh/Wildschwein)
RegisterServerEvent('hunter:sellAll')
AddEventHandler('hunter:sellAll', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local total = 0

    if xPlayer then
        local deerCount = xPlayer.getInventoryItem('deer_pelt').count or 0
        local boarCount = xPlayer.getInventoryItem('boar_pelt').count or 0

        local deerPrice = 100
        local boarPrice = 150

        if deerCount > 0 then
            total = total + (deerCount * deerPrice)
            xPlayer.removeInventoryItem('deer_pelt', deerCount)
        end

        if boarCount > 0 then
            total = total + (boarCount * boarPrice)
            xPlayer.removeInventoryItem('boar_pelt', boarCount)
        end

        if total > 0 then
            xPlayer.addMoney(total)
            print(("Spieler %s hat alles verkauft und %s$ erhalten"):format(src, total))
        else
            print(("Spieler %s hatte nichts zu verkaufen"):format(src))
        end
    else
        print("[Fehler] ESX-Spieler konnte nicht geladen werden.")
    end
end)
