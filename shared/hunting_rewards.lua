HuntingRewards = {
    a_c_deer = {
        item = "deer_meat",
        amount = 3,
        money = 150
    },
    a_c_boar = {
        item = "boar_meat",
        amount = 2,
        money = 100
    }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- Zeichne HUD-Elemente, z. B. Energie, Hunger, etc.
        DrawRect(0.9, 0.05, 0.1, 0.02, 0, 255, 0, 150) -- Beispiel-Anzeige
    end
end)
