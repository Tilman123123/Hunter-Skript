Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local weather = GetWeatherTypeTransition()
        print("Aktuelles Wetter:", weather)
        -- Wettereffekte beeinflussen Gameplay (Beispiel: Ausdauerreduktion bei Regen)
    end
end)
