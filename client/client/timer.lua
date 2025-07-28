Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if not CanHunt() then
            local remain = cooldown - (os.time() - lastHuntTime)
            print("Cooldown verbleibend: " .. remain .. " Sekunden")
        end
    end
end)
