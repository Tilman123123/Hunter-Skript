-- server/collect.lua
-- Verarbeitung der Tier-Sammel-Events nach dem Abschuss

local itemNames = {
    deer = "deer_pelt",
    boar = "boar_meat",
    bear = "bear_claw",
    rabbit = "rabbit_foot",
    fox = "fox_fur",
    coyote = "coyote_tail",
    hen = "hen_feather",
    cow = "cow_hide",
    goat = "goat_horn"
}

RegisterNetEvent("hunter:collectAnimal", function(zone)
    local src = source
    local animal = GetClosestAnimalFromZone(zone) -- simuliert

    if animal and itemNames[animal] then
        local item = itemNames[animal]

        -- Beispiel: gib dem Spieler 1 Item
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            xPlayer.addInventoryItem(item, 1)
            print(("Spieler %s hat %s erhalten (Zone: %s)"):format(src, item, zone))
            TriggerClientEvent("hunter:notify", src, "Du hast ein Tier gesammelt: " .. item)
        else
            print("[Fehler] Spieler konnte nicht geladen werden.")
        end
    else
        TriggerClientEvent("hunter:notify", src, "Kein passendes Tier gefunden.")
    end
end)

-- Diese Funktion müsstest du selbst umsetzen, z.B. über gespeicherte Tiere in Zonen
function GetClosestAnimalFromZone(zone)
    -- Zum Testen gib z.B. immer 'deer' zurück
    return "deer"
end
