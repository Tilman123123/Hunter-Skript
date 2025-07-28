function GrantLoot(animalType)
    if animalType == "deer" then
        print("Du erhältst 2x Wildfleisch.")
    elseif animalType == "boar" then
        print("Du erhältst 1x Wildleder.")
    else
        print("Du erhältst 1x allgemeines Loot.")
    end
end

function GrantLoot(animalType)
    local loot = LOOT_TABLE[animalType]
    if loot then
        print(("Du erhältst %dx %s."):format(loot.count, loot.item))
    else
        print("Kein Loot gefunden.")
    end
end

function GrantLoot(animalType)
    local loot = LOOT_TABLE[animalType]
    if loot then
        TriggerServerEvent("hunt:giveReward", loot.item, loot.count)
    else
        print("Kein Loot definiert.")
    end
end
