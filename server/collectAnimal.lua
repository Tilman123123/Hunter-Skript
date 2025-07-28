-- server/collectAnimal.lua
-- Loot beim Sammeln eines Tiers im Jagdgebiet

RegisterNetEvent("hunter:collectAnimal", function(zone)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    -- Beispiel-Loot (du kannst es erweitern oder dynamisch gestalten)
    local collected = {
        { item = "meat", count = math.random(1, 3) },
        { item = "bone", count = 1 }
    }

    for _, entry in ipairs(collected) do
        xPlayer.addInventoryItem(entry.item, entry.count)
    end

    -- XP als Bonus fürs Sammeln
    TriggerEvent("hunter:addXP", 5)

    print(("Spieler %s hat in %s gesammelt und Loot erhalten."):format(src, zone))
end)
