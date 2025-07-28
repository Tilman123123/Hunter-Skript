RegisterNetEvent("hunter:showTrackNotification")
AddEventHandler("hunter:showTrackNotification", function(animal)
    SetNotificationTextEntry("STRING")
    AddTextComponentString("Spur gefunden: " .. animal)
    DrawNotification(false, false)
end)

-- Optional: zeige Hinweis bei Spur
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if IsPlayerNearAnimal() then
            ShowHint("Du bist einer Spur nahe! Drücke [E], um zu untersuchen.")
        end
    end
end)
