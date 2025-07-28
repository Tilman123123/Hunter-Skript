RegisterNetEvent("hunt:playClientSound")
AddEventHandler("hunt:playClientSound", function(soundName)
    if soundName == "tracking" then
        PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    end
end)
