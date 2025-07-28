-- client/sell.lua

RegisterCommand("verkaufen", function()
    TriggerServerEvent("hunter:sellItems")
end, false)

-- Optional: Du kannst hier auch einen NPC oder ein Target verwenden,
-- um den Verkauf per Interaktion zu starten.

function SellAnimal(animal)
    TriggerServerEvent("hunt:sellAnimal", animal)
end
